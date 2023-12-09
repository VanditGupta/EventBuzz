
import React, { useEffect, useState } from 'react';

const CalculateAgeForm = () => {
  const [date, setDate] = useState('');
  const [age, setAge] = useState(-1);

  const handleSubmit = (e) => {
    e.preventDefault();
    calculateAge(date);
  };

    useEffect(() => {
        setAge(age);
    }, [age]);

  const calculateAge = (date) => {
    fetch('http://localhost:4000/calculateAge', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ birthdate: date }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        setAge(data.age);
      })
      .catch((error) => {
        // Handle any errors
        console.error(error);
      });
  };

  return (
    <form onSubmit={handleSubmit}>
        <h1>Calculate Age Function</h1>
      <label>
        Date:
        <input type="date" value={date} onChange={(e) => setDate(e.target.value)} placeholder="Enter Dates" />
      </label>
      <button type="submit">Calculate Age</button>
      {age != -1? <p>The age is {age} years old</p> :  null}
    </form>
  );
};

export default CalculateAgeForm;
