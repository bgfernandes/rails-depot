import React, { useState } from 'react'

export default function PayTypeSelector() {
  const [selectedPayType, setSelectedPayType] = useState(null)

  function onPayTypeSelected(event) {
    setSelectedPayType(event.target.value)
  }

  return (
    <div className="field">
      <label htmlFor="order_pay_type">Pay type</label>
      <select id="order_pay_type" name="order[pay_type]" onChange={onPayTypeSelected}>
        <option value="">Select a payment method</option>
        <option valye="Check">Check</option>
        <option valye="Credit card">Credit card</option>
        <option valye="Purchase order">Purchase order</option>
      </select>
    </div>
  )
}
