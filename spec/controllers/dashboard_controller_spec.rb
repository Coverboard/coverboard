require 'rails_helper'

describe DashboardController do
  describe 'GET index' do
    it {
      get :index
      expect(response).to render_template('index')
    }
  end
end
