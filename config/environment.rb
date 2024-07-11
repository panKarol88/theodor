# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Warden::JWTAuth.configure do |config|
  config.mappings = { user: User }
end
