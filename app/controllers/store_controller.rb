# frozen_string_literal: true

# The Store Controller
class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
  end
end
