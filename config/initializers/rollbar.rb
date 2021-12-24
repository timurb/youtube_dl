Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_TOKEN']
  config.use_sidekiq 'queue' => 'default'
  config.environment = Hanami.env
  config.framework = "Hanami: #{Hanami::VERSION}"
  config.root = Dir.pwd
end
