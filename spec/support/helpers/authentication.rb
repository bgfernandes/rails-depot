# frozen_string_literal: true

module TestHelpers
  module Authentication
    def login_as(user)
      if respond_to? :visit
        visit login_path
        fill_in :name, with: user.name
        fill_in :password, with: user.password
        click_on 'Login'
      else
        post login_url, params: { name: user.name, password: user.password }
      end
    end

    def logout
      delete logout_url
    end

    def setup_authentication
      login_as create(:user)
    end
  end
end
