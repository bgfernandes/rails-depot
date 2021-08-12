# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', :aggregate_failures, type: :request do
  describe 'GET /login' do
    it 'returns http success' do
      get '/login'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:user) { create(:user) }

    context 'when password is correct' do
      it 'successfully logins a user' do
        post '/login', params: { name: user.name, password: user.password }
        expect(response).to redirect_to(admin_url)
        expect(session[:user_id]).to be user.id
      end
    end

    context 'when password is wrong' do
      it 'fails to login a user' do
        post '/login', params: { name: user.name, password: 'wrong password' }
        expect(response).to redirect_to(login_url)
        expect(session[:user_id]).to be nil
      end
    end
  end

  describe 'GET /destroy' do
    it 'logouts a user' do
      delete '/logout'
      expect(response).to redirect_to(store_index_url)
      expect(session[:user_id]).to be nil
    end
  end
end
