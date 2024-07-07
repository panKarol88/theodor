# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  private

  def current_warehouses
    @current_warehouses ||= current_user.warehouses if user_signed_in?
  end

  helper_method :current_warehouses
end
