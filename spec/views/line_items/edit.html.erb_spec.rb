require 'rails_helper'

RSpec.describe 'line_items/edit', type: :view do
  before do
    @line_item = assign(:line_item, create(:line_item))
  end

  it 'renders the edit line_item form' do
    render

    assert_select 'form[action=?][method=?]', line_item_path(@line_item), 'post' do
    end
  end
end
