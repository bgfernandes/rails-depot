require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    context "when attributes are empty" do
      subject { Product.new }

      it "has errors" do
        expect(subject.valid?).to be false
        expect(subject.errors[:title].any?).to be true
        expect(subject.errors[:description].any?).to be true
        expect(subject.errors[:price].any?).to be true
        expect(subject.errors[:image_url].any?).to be true
      end
    end

    describe "title" do
      context "when not unique" do
        subject { build(:product, title: 'Same Title') }

        before do
          create(:product, title: 'Same Title')
        end

        it "has an error" do
          expect(subject.invalid?).to be true
          expect(subject.errors[:title]).to eq ['has already been taken']
        end
      end

      context "when smaller than 10 characters" do
        subject { build(:product, title: 'too small') }

        it "has an error" do
          expect(subject.invalid?).to be true
          expect(subject.errors[:title]).to eq ['is too short (minimum is 10 characters)']
        end
      end

      context "when bigger than 9 characters and unique" do
        subject { build(:product, title: 'A bigger and unique title') }

        it "has no errors" do
          expect(subject.valid?).to be true
          expect(subject.errors[:title].empty?).to be true
        end
      end
    end

    describe "price" do
      context "when negative" do
        subject { build(:product, price: -1) }

        it "has an error" do
          expect(subject.invalid?).to be true
          expect(subject.errors[:price]).to eq ['must be greater than or equal to 0.01']
        end
      end

      context "when zero" do
        subject { build(:product, price: 0) }

        it "has an error" do
          expect(subject.invalid?).to be true
          expect(subject.errors[:price]).to eq ['must be greater than or equal to 0.01']
        end
      end

      context "when 0.01" do
        subject { build(:product, price: 0.01) }

        it "has no errors" do
          expect(subject.valid?).to be true
          expect(subject.errors[:price].empty?).to be true
        end
      end
    end

    describe "image_url" do
      context "when invalid" do
        let(:invalid_urls) { %w{ some.doc some.gif/more what.gif.what } }

        it "has an error" do
          invalid_urls.each do |url|
            product = build(:product, image_url: url)
            expect(product.invalid?).to be true
          end
        end
      end

      context "when valid" do
        let(:valid_urls) { %w{ some.gif some.jpg some.png SOME.JPG SOME.GIF some.GIF } }

        it "has no errors" do
          valid_urls.each do |url|
            product = build(:product, image_url: url)
            expect(product.valid?).to be true
          end
        end
      end
    end
  end
end
