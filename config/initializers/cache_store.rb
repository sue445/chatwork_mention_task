Rails.application.config.cache_store = :mem_cache_store, Global.memcached.servers, { namespace: Rails.env }
