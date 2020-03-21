# frozen_string_literal: true

class FillInZipCodesAndCbsasService < ServiceObject
  def initialize(zip_to_cbsa_file)
    @zip_to_cbsa_file = zip_to_cbsa_file
  end

  def perform!
    truncate_tables

    zip_collection.each do |row|
      fill_in_zip_codes_and_cbsas(row.to_h)
    end
  end

  private

  attr_reader :zip_to_cbsa_file

  def truncate_tables
    ZipCode.destroy_all
    Cbsa.destroy_all
  end

  def zip_collection
    CSV.foreach(zip_to_cbsa_file, headers: true, encoding: 'bom|utf-8')
  end

  def fill_in_zip_codes_and_cbsas(row)
    ZipCode.create(zip_code: row['ZIP'].rjust(5, '0'), cbsa_attributes: { cbsa: row['CBSA'] })
  end
end
