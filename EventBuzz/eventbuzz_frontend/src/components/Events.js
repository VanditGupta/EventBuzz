import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Events = () => {
    const [events, setEvents] = useState([]);
    const [isLoading, setIsLoading] = useState(true);
    const localhost = '127.0.0.1';

    useEffect(() => {
        const fetchEvents = async () => {
            try {
                const response = await axios.get('http://' + localhost + ':5000/GetEvents');
                console.log(response.data);
                setEvents(response.data);
            } catch (error) {
                console.error('Error fetching data: ', error);
                console.log(error);
            }
            setIsLoading(false);
        };

        fetchEvents();
    }, []);

    if (isLoading) {
        return <div>Loading events...</div>;
    }

    return (
        <div>
            <h2>Events</h2>
            <ul>
                {events.map(event => (
                    <li key={event.event_name}>
                        {event.event_name} - {event.event_description}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default Events;


