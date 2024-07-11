# frozen_string_literal: true

namespace :grape do
  desc 'Print out all defined Grape routes'
  task routes: :environment do
    Theodor::API.routes.each do |route|
      puts "Version: #{route.version}, Method: #{route.request_method}, Path: /api#{route.path}"
    end
  end
end
