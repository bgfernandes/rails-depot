# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :system do
  before do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
    create(:product)
    setup_authentication
  end

  let(:another_product) { build(:another_product) }

  # rubocop:disable RSpec/ExampleLength
  it 'updates a product' do
    visit products_path

    click_on 'Edit', match: :first

    fill_in 'Description', with: another_product.description
    fill_in 'Image url', with: another_product.image_url
    fill_in 'Price', with: another_product.price
    fill_in 'Title', with: another_product.title

    click_on 'Update Product'

    expect(page).to have_text('Product was successfully updated.')

    click_on 'Back'
  end
  # rubocop:enable RSpec/ExampleLength
end
