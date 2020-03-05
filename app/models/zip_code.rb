# frozen_string_literal: true

class ZipCode < ApplicationRecord
  has_many :zip_code_cbsas, dependent: :destroy
  has_many :cbsas, through: :zip_code_cbsas
  has_many :cbsa_statistical_areas, through: :cbsa
  has_many :statistical_areas, through: :cbsa_statistical_areas

  validates :zip_code, format: { with: /\A\d{5}\z/, message: 'not a valid zip_code', allow_nil: true }, presence: true
end
