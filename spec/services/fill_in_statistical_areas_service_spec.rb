# frozen_string_literal: true

require 'rails_helper.rb'

describe FillInStatisticalAreasService do
  subject { FillInStatisticalAreasService.perform(nil) }

  context 'when there are data in db' do
    let!(:statistical_area) { create(:statistical_area) }
    let!(:cbsa) { create(:cbsa, statistical_area: statistical_area) }
    let!(:zip_code) { create(:zip_code, cbsa: cbsa) }

    before do
      allow_any_instance_of(FillInStatisticalAreasService).to receive(:cbsa_collection).and_return([])
    end

    it 'truncates StatisticalArea model' do
      expect do
        subject
      end.to change { StatisticalArea.count }.by(-1)
    end
  end

  context 'when there are data in CSV file' do
    let(:cbsa_collection) do
      [
        {
          'CBSA' => '14460',
          'MDIV' => '14454',
          'NAME' => 'Boston, MA',
          'LSAD' => 'Metropolitan Division',
          'POPESTIMATE2014' => '4774321',
          'POPESTIMATE2015' => '4784321',
        }
      ]
    end

    before do
      allow_any_instance_of(FillInStatisticalAreasService).to receive(:cbsa_collection).and_return(cbsa_collection)
    end

    it 'creates a new StatisticalArea entry' do
      expect do
        subject
      end.to change { StatisticalArea.count }.by(1)
    end
  end
end
