# frozen_string_literal: true

class PromptDecoratorsController < ApplicationController
  before_action :set_prompt_decorator, only: %i[destroy edit update]
  before_action :set_warehouse

  def new
    @prompt_decorator = PromptDecorator.new
  end

  def edit; end

  def create
    @prompt_decorator = PromptDecorator.new(prompt_decorator_params)
    @prompt_decorator.warehouses << @warehouse if @warehouse.present?
    @prompt_decorators = @warehouse.prompt_decorators.ordered_by_decorator_type

    if @prompt_decorator.save
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

  def set_warehouse
    warehouse_id = params[:warehouse_id] || params[:prompt_decorator].try('[]', :warehouse_id)

    return if warehouse_id.blank?

    @warehouse = Warehouse.find(warehouse_id)
  end

  def prompt_decorator_params
    params.require(:prompt_decorator).permit(:value, :name, :decorator_type)
  end
end
