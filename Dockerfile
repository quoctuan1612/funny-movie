FROM ruby:3.1.0

RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client && npm install -g yarn

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app
