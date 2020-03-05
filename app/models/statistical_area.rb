# frozen_string_literal: true

class StatisticalArea < ApplicationRecord
  belongs_to :zip_code
  belongs_to :cbsa
end
