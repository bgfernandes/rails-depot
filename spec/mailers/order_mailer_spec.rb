# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderMailer, :aggregate_failures, type: :mailer do
  describe 'received' do
    let(:order) { create(:order) }
    let(:mail) { described_class.received(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Cookie Store Order Confirmation')
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq([Rails.application.credentials.email_settings[:email_from_address]])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(order.line_items.first.product.title)
    end
  end

  describe 'shipped' do
    let(:order) { create(:order) }
    let(:mail) { described_class.shipped(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Cookie Store Order Shipped')
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq([Rails.application.credentials.email_settings[:email_from_address]])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(order.line_items.first.product.title)
    end
  end
end
