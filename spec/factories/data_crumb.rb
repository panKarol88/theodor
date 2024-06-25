# frozen_string_literal: true

FactoryBot.define do
  factory :data_crumb do
    content { Faker::Fantasy::Tolkien.poem }
  end
end
