# frozen_string_literal: true

class PromptDecorator < ApplicationRecord
  include Helpers::ValidationHelper

  # !!! This is also an order of decorators in prompt !!!
  DECORATOR_TYPES = {
    role: 'role',
    pre_question: 'pre_question',
    pre_request: 'pre_request',
    edit_instructions: 'edit_instructions',
    format_instructions: 'format_instructions',
    example: 'example',
    post_question: 'post_question',
    post_request: 'post_request',
    context_wrapper: 'context_wrapper',
    translation: 'translation',
    uncategorized: 'uncategorized'
  }.freeze

  enum decorator_type: DECORATOR_TYPES

  validates :value, presence: true
  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase
  validates :decorator_type, presence: true, inclusion: { in: DECORATOR_TYPES.values }

  has_and_belongs_to_many :warehouses

  scope :ordered_by_decorator_type, -> { in_order_of(:decorator_type, DECORATOR_TYPES.values).order(:created_at) }
end
