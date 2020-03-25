# frozen_string_literal: true

FactoryBot.define do
  factory :cbsa do
    cbsa { Faker::Number.number(digits: 5) }

    association :statistical_area
  end
end
