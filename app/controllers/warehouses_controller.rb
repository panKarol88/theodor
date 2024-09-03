# frozen_string_literal: true

class WarehousesController < ApplicationController
  def show
    @warehouse = current_user.warehouses.find(params[:id])
    @data_crumbs = @warehouse.data_crumbs
    @features = Feature.left_joins(:warehouses).where(warehouses: { id: [nil, @warehouse.id] })
  end
end
