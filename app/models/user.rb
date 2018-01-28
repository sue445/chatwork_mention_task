# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`id`**                         | `bigint(8)`        | `not null, primary key`
# **`account_id`**                 | `integer`          | `not null`
# **`room_id`**                    | `integer`          | `not null`
# **`name`**                       | `string`           | `not null`
# **`avatar_image_url`**           | `string`           | `not null`
# **`access_token`**               | `string`           | `not null`
# **`refresh_token`**              | `string`           | `not null`
# **`access_token_expires_at`**    | `datetime`         | `not null`
# **`refresh_token_expires_at`**   | `datetime`         | `not null`
# **`created_at`**                 | `datetime`         | `not null`
# **`updated_at`**                 | `datetime`         | `not null`
# **`webhook_token`**              | `string`           |
# **`account_type`**               | `integer`          | `default("chatwork_com"), not null`
# **`refresh_token_reminded_at`**  | `datetime`         |
#
# ### Indexes
#
# * `index_users_on_account_id` (_unique_):
#     * **`account_id`**
#

require "chatwork/chatwork_error"

class User < ApplicationRecord
  # c.f. http://download.chatwork.com/ChatWork_API_Documentation.pdf
  REFRESH_TOKEN_EXPIRES_IN = 14.days

  auto_strip_attributes :webhook_token

  enum account_type: { chatwork_com: 0, kddi_chatwork: 1 }

  def self.register(auth_hash)
    user = User.find_or_initialize_by(account_id: auth_hash[:uid]) do |u|
      u.room_id = auth_hash[:extra][:raw_info][:room_id]
    end
    user.name                    = auth_hash[:info][:name]
    user.avatar_image_url        = auth_hash[:info][:image]
    user.access_token            = auth_hash[:credentials][:token]
    user.refresh_token           = auth_hash[:credentials][:refresh_token]
    user.access_token_expires_at = Time.zone.at(auth_hash[:credentials][:expires_at])

    user.refresh_token_expires_at = REFRESH_TOKEN_EXPIRES_IN.from_now if user.refresh_token_changed?

    user.save!

    user
  end

  def rooms
    all_rooms = with_retryable do
      ChatWork::Room.get
    end

    all_rooms.select { |room| ["my", "group"].include?(room.type) && ["admin", "member"].include?(room.role) }.sort_by(&:name)
  end

  def room_name
    room = with_retryable do
      ChatWork::Room.find(room_id: room_id)
    end

    return "My Chat" if room.type == "my"
    room.name
  end

  def create_task(room_id:, body:, to_ids:, limit_at: nil)
    with_retryable do
      ChatWork::Task.create(room_id: room_id, body: body, to_ids: to_ids, limit: limit_at&.to_i)
    end
  end

  def create_my_task(body, limit_at: nil)
    create_task(room_id: room_id, body: body, to_ids: account_id, limit_at: limit_at)
  end

  def with_retryable
    set_token

    yield
  rescue ChatWork::AuthenticateError => error
    retry_count ||= 0
    retry_count += 1

    if retry_count == 1 && error.error == "invalid_token"
      refresh_access_token
      retry
    end

    raise
  end

  private

    def set_token
      ChatWork.access_token = access_token
    end

    def refresh_access_token
      tokens = ChatWork::Token.refresh_access_token(refresh_token)
      self.access_token = tokens[:access_token]
      self.refresh_token = tokens[:refresh_token]
      self.access_token_expires_at = tokens[:expires_in].to_i.seconds.from_now
      save!
    end
end
