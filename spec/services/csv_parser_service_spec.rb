# frozen_string_literal: true

require 'rails_helper.rb'

describe CsvParserService do
  context 'when we handle a positive scenario' do
    before do
      allow(FillInZipCodesAndCbsasService).to receive(:perform).and_return(false)
      allow(FillInStatisticalAreasService).to receive(:perform).and_return(false)
      allow(AssociateZipCodeToStatisticalAreaService).to receive(:perform).and_return(false)
    end

    it 'calls services for parsing csv files' do
      expect(FillInZipCodesAndCbsasService).to receive(:perform)
      expect(FillInStatisticalAreasService).to receive(:perform)
      expect(AssociateZipCodeToStatisticalAreaService).to receive(:perform)

      CsvParserService.perform(nil, nil)
    end
  end
end
