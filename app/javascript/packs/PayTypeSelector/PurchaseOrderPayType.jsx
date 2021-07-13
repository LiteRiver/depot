import React from 'react';

const PurchaseOrderPayType = function () {
  return (
    <div>
      <div className="field">
        <label htmlFor="order_po_number">PO #</label>
        <input type="password" name="order[po_number]" id="order_po_number" autoComplete="new-password" />
      </div>
    </div>
  );
};

export default PurchaseOrderPayType;
