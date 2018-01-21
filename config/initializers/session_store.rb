Rails.application.config.session_store ActionDispatch::Session::CacheStore, expire_after: Global.memcached.session.expire_after
