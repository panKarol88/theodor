# frozen_string_literal: true

class PromptDecorator < ApplicationRecord
  include Helpers::ValidationHelper

  DECORATOR_TYPES = {
    pre_question: 'pre_question',
    post_question: 'post_question',
    pre_request: 'pre_request',
    post_request: 'post_request',
    context_wrapper: 'context_wrapper',
    edit_instructions: 'edit_instructions',
    format_instructions: 'format_instructions',
    example: 'example',
    role: 'role',
    translation: 'translation',
    uncategorized: 'uncategorized'
  }.freeze

  enum decorator_type: DECORATOR_TYPES

  validates :value, presence: true
  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase
  validates :decorator_type, presence: true, inclusion: { in: DECORATOR_TYPES.values }

  has_and_belongs_to_many :warehouses
end
