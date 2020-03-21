# frozen_string_literal: true

class CsvParserService < ServiceObject
  def initialize(zip_to_cbsa_file, cbsa_to_msa_file)
    @zip_to_cbsa_file = zip_to_cbsa_file
    @cbsa_to_msa_file = cbsa_to_msa_file
  end

  def perform!
    FillInZipCodesAndCbsasService.perform(@zip_to_cbsa_file)
    FillInStatisticalAreasService.perform(@cbsa_to_msa_file)
    AssociateZipCodeToStatisticalAreaService.perform
  end
end
