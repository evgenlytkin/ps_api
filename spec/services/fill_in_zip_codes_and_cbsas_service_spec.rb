# frozen_string_literal: true

require 'rails_helper.rb'

describe FillInZipCodesAndCbsasService do
  subject { FillInZipCodesAndCbsasService.perform(nil) }

  context 'when there are data in db' do
    let!(:statistical_area) { create(:statistical_area) }
    let!(:cbsa) { create(:cbsa, statistical_area: statistical_area) }
    let!(:zip_code) { create(:zip_code, cbsa: cbsa) }

    before do
      allow_any_instance_of(FillInZipCodesAndCbsasService).to receive(:zip_collection).and_return([])
    end

    it 'truncates ZipCode model' do
      expect do
        subject
      end.to change { ZipCode.count }.by(-1)
    end

    it 'truncates Cbsa model' do
      expect do
        subject
      end.to change { Cbsa.count }.by(-1)
    end
  end

  context 'when there are data in CSV file' do
    let(:zip_collection) do
      [
        {
          'ZIP' => '80000',
          'CBSA' => '10000',
        }
      ]
    end

    before do
      allow_any_instance_of(FillInZipCodesAndCbsasService).to receive(:zip_collection).and_return(zip_collection)
    end

    it 'creates a new ZipCode entry' do
      expect do
        subject
      end.to change { ZipCode.count }.by(1)
    end

    it 'creates a new Cbsa entry' do
      expect do
        subject
      end.to change { Cbsa.count }.by(1)
    end
  end
end
