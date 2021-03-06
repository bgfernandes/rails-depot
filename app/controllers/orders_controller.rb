# frozen_string_literal: true

# The Orders Controller
class OrdersController < ApplicationController
  include CurrentCart

  skip_before_action :authorize, only: %i[new create]
  before_action :set_order, only: %i[show edit update destroy]
  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_isnt_empty, only: %i[new create]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        clear_cart
        enqueue_charge_order_job
        format.html { redirect_to store_index_url, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  # Does not allow creation of orders with an empty cart
  def ensure_cart_isnt_empty
    redirect_to store_index_url, notice: 'Your cart is empty.' if @cart.line_items.empty?
  end

  # Only allow pay type parameters according to the pay_type
  def pay_type_params
    case order_params[:pay_type]
    when 'Credit card'
      params.require(:order).permit(:credit_card_number, :expiration_date)
    when 'Check'
      params.require(:order).permit(:routing_number, :account_number)
    when 'Purchase Order'
      params.require(:order).permit(:po_number)
    else
      {}
    end
  end

  # Enqueues a charge order job
  def enqueue_charge_order_job
    ChargeOrderJob.perform_later(@order, pay_type_params.to_h)
  end
end
