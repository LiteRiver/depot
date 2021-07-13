import React, { useCallback, useState } from 'react';
import DummyPayType from './DummyPayType';
import CheckPayType from './CheckPayType';
import CreditCardPayType from './CreditCardPayType';
import PurchaseOrderPayType from './PurchaseOrderPayType';

const PayTypeSelector = function () {
  const [payType, setPayType] = useState('');
  const onChange = useCallback(function (event) {
    setPayType(event.target.value);
  }, []);

  let PayTypeComponent = DummyPayType;

  if (payType === 'Check') {
    PayTypeComponent = CheckPayType;
  } else if (payType === 'Credit Card') {
    PayTypeComponent = CreditCardPayType;
  } else if (payType === 'Purchase Order') {
    PayTypeComponent = PurchaseOrderPayType;
  }

  return (
    <div>
      <div className="field">
        <label htmlFor="order_pay_type">Pay Type</label>
        <select name="order[pay_type]" id="order_pay_type" onChange={onChange}>
          <option value="">Select a payment method</option>
          <option value="Check">Check</option>
          <option value="Credit Card">Credit Card</option>
          <option value="Purchase Order">Purchase Order</option>
        </select>
      </div>
      <PayTypeComponent />
    </div>
  );
};

export default PayTypeSelector;
