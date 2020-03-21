# frozen_string_literal: true

class FillInStatisticalAreasService < ServiceObject
  def initialize(cbsa_to_msa_file)
    @cbsa_to_msa_file = cbsa_to_msa_file
  end

  def perform!
    truncate_table

    cbsa_collection.each do |row|
      fill_in_statistical_areas(row.to_h)
    end
  end

  private

  attr_reader :cbsa_to_msa_file

  def truncate_table
    StatisticalArea.destroy_all
  end

  def cbsa_collection
    CSV.foreach(cbsa_to_msa_file, headers: true, encoding: 'iso-8859-1:utf-8')
  end

  def fill_in_statistical_areas(row)
    return if row['CBSA'].blank?

    StatisticalArea.create(cbsa: row['CBSA'],
                           mdiv: row['MDIV'],
                           name: row['NAME'],
                           lsad: row['LSAD'],
                           popestimate_2014: row['POPESTIMATE2014'],
                           popestimate_2015: row['POPESTIMATE2015'])
  end
end
