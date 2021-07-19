# frozen_string_literal: true

# Functions for loading @cart from the session[:cart_id] state
module CurrentCart
  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def clear_cart
    return unless @cart

    @cart.destroy
    session[:cart_id] = nil
  end
end
