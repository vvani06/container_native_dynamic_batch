FROM ruby:2.7.1

RUN mkdir /app
COPY backend/Gemfile /app/
COPY backend/Gemfile.lock /app/

ENV RUBY_THREAD_VM_STACK_SIZE=10485760
ENV RUBYOPT="-W:no-deprecated -W:no-experimental"

WORKDIR /app
RUN bundle install

COPY backend/ /app/

