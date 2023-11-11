# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon do
    name { Faker::Games::Pokemon.name }
    base_experience { Faker::Number.between(from: 1, to: 100) }
    height { Faker::Number.between(from: 1, to: 100) }
    order { Faker::Number.between(from: 1, to: 100) }
    association :types, factory: :typeable
  end
end