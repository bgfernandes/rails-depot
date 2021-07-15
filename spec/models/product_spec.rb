# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    context 'when attributes are empty' do
      subject(:new_product) { described_class.new }

      it 'has errors' do
        expect(new_product.valid?).to be false
        expect(new_product.errors[:title].any?).to be true
        expect(new_product.errors[:description].any?).to be true
        expect(new_product.errors[:price].any?).to be true
        expect(new_product.errors[:image_url].any?).to be true
      end
    end

    describe 'title' do
      context 'when not unique' do
        subject(:product_with_existing_title) { build(:product, title: 'Same Title') }

        before do
          create(:product, title: 'Same Title')
        end

        it 'has an error' do
          expect(product_with_existing_title.invalid?).to be true
          expect(product_with_existing_title.errors[:title]).to eq ['has already been taken']
        end
      end

      context 'when smaller than 10 characters' do
        subject(:product_with_short_title) { build(:product, title: 'too small') }

        it 'has an error' do
          expect(product_with_short_title.invalid?).to be true
          expect(product_with_short_title.errors[:title]).to eq ['is too short (minimum is 10 characters)']
        end
      end

      context 'when bigger than 9 characters and unique' do
        subject(:product_with_good_title) { build(:product, title: 'A bigger and unique title') }

        it 'has no errors' do
          expect(product_with_good_title.valid?).to be true
          expect(product_with_good_title.errors[:title].empty?).to be true
        end
      end
    end

    describe 'price' do
      context 'when negative' do
        subject(:product_with_negative_price) { build(:product, price: -1) }

        it 'has an error' do
          expect(product_with_negative_price.invalid?).to be true
          expect(product_with_negative_price.errors[:price]).to eq ['must be greater than or equal to 0.01']
        end
      end

      context 'when zero' do
        subject(:product_with_zero_price) { build(:product, price: 0) }

        it 'has an error' do
          expect(product_with_zero_price.invalid?).to be true
          expect(product_with_zero_price.errors[:price]).to eq ['must be greater than or equal to 0.01']
        end
      end

      context 'when 0.01' do
        subject(:product_with_good_price) { build(:product, price: 0.01) }

        it 'has no errors' do
          expect(product_with_good_price.valid?).to be true
          expect(product_with_good_price.errors[:price].empty?).to be true
        end
      end
    end

    describe 'image_url' do
      context 'when invalid' do
        let(:invalid_urls) { %w[some.doc some.gif/more what.gif.what] }

        it 'has an error' do
          invalid_urls.each do |url|
            product = build(:product, image_url: url)
            expect(product.invalid?).to be true
          end
        end
      end

      context 'when valid' do
        let(:valid_urls) { %w[some.gif some.jpg some.png SOME.JPG SOME.GIF some.GIF] }

        it 'has no errors' do
          valid_urls.each do |url|
            product = build(:product, image_url: url)
            expect(product.valid?).to be true
          end
        end
      end
    end
  end
end
