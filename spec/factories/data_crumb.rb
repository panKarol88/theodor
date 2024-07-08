# frozen_string_literal: true

FactoryBot.define do
  factory :data_crumb do
    content { Faker::Fantasy::Tolkien.poem }
    warehouse { Warehouse.find_or_create_by(name: 'example_warehouse_name') }
    embedding { (0...1536).map(&:to_f) }
  end
end
