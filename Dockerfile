FROM ruby:2.3.1

RUN apt-get update -qq
RUN apt-get install -y build-essential

# Postgres
RUN apt-get install -y  libpq-dev

# JS runtime
RUN apt-get install -y  nodejs


# Update rubygems
RUN gem install rubygems-update
RUN update_rubygems
RUN gem update --system

# for nokogiri ??
# RUN apt-get install -y libxml2-dev libxslt1-dev


ENV APP_HOME /humanifymvp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler
# Bundle cache
RUN export BUNDLE_PATH=$(which bundle)
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile
ENV BUNDLE_JOBS=2

# adds gemfile and gemfile.lock to repo before app to cache gem changes
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle check || bundle install

# enable utf8 in irb
ENV LANG C.UTF-8

ADD . $APP_HOME
