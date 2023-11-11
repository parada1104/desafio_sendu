# frozen_string_literal: true

FactoryBot.define do
  factory :typeable do
    name { %w[Fire Fairy Grass Ground].sample }
  end
end
