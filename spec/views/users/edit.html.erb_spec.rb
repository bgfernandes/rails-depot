# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  let!(:user) { assign(:user, create(:user)) }

  it 'renders the edit user form' do
    render

    assert_select 'form[action=?][method=?]', user_path(user), 'post' do
      assert_select 'input[name=?]', 'user[name]'

      assert_select 'input[name=?]', 'user[password]'
    end
  end
end
