# frozen_string_literal: true

FactoryBot.define do
  factory :typeable do
    sequence(:name) { |n| "Typeable#{n}" }
  end
end
