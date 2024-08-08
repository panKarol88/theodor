# frozen_string_literal: true

class PromptDecoratorsController < ApplicationController
  before_action :set_prompt_decorator, only: %i[destroy edit update]
  before_action :set_feature

  def new
    @prompt_decorator = PromptDecorator.new
  end

  def edit; end

  def create
    @prompt_decorator = PromptDecorator.new(prompt_decorator_params)

    if @prompt_decorator.save
      @prompt_decorators = @feature.prompt_decorators.priority_ordered

      respond_to do |format|
        notice = t('prompt_decorators.flash.created')
        format.turbo_stream { flash.now[:notice] = notice }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @prompt_decorator.update(prompt_decorator_params)
      @prompt_decorators = @feature.prompt_decorators.priority_ordered

      respond_to do |format|
        notice = t('prompt_decorators.flash.updated')
        format.turbo_stream { flash.now[:notice] = notice }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prompt_decorator.destroy
    respond_to do |format|
      notice = t('prompt_decorators.flash.destroyed')
      format.turbo_stream { flash.now[:notice] = notice }
    end
  end

  private

  def set_prompt_decorator
    @prompt_decorator = PromptDecorator.find(params[:id])
  end

  def set_feature
    feature_id = params[:feature_id] || params[:prompt_decorator].try('[]', :feature_id)

    return if feature_id.blank?

    @feature = Feature.find(feature_id)
  end

  def prompt_decorator_params
    params.require(:prompt_decorator).permit(:value, :name, :feature_id, :priority)
  end
end
