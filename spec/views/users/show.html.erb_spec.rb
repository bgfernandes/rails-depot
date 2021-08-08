# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', :aggregate_failures, type: :view do
  before do
    @user = assign(:user, User.create!(
                            name: 'Name',
                            password: ''
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
