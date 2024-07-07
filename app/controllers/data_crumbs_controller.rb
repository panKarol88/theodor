# frozen_string_literal: true

class DataCrumbsController < ApplicationController
  before_action :set_data_crumb, only: %i[show edit update destroy]

  def index
    @data_crumbs = current_user.data_crumbs.order(created_at: :desc)
  end

  def show; end

  def new
    @data_crumb = DataCrumb.new
  end

  def edit; end

  def create
    @data_crumb = DataCrumb.new(data_crumb_params)
    if @data_crumb.save
      respond_to do |format|
        format.html { redirect_to data_crumbs_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @data_crumb.update(data_crumb_params)
      redirect_to data_crumbs_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @data_crumb.destroy

    respond_to do |format|
      format.html { redirect_to data_crumbs_path }
      format.turbo_stream
    end
  end

  private

  def data_crumb_params
    params.require(:data_crumb).permit(:content, :warehouse_id)
  end

  def set_data_crumb
    @data_crumb = DataCrumb.find(params[:id])
  end
end
