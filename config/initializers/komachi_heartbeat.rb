# SOURCE_VERSION is available on Heroku
# c.f. https://devcenter.heroku.com/changelog-items/630
Rails.application.config.heartbeat.application_version = ENV["SOURCE_VERSION"]

Rails.application.config.heartbeat.application_name = "ChatworkMentionTask"
Rails.application.config.heartbeat.memcached_check_enabled = true
Rails.application.config.heartbeat.memcached_server_names = Global.memcached.servers
