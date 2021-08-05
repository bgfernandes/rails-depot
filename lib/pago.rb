# frozen_string_literal: true

require 'ostruct'

# API for a fake payment provider
class Pago
  class << self
    def make_payment(order_id:, payment_method:, payment_details:)
      log_payment(payment_method, payment_details)

      sleep 3 unless Rails.env.test?

      Rails.logger.info "Done Processing Payment #{order_id}"

      OpenStruct.new(succeeded?: true)
    end

    private

    def log_payment(payment_method, payment_details)
      case payment_method
      when :check
        Rails.logger.info <<~HEREDOC
          Processing check:
          #{payment_details.fetch(:routing)}/#{payment_details.fetch(:account)}
        HEREDOC
      when :credit_card
        Rails.logger.info <<~HEREDOC
          Processing credit_card:
          #{payment_details.fetch(:cc_num)}/#{payment_details.fetch(:expiration_month)}/#{payment_details.fetch(:expiration_year)}"
        HEREDOC
      when :po
        Rails.logger.info <<~HEREDOC
          Processing purchase order:
          #{payment_details.fetch(:po_num)}
        HEREDOC
      else
        raise "Unknown payment method #{payment_method}"
      end
    end
  end
end
