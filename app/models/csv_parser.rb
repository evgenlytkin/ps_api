# frozen_string_literal: true

class CsvParser
  def initialize(cbsa_to_msa:, zip_to_cbsa:)
    @cbsa_to_msa = cbsa_to_msa
    @zip_to_cbsa = zip_to_cbsa
  end

  def call
    zip_collection.each do |row|
      create_insights_property(row.to_h)
      # create_insights_unit(row.to_h)
      # create_insights_capture(row.to_h)
    end

  end

  private

  attr_reader :cbsa_to_msa, :zip_to_cbsa

  def zip_collection
    @zip_collection ||= CSV.foreach(zip_to_cbsa, headers: true)
  end

  def create_insights_property(row)
    puts row
    Property.find_or_create_by!(id: row["community_id"]) do |record|
      record.altos_import(attributes: row, header_formatting: PROPERTY_HEADER_RENAMING)
    end
  end
end
