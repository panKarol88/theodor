# frozen_string_literal: true

class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[show]

  def show
    @prompt_decorators = @feature.prompt_decorators.priority_ordered
  end

  private

  def set_feature
    @feature = Feature.find(params[:id])
  end
end
