class Rack::Attack
  ### Configure Cache ###
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ### Throttle Spammy Clients ###
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  ### Prevent Brute-Force Login Attacks ###
  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      req.ip
    end
  end

  throttle('logins/email', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      req.params['email'].to_s.downcase.gsub(/\s+/, '')
    end
  end

  ### Prevent Brute-Force Password Reset Attacks ###
  throttle('password_reset/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/password' && req.post?
      req.ip
    end
  end

  ### Block Suspicious Requests ###
  blocklist('block suspicious requests') do |req|
    Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 5, findtime: 1.minutes, bantime: 1.hour) do
      req.path =~ /\.(php|asp|aspx|jsp|cgi)$/ ||
      req.path.include?('/etc/passwd') ||
      req.path.include?('wp-admin') ||
      req.path.include?('wp-login')
    end
  end

  ### Custom Error Response ###
  self.throttled_response = lambda do |env|
    [ 429, # status
      {'Content-Type' => 'application/json'}, # headers
      [{ error: "Too many requests. Please try again later." }.to_json] # body
    ]
  end
end 