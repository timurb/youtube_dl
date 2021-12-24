Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_TOKEN']
  config.environment = Hanami.env
  config.framework = "Hanami: #{Hanami::VERSION}"
  config.root = Dir.pwd
end
