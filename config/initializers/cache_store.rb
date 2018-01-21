Rails.application.config.cache_store = :mem_cache_store, Global.memcached.servers, Global.memcached.options.to_hash.symbolize_keys
