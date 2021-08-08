# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations', :aggregate_failures do
    describe 'name' do
      context 'when empty' do
        subject(:user_without_name) { described_class.new }

        it 'has an error' do
          expect(user_without_name.valid?).to be false
          expect(user_without_name.errors[:name]).to eq ["can't be blank"]
        end
      end

      context 'when not unique' do
        subject(:user_with_duplicate_name) { build(:user, name: another_user.name) }

        let(:another_user) { create(:user) }

        it 'has an error' do
          expect(user_with_duplicate_name.valid?).to be false
          expect(user_with_duplicate_name.errors[:name]).to eq ['has already been taken']
        end
      end

      context 'when unique' do
        subject(:user_with_good_name) { build(:user) }

        it 'has an error' do
          expect(user_with_good_name.valid?).to be true
        end
      end
    end
  end
end
