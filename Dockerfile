FROM ruby:3.3.10
RUN apt-get update -qq && apt-get install -y libpq-dev
RUN mkdir /BSDSec
WORKDIR /BSDSec
ADD Gemfile Gemfile.lock /BSDSec/
RUN bundle update --bundler
RUN bundle install
ADD . /BSDSec
