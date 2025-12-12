FROM ruby:3.4.1

# Install dependencies including jemalloc for memory optimization
RUN apt-get update -qq && apt-get install -y libpq-dev libjemalloc2

# Configure jemalloc for better memory allocation
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
ENV MALLOC_CONF=dirty_decay_ms:1000,narenas:2,background_thread:true

RUN mkdir /BSDSec
WORKDIR /BSDSec
ADD Gemfile Gemfile.lock /BSDSec/
RUN bundle update --bundler
RUN bundle install
ADD . /BSDSec
