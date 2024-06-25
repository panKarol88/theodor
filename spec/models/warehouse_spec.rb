# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Warehouse do
  subject { build(:warehouse) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }

    context 'when name is not a snakecase' do
      let(:warehouse) { build(:warehouse, name: 'Wrong Name') }

      it { expect(warehouse).not_to be_valid }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:data_crumbs).dependent(:destroy) }
    it { is_expected.to have_and_belong_to_many(:users) }
  end
end
