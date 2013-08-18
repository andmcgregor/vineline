Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['VINELINE_KEY'], ENV['VINELINE_SECRET']
end