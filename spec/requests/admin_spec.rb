# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  before do
    setup_authentication
  end

  describe 'GET /admin' do
    it 'returns http success' do
      get '/admin'
      expect(response).to have_http_status(:success)
    end
  end
end
