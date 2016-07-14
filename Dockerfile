FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /humanify
WORKDIR /humanify
ADD Gemfile /humanify/Gemfile
ADD Gemfile.lock /humanify/Gemfile.lock
RUN bundle install

# enable utf8 in irb
ENV LANG C.UTF-8

ADD . /humanify
