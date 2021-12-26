require 'sidekiq/web'

Sidekiq::Web.set :session_secret, YoutubeDl::Config.new.session_secret


# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

root to: 'home#index'

resources :videos, only: [:index, :new, :create, :destroy, :update]
mount Sidekiq::Web, at: '/sidekiq'