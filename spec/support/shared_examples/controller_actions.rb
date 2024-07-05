# frozen_string_literal: true

shared_examples 'unauthorized request' do
  raise 'action is not defined' unless method_defined?(:action)

  it 'returns status different than success' do
    expect(action).not_to be_successful
  end
end
