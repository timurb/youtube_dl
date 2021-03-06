require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require 'rollbar/middleware/rack'
require_relative '../lib/youtube_dl'
require_relative '../apps/web/application'
require_relative './sidekiq'

Hanami.configure do
  middleware.use Rollbar::Middleware::Rack

  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/youtube_dl_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/youtube_dl_development'
    #    adapter :sql, 'mysql://localhost/youtube_dl_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/youtube_dl/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: ENV['LOG_LEVEL'] || :info, formatter: :json, filter: []

#     mailer do
#       delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
#     end
  end
end
