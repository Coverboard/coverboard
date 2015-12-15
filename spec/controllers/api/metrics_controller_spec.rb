require 'rails_helper'

describe Api::MetricsController do
  describe 'POST create' do
    it {
      post :create, {}
      expect(JSON::parse(response.body)['status']).to eq('ERROR')
    }
  end
end
