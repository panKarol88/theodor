# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataCrumb do
  subject { build(:data_crumb) }

  describe 'attributes' do
    it { is_expected.to respond_to :content }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :content }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:warehouse) }
  end
end
