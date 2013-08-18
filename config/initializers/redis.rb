uri = URI.parse(ENV['REDIS'])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)