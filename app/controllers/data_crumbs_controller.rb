class DataCrumbsController < ApplicationController
  before_action :set_data_crumb, only: %i[show edit update destroy]

  def index
    @data_crumbs = DataCrumb.all
  end

  def show; end

  def new
    @data_crumb = DataCrumb.new
  end

  def create
    @data_crumb = DataCrumb.new(data_crumb_params)
    if @data_crumb.save
      redirect_to data_crumbs_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @data_crumb.update(data_crumb_params)
      redirect_to data_crumbs_path
    else
      render :edit
    end
  end

  def destroy
    @data_crumb.destroy
    redirect_to data_crumbs_path
  end

  private

  def data_crumb_params
    params.require(:data_crumb).permit(:content)
  end

  def set_data_crumb
    @data_crumb = DataCrumb.find(params[:id])
  end
end
