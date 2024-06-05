require 'rails_helper'

RSpec.describe DataCrumb, type: :model do
  describe 'attributes' do
    it { should respond_to :content }
  end

  describe 'validations' do
    it { should validate_presence_of :content }
  end
end
