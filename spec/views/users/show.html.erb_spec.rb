# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', :aggregate_failures, type: :view do
  before do
    @user = assign(:user, create(:user))
  end

  it 'renders attributes in <p>' do
    render
  end
end
