# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'line_items/new', type: :view do
  before do
    assign(:line_item, LineItem.new)
  end

  it 'renders new line_item form' do
    render

    assert_select 'form[action=?][method=?]', line_items_path, 'post' do
    end
  end
end
