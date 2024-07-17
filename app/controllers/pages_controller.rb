# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @warehouses = current_user.warehouses
  end
end
