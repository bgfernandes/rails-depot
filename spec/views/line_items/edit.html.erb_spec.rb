# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'line_items/edit', type: :view do
  let!(:line_item) { assign(:line_item, create(:line_item)) }

  it 'renders the edit line_item form' do
    render

    assert_select 'form[action=?][method=?]', line_item_path(line_item), 'post'
  end
end
