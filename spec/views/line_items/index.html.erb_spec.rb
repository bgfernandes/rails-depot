# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'line_items/index', type: :view do
  before do
    assign(:line_items, [
             create(:line_item),
             create(:line_item)
           ])
  end

  it 'renders a list of line_items' do
    render
  end
end
