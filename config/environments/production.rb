require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Ensure classes are cached for performance.
  config.cache_classes = true

  # Eager load code to improve performance.
  config.eager_load = true

  # Disable full error reports (to prevent security risks).
  config.consider_all_requests_local = false

  # Enable server timing (optional, for debugging)
  config.server_timing = false

  # Enable caching for better performance.
  config.action_controller.perform_caching = true
  config.action_controller.enable_fragment_cache_logging = false
  # config.cache_store = :memory_store # Consider using Redis or Memcached in production.

  # Serve static files from the public folder (only if using a CDN, otherwise set to false).
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Enable Active Storage for file uploads (use an external service in production).
  config.active_storage.service = :local # Change to S3, GCS etc.

  # Ensure mailer errors are raised (to debug email failures).
  config.action_mailer.raise_delivery_errors = true

  # Configure email sending using SMTP (use environment variables instead of hardcoded values).
  config.action_mailer.default_url_options = { host: ENV['DOMAIN'], protocol: "https" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    user_name: ENV['SMTP_USERNAME'], # Set in environment variables
    password: ENV['SMTP_PASSWORD'], # Set in environment variables
    authentication: "plain",
    enable_starttls_auto: true
  }
  config.action_mailer.perform_deliveries = true

  # Force SSL for security
  config.force_ssl = true

  # Minify assets and enable asset fingerprinting for better performance.
  config.assets.compile = false
  config.assets.digest = true

  # Log level (consider using :info or :warn in production).
  config.log_level = :info

  # Use a different logger for distributed setups (use STDOUT if using a containerized service like Railway).
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    config.logger = ActiveSupport::Logger.new(STDOUT)
  end

  # Database migrations should not affect live traffic.
  config.active_record.dump_schema_after_migration = false

  # Use Redis for Action Cable in production
  config.action_cable.url = ENV['ACTION_CABLE_URL']
  config.action_cable.allowed_request_origins = [ENV['DOMAIN']]

  # Use Redis as the cache store in production (if Redis is configured)
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
  config.cache_store = :redis_cache_store, { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }

end

