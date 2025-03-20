# Dev stage
FROM ruby:3.3.2 AS rupert
WORKDIR /rupert
ENV RAILS_ENV=development

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.5.11
RUN bundle install

# Then copy the rest of the application
COPY . .

EXPOSE 3000
