# frozen_string_literal: true

class ZipCodeSerializer < ActiveModel::Serializer
  attributes :zip_code, :cbsa, :msa, :pop2015, :pop2014

  def cbsa
    object.cbsa&.cbsa
  end

  def msa
    object.statistical_area&.name
  end

  def pop2015
    object.statistical_area&.popestimate_2015
  end

  def pop2014
    object.statistical_area&.popestimate_2014
  end
end
