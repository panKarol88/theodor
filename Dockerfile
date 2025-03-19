# Dev stage
FROM ruby:3.3.2 AS rupert
WORKDIR /rupert
ENV RAILS_ENV=development

# Install specific Bundler version
RUN gem install bundler:2.5.11

COPY . .
RUN bundle install

EXPOSE 3000
