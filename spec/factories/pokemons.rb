# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon do
    name { Faker::Games::Pokemon.name }
    base_experience { Faker::Number.between(from: 1, to: 100) }
    height { Faker::Number.between(from: 1, to: 100) }
    weight { Faker::Number.between(from: 1, to: 100) }
    order { Faker::Number.between(from: 1, to: 100) }

    before(:create) do |pokemon|
      pokemon.types << create_list(:typeable, 2) if pokemon.types.empty?
    end
  end
end