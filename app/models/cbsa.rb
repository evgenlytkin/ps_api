# frozen_string_literal: true

class Cbsa < ApplicationRecord
  has_many :zip_codes, dependent: :destroy
  belongs_to :statistical_area, optional: true
end
