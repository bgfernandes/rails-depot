# frozen_string_literal: true

# The Store Controller
class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
  end
end
