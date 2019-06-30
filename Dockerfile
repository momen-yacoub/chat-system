FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /docker_insta_task
WORKDIR /docker_insta_task

COPY Gemfile /docker_insta_task/Gemfile
COPY Gemfile.lock /docker_insta_task/Gemfile.lock

ENV BUNDLER_VERSION=2.0.1

RUN gem install bundler --version 2.0.1 && bundle install

COPY . /docker_insta_task