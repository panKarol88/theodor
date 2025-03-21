# Dev stage
FROM ruby:3.3.2 AS rupert
WORKDIR /rupert
ENV RAILS_ENV=development

# Install curl, Node.js dependencies, and sassc build dependencies
RUN apt-get update \
    && apt-get install -y curl \
        build-essential \
        libsass-dev \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && npm install -g yarn

# Install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.5.11
RUN bundle install

# Create necessary asset directories
RUN mkdir -p app/assets/images \
    && mkdir -p app/assets/builds \
    && mkdir -p app/assets/stylesheets \
    && mkdir -p app/assets/javascripts

# Then copy the rest of the application
COPY . .

EXPOSE 20240
