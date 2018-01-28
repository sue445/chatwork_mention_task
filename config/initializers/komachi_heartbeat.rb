# HEROKU_SLUG_COMMIT is available on Heroku
# c.f. https://devcenter.heroku.com/articles/dyno-metadata
Rails.application.config.heartbeat.application_version = ENV["HEROKU_SLUG_COMMIT"]

Rails.application.config.heartbeat.application_name = "ChatworkMentionTask"
Rails.application.config.heartbeat.memcached_check_enabled = true
Rails.application.config.heartbeat.memcached_server_names = Global.memcached.servers
