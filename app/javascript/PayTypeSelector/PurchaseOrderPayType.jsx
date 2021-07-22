import React from 'react'

export default function PurchaseOrderPayType() {
  return (
    <div>
      <div className="field">
        <label htmlFor="order_po_number">PO #</label>
        <input type="password" name="order[po_number]" id="order_po_number" />
      </div>
    </div>
  )
}
