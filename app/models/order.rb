# frozen_string_literal: true

require 'pago'

# A customer order
class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum pay_type: {
    'Check' => 0,
    'Credit card' => 1,
    'Purchase order' => 2
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_items << line_item
    end
  end

  def charge!(pay_type_params)
    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details(pay_type_params)
    )

    raise payment_result.error unless payment_result.succeeded?

    OrderMailer.received(self).deliver_later
  end

  private

  def payment_details(pay_type_params)
    case pay_type
    when 'Check'
      {
        routing: pay_type_params[:routing_number],
        account: pay_type_params[:account_number]
      }
    when 'Credit card'
      month, year = pay_type_params[:expiration_date].split('/')
      {
        cc_num: pay_type_params[:credit_card_number],
        expiration_month: month,
        expiration_year: year
      }
    when 'Purchase order'
      {
        po_num: pay_type_params[:po_number]
      }
    end
  end

  def payment_method
    {
      'Check' => :check,
      'Credit card' => :credit_card,
      'Purchase order' => :po
    }[pay_type]
  end
end
