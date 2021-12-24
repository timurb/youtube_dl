FROM ruby:2

RUN apt-get update && apt-get install -y sqlite3 youtube-dl

WORKDIR /app
COPY Gemfile Gemfile.lock /app
RUN bundle install

COPY . /app

EXPOSE 2300
