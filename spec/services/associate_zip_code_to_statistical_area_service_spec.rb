# frozen_string_literal: true

require 'rails_helper.rb'

describe AssociateZipCodeToStatisticalAreaService do
  subject { AssociateZipCodeToStatisticalAreaService.perform }

  context 'when there are valid data in db' do
    let!(:cbsa) { create(:cbsa, cbsa: '11111', statistical_area: nil) }
    let!(:zip_code) { create(:zip_code, cbsa: cbsa) }
    let!(:statistical_area) do
      create(:statistical_area, cbsa: '11111', lsad: 'Metropolitan Statistical Area')
    end

    it 'links cbsa to statistical_area' do
      subject

      expect(zip_code.cbsa.reload.statistical_area_id).to eq(statistical_area.id)
    end
  end

  context 'when cbsa is 99999' do
    let!(:cbsa) { create(:cbsa, cbsa: '99999', statistical_area: nil) }
    let!(:zip_code) { create(:zip_code, cbsa: cbsa) }
    let!(:statistical_area) do
      create(:statistical_area, cbsa: '11111', lsad: 'Metropolitan Statistical Area')
    end

    it 'doesn\'t link cbsa to statistical_area' do
      subject

      expect(zip_code.cbsa.reload.statistical_area_id).not_to eq(statistical_area.id)
    end
  end

  context 'when statistical_area is not MSA' do
    let!(:cbsa) { create(:cbsa, cbsa: '11111', statistical_area: nil) }
    let!(:zip_code) { create(:zip_code, cbsa: cbsa) }
    let!(:statistical_area) do
      create(:statistical_area, cbsa: '11111', lsad: 'County or equivalent')
    end

    it 'doesn\'t link cbsa to statistical_area' do
      subject

      expect(zip_code.cbsa.reload.statistical_area_id).not_to eq(statistical_area.id)
    end
  end

  context 'when there are mdiv' do
    let!(:cbsa) { create(:cbsa, cbsa: '11111', statistical_area: nil) }
    let!(:zip_code) { create(:zip_code, cbsa: cbsa) }
    let!(:statistical_area_not_msa) do
      create(:statistical_area, cbsa: '22222', mdiv: '11111', lsad: 'County or equivalent')
    end
    let!(:statistical_area_msa) do
      create(:statistical_area, cbsa: '22222', lsad: 'Metropolitan Statistical Area')
    end

    it 'links cbsa to the correct statistical_area' do
      subject

      expect(zip_code.cbsa.reload.statistical_area_id).to eq(statistical_area_msa.id)
    end
  end
end
