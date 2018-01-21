params = Global.memcached.options.to_hash.symbolize_keys.reverse_merge(
  key: "_chatwork_mention_task_session",
  memcache_server: Global.memcached.servers,
  namespace: Rails.env,
)

Rails.application.config.session_store :mem_cache_store, params
