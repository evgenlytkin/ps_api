# frozen_string_literal: true

FactoryBot.define do
  factory :statistical_area do
    cbsa { Faker::Number.number(digits: 5) }
    mdiv { Faker::Number.number(digits: 5) }
    name { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    lsad { Faker::Lorem.sentence }
    popestimate_2014 { Faker::Number.number(digits: 7) }
    popestimate_2015 { Faker::Number.number(digits: 7) }
  end
end
