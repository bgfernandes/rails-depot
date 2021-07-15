require 'rails_helper'

RSpec.describe 'line_items/show', type: :view do
  before do
    @line_item = assign(:line_item, create(:line_item))
  end

  it 'renders attributes in <p>' do
    render
  end
end
