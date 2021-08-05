# frozen_string_literal: true

# Job for charging the order and sending the confirmation email
class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, pay_type_params)
    order.charge!(pay_type_params)
  end
end
