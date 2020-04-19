FROM ruby:2.7.1

RUN mkdir /app
COPY backend/Gemfile /app/
COPY backend/Gemfile.lock /app/

WORKDIR /app
RUN bundle install

