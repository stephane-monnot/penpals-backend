FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential && apt-get install -y --no-install-recommends postgresql-client && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
    BUNDLE_JOBS=2

RUN bundle install --retry 3

ADD . $APP_HOME