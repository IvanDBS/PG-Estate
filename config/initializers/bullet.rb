if defined?(Bullet)
  Rails.application.config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
    
    # Detect N+1 queries
    Bullet.n_plus_one_query_enable = true
    
    # Detect eager-loaded associations which are not used
    Bullet.unused_eager_loading_enable = true
    
    # Detect unnecessary eager loading
    Bullet.counter_cache_enable = true
  end
end 