# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`id`**                        | `bigint(8)`        | `not null, primary key`
# **`account_id`**                | `integer`          | `not null`
# **`room_id`**                   | `integer`          | `not null`
# **`name`**                      | `string`           | `not null`
# **`avatar_image_url`**          | `string`           | `not null`
# **`access_token`**              | `string`           | `not null`
# **`refresh_token`**             | `string`           | `not null`
# **`access_token_expires_at`**   | `datetime`         | `not null`
# **`refresh_token_expires_at`**  | `datetime`         | `not null`
# **`created_at`**                | `datetime`         | `not null`
# **`updated_at`**                | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_account_id` (_unique_):
#     * **`account_id`**
#

class User < ApplicationRecord
  # c.f. http://download.chatwork.com/ChatWork_API_Documentation.pdf
  REFRESH_TOKEN_EXPIRES_IN = 14.days
end
