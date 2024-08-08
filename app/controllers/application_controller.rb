# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  private

  def current_warehouses
    return unless user_signed_in?

    @current_warehouses ||= current_user.warehouses
  end

  def current_features
    return unless user_signed_in?

    @current_features ||= Feature.joins(:warehouses).where(warehouses: current_warehouses)
  end

  helper_method :current_warehouses, :current_features
end
