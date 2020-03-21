# frozen_string_literal: true

class ZipCode < ApplicationRecord
  belongs_to :cbsa, optional: true
  has_one :statistical_area, through: :cbsa

  accepts_nested_attributes_for :cbsa

  INVALID_CBSA = 99999

  scope :valid_zip_codes, -> do
    joins(:cbsa).where.not("cbsas.cbsa": INVALID_CBSA)
  end

  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/ }
end
