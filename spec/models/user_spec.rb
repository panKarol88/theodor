require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:warehouses) }
  end
end
