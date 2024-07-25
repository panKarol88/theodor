# frozen_string_literal: true

class WarehousesController < ApplicationController
  def show
    @warehouse = current_user.warehouses.find(params[:id])
    @data_crumbs = @warehouse.data_crumbs
    @prompt_decorators = @warehouse.prompt_decorators.ordered_by_decorator_type
  end
end
