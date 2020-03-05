# frozen_string_literal: true

class ZipCodeCbsa < ApplicationRecord
  belongs_to :zip_code
  belongs_to :cbsa
end
