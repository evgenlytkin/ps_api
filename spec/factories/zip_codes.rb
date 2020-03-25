# frozen_string_literal: true

FactoryBot.define do
  factory :zip_code do
    zip_code { '80000' }

    association :cbsa
  end
end
