# frozen_string_literal: true

shared_examples 'unauthorized request' do
  raise 'action is not defined' unless method_defined?(:action)

  it 'returns status different than success' do
    action
    expect(response).to redirect_to('/users/sign_in')
  end
end
