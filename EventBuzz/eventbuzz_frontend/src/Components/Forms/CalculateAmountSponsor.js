
import React, { useEffect, useState } from 'react';

const CalculateAmountSponsor = () => {
  const [sponsorName, setSponsorName] = useState('');
  const [totalAmount, setTotalAmount] = useState(-1);

  const handleSubmit = (e) => {
    e.preventDefault();
    calculateAmount(sponsorName);
  };

  useEffect(() => {
        setTotalAmount(totalAmount);
    }, [totalAmount]);

  const calculateAmount = (sponsorName) => {
    fetch('http://localhost:4000/calculateTotalAmountSponsorSpends', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ sponsor_name: sponsorName }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        setTotalAmount(data.total_amount_sponsor_spends);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  return (
    <form onSubmit={handleSubmit}>
        <h1> Total Amount Sponsor Spends</h1>
      <label>
        Sponsor Name:
        <input type="text" value={sponsorName} onChange={(e) => setSponsorName(e.target.value)} placeholder="Enter Sponsor name" />
      </label>
      <button type="submit">Calculate Total Amount Spent</button>
      {totalAmount != -1? <p>Total amount spent: ${totalAmount}</p> :  null}
    </form>
  );
};

export default CalculateAmountSponsor;
