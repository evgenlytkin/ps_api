# frozen_string_literal: true

class Cbsa < ApplicationRecord
  has_one :statistical_area, dependent: :destroy
end
