FROM ruby:2

RUN apt-get update && apt-get install -y sqlite3 youtube-dl

WORKDIR /app
COPY Gemfile /app/
RUN bundle install

COPY . /app

RUN bundle exec hanami assets precompile HANAMI_ENV=production

EXPOSE 2300
