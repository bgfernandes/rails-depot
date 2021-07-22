import React, { useState } from 'react'

import NoPayType from './NoPayType'
import CheckPayType from './CheckPayType'
import CreditCardPayType from './CreditCardPayType'
import PurchaseOrderPayType from './PurchaseOrderPayType'

export default function PayTypeSelector() {
  const [selectedPayType, setSelectedPayType] = useState(null)

  function onPayTypeSelected(event) {
    setSelectedPayType(event.target.value)
  }

  let PayTypeComponent = NoPayType
  switch (selectedPayType) {
    case 'Check':
      PayTypeComponent = CheckPayType
      break;

    case 'Credit card':
      PayTypeComponent = CreditCardPayType
      break;

    case 'Purchase order':
      PayTypeComponent = PurchaseOrderPayType
      break;

    default:
      break;
  }

  return (
    <div>
      <div className="field">
        <label htmlFor="order_pay_type">Pay type</label>
        <select id="order_pay_type" name="order[pay_type]" onChange={onPayTypeSelected}>
          <option value="">Select a payment method</option>
          <option valye="Check">Check</option>
          <option valye="Credit card">Credit card</option>
          <option valye="Purchase order">Purchase order</option>
        </select>
      </div>
      <PayTypeComponent />
    </div>
  )
}
