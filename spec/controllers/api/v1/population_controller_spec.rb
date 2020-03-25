# frozen_string_literal: true

require 'rails_helper.rb'

describe Api::V1::PopulationController do
  describe 'when an input param is invalid' do
    subject { get :index, params: { zip: 'zxcvb' } }

    it 'returns 422 status' do
      subject

      expect(response.status).to eq(422)
    end

    it 'returns an error' do
      subject

      payload = JSON.parse(response.body)

      expect(payload['zip_code']).to eq(['is invalid'])
    end
  end

  describe 'when an input param is valid' do
    subject { get :index, params: { zip: '80000' } }

    describe 'when cbsa is linked to statistical area' do
      let!(:statistical_area) do
        create(:statistical_area, cbsa: '11111', lsad: 'Metropolitan Statistical Area')
      end
      let!(:cbsa) { create(:cbsa, cbsa: '11111', statistical_area: statistical_area) }
      let!(:zip_code) { create(:zip_code, zip_code: '80000', cbsa: cbsa) }

      it 'returns 200 status' do
        subject

        expect(response.status).to eq(200)
      end

      it 'returns correct json response', aggregate_failures: true do
        subject

        payload = JSON.parse(response.body)

        expect(payload['zip_code']).to eq(zip_code.zip_code)
        expect(payload['cbsa']).to eq(cbsa.cbsa)
        expect(payload['msa']).to eq(statistical_area.name)
        expect(payload['pop2015']).to eq(statistical_area.popestimate_2015)
        expect(payload['pop2014']).to eq(statistical_area.popestimate_2014)
      end
    end

    describe 'when cbsa is 99999' do
      let!(:cbsa) { create(:cbsa, cbsa: '99999', statistical_area: nil) }
      let!(:zip_code) { create(:zip_code, zip_code: '80000', cbsa: cbsa) }

      it 'returns correct json response', aggregate_failures: true do
        subject

        payload = JSON.parse(response.body)

        expect(payload['zip_code']).to eq(zip_code.zip_code)
        expect(payload['cbsa']).to eq(cbsa.cbsa)
        expect(payload['msa']).to eq(nil)
        expect(payload['pop2015']).to eq(nil)
        expect(payload['pop2014']).to eq(nil)
      end
    end

    describe 'when cbsa is not linked to statistical_area' do
      let!(:cbsa) { create(:cbsa, cbsa: '10460', statistical_area: nil) }
      let!(:zip_code) { create(:zip_code, zip_code: '80000', cbsa: cbsa) }

      it 'returns correct json response', aggregate_failures: true do
        subject

        payload = JSON.parse(response.body)

        expect(payload['zip_code']).to eq(zip_code.zip_code)
        expect(payload['cbsa']).to eq(cbsa.cbsa)
        expect(payload['msa']).to eq(nil)
        expect(payload['pop2015']).to eq(nil)
        expect(payload['pop2014']).to eq(nil)
      end
    end
  end
end
