# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', :aggregate_failures, type: :system do
  before do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
    create(:order)
  end

  it 'renders the index page' do
    visit orders_path

    expect(page).to have_selector('h1', text: 'Orders')
  end

  it 'destroys an order' do
    visit orders_path

    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    expect(page).to have_text('Order was successfully destroyed.')
  end

  context 'when creating a new order' do
    before do
      create(:product)

      visit store_index_path

      click_on 'Add to Cart', match: :first

      click_on 'Checkout'
    end

    it 'does not show any pay_type specific fields' do
      expect(page).to have_no_selector('#order_routing_number')
      expect(page).to have_no_selector('#order_account_number')
      expect(page).to have_no_selector('#order_credit_card_number')
      expect(page).to have_no_selector('#order_expiration_date')
      expect(page).to have_no_selector('#order_po_number')
    end

    context 'when selecting pay_type check' do
      before do
        select 'Check', from: 'Pay type'
      end

      it 'shows the routing number field' do
        expect(page).to have_selector('#order_routing_number')
      end

      it 'shows the account number field' do
        expect(page).to have_selector('#order_account_number')
      end

      it 'does not show fields for other pay_types' do
        expect(page).to have_no_selector('#order_credit_card_number')
        expect(page).to have_no_selector('#order_expiration_date')
        expect(page).to have_no_selector('#order_po_number')
      end
    end

    context 'when selecting pay_type credit card' do
      before do
        select 'Credit card', from: 'Pay type'
      end

      it 'shows the credit card number field' do
        expect(page).to have_selector('#order_credit_card_number')
      end

      it 'shows the expiration date field' do
        expect(page).to have_selector('#order_expiration_date')
      end

      it 'does not show fields for other pay_types' do
        expect(page).to have_no_selector('#order_routing_number')
        expect(page).to have_no_selector('#order_account_number')
        expect(page).to have_no_selector('#order_po_number')
      end
    end

    context 'when selecting pay_type purchase order' do
      before do
        select 'Purchase order', from: 'Pay type'
      end

      it 'shows the po number field' do
        expect(page).to have_selector('#order_po_number')
      end

      it 'does not show fields for other pay_types' do
        expect(page).to have_no_selector('#order_routing_number')
        expect(page).to have_no_selector('#order_account_number')
        expect(page).to have_no_selector('#order_credit_card_number')
        expect(page).to have_no_selector('#order_expiration_date')
      end
    end
  end
end
