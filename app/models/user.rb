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
  include User::ApiModule
  include User::ReminderModule

  # c.f. http://download.chatwork.com/ChatWork_API_Documentation.pdf
  REFRESH_TOKEN_EXPIRES_IN = 14.days

  REFRESH_TOKEN_EXPIRES_REMIND = 1.days

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
end
