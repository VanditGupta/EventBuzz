
import React, { useEffect, useState } from 'react';

const CalculateNoOfEventsBooked = () => {
  const [userId, setUserId] = useState('');
  const [eventsBooked, setEventsBooked] = useState(-1);

  const handleSubmit = (e) => {
    e.preventDefault();
    calculateId(userId);
  };

  useEffect(() => {
        setEventsBooked(eventsBooked);
    }, [eventsBooked]);

  const calculateId = (userId) => {
    fetch('http://localhost:4000/calculateNumberOfEventsBooked', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ user_id: userId }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        setEventsBooked(data.number_of_events_booked);
      })
      .catch((error) => {
        // Handle any errors
        console.error(error);
      });
  };

  return (
    <form onSubmit={handleSubmit}>
        <h1> Number of Events a User registers</h1>
      <label>
        UserID:
        <input type="text" value={userId} onChange={(e) => setUserId(e.target.value)} placeholder="Enter User ID" />
      </label>
      <button type="submit">Calculate Number of Events Booked</button>
      {eventsBooked != -1? <p>Number of events booked are {eventsBooked}</p> :  null}
    </form>
  );
};

export default CalculateNoOfEventsBooked;
