# frozen_string_literal: true

# This Controller provides a welcome page for admins
class AdminController < ApplicationController
  def index
    @total_orders = Order.count
  end
end
