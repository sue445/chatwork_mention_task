# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`id`**                         | `bigint(8)`        | `not null, primary key`
# **`account_id`**                 | `integer(4)`       | `not null`
# **`room_id`**                    | `integer(4)`       | `not null`
# **`name`**                       | `string`           | `not null`
# **`avatar_image_url`**           | `string`           | `not null`
# **`access_token`**               | `string`           | `not null`
# **`refresh_token`**              | `string`           | `not null`
# **`access_token_expires_at`**    | `datetime`         | `not null`
# **`created_at`**                 | `datetime`         | `not null`
# **`updated_at`**                 | `datetime`         | `not null`
# **`webhook_token`**              | `string`           |
# **`account_type`**               | `integer(4)`       | `default("chatwork_com"), not null`
# **`refresh_token_reminded_at`**  | `datetime`         |
# **`locale`**                     | `string`           | `default("en"), not null`
# **`time_zone`**                  | `string`           | `default("UTC"), not null`
#
# ### Indexes
#
# * `index_users_on_account_id` (_unique_):
#     * **`account_id`**
#

FactoryBot.define do
  factory :user do
    sequence(:account_id) {|n| n }
    room_id                  { Faker::Number.number(8) }
    name                     { Faker::Precure.human_name }
    avatar_image_url         { Faker::Avatar.image }
    access_token             { Faker::Internet.password }
    refresh_token            { Faker::Internet.password }
    access_token_expires_at  { 30.minutes.from_now }
  end
end
