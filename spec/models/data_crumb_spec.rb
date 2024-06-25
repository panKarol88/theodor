require 'rails_helper'

RSpec.describe DataCrumb, type: :model do
  subject { build(:data_crumb) }

  describe 'attributes' do
    it { should respond_to :content }
  end

  describe 'validations' do
    it { should validate_presence_of :content }
  end

  describe 'associations' do
    it { should belong_to(:warehouse).optional }
  end
end
