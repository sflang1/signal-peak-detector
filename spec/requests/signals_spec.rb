require 'rails_helper'

RSpec.describe 'Signals requests', type: :request do
  context 'invalid input' do
    describe 'validates presence of required fields' do
      it 'should render a bad request error if no data is provided' do
        get '/signals/detect_peak', params: { threshold: 3 }

        body = JSON.parse(response.body)
        expect(response.status).to eq       400
        expect(body['message']).to include  'Data is a required field'
      end

      it 'should render a bad request error if no threshold is provided' do
        get '/signals/detect_peak', params: { data: [1, 2, 3] }

        body = JSON.parse(response.body)
        expect(response.status).to eq       400
        expect(body['message']).to include  'Threshold is a required field'
      end
    end

    describe 'validates numericality of fields' do
      it 'should render a bad request error if threshold is not numerical' do
        get '/signals/detect_peak', params: { data: [1, 2, 3], threshold: 'abcdef' }

        body = JSON.parse(response.body)
        expect(response.status).to eq       400
        expect(body['message']).to include  'Threshold should be a numeric value'
      end

      it 'should render a bad request error if one of the data values is not numerical' do
        get '/signals/detect_peak', params: { data: [1, 2, 'abcdef'], threshold: 3 }

        body = JSON.parse(response.body)
        expect(response.status).to eq       400
        expect(body['message']).to include  'Data elements should be numeric'
      end
    end
  end

  context 'valid input' do
    describe 'renders proper response' do
      it 'should detect the peaks' do
        get '/signals/detect_peak', params: { data: [1,1.1,0.9,1,1,1.2,2.5,2.3,2.4,1.1,0.8,1.2,1], threshold: 1.5 }

        body = JSON.parse(response.body)
        expect(response.status).to eq       200
        expect(body['data']).to eq          [0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0]
      end
    end
  end
end