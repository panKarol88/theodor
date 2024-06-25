require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  subject { build(:warehouse) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    context 'when name is not a snakecase' do
      let(:warehouse) { build(:warehouse, name: 'Wrong Name') }

      it { expect(warehouse).not_to be_valid }
    end
  end

  describe 'associations' do
    it { should have_many(:data_crumbs).dependent(:destroy) }
    it { should have_and_belong_to_many(:users) }
  end
end
