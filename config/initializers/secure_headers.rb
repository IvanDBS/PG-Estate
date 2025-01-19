SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true,
    httponly: true,
    samesite: {
      strict: true
    }
  }

  # Add nonce to allow inline scripts from importmap
  policy = {
    default_src: %w('none'),
    base_uri: %w('self'),
    child_src: %w('self'),
    connect_src: %w('self' ws: wss:),
    font_src: %w('self' https: data:),
    form_action: %w('self'),
    frame_ancestors: %w('none'),
    frame_src: %w('self'),
    img_src: %w('self' https: data:),
    manifest_src: %w('self'),
    media_src: %w('self'),
    object_src: %w('none'),
    script_src: %w('self' 'unsafe-inline' 'unsafe-eval' https:),
    style_src: %w('self' 'unsafe-inline' https:),
    worker_src: %w('self'),
    upgrade_insecure_requests: true
  }

  config.csp = policy.merge(
    script_src: policy.fetch(:script_src) + ["'unsafe-inline'"],
    style_src: policy.fetch(:style_src) + ["'unsafe-inline'"]
  )

  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w(origin-when-cross-origin strict-origin-when-cross-origin)

  # HSTS settings
  config.hsts = "max-age=31536000; includeSubDomains"
end 