# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations', :aggregate_failures do
    context 'when attributes are empty' do
      subject(:new_order) { described_class.new }

      it 'has errors' do
        expect(new_order.valid?).to be false
        expect(new_order.errors[:name].any?).to be true
        expect(new_order.errors[:address].any?).to be true
        expect(new_order.errors[:email].any?).to be true
        expect(new_order.errors[:pay_type].any?).to be true
      end
    end

    context 'when pay_type value is not allowed' do
      subject(:new_order) { described_class.new }

      it 'has errors' do
        expect do
          new_order.pay_type = 'Invalid type'
        end.to raise_error ArgumentError
        expect(new_order.valid?).to be false
        expect(new_order.errors[:pay_type]).to eq ['is not included in the list']
      end
    end
  end
end
