FROM ruby:2

RUN apt-get update && apt-get install sqlite3

WORKDIR /app
COPY Gemfile* /app
RUN bundle install

COPY . /app

EXPOSE 2300
