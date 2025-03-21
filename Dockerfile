# Dev stage
FROM ruby:3.3.2 AS rupert
WORKDIR /rupert
ENV RAILS_ENV=development

# Install curl and Node.js dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && npm install -g yarn

# Install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.5.11
RUN bundle install

# Then copy the rest of the application
COPY . .

EXPOSE 20240
