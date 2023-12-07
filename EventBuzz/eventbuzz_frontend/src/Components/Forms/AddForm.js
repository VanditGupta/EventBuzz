import React, { useState, useEffect } from "react";

const AddForm = ({ currentTable, tableData, onAdd }) => {
  const [formData, setFormData] = useState({});
  const [errors, setErrors] = useState({});
  const [eventCategories, setEventCategories] = useState([]);
  const [venues, setVenues] = useState([]);
  const [users, setUsers] = useState([]);
  const [events, setEvents] = useState([]);
  const [orders, setOrders] = useState([]);
  const [notifications, setNotifications] = useState([]);
  const [sponsors, setSponsors] = useState([]); 
  const [organisers, setOrganisers] = useState([]);


  // Fields that should be integers
  const integerFields = [ 
    "contact_phone", "street_no", "unit_no", "zip_code", 
    "max_capacity", "ticket_quantity"
  ];

  // Fields that can be numeric (integer or float)
  const numericFields = [
    "total_amount", "ticket_price", "sponsorship_amount"
  ];

  // ENUM fields with their options
  const enumFields = {
    sex: ['male', 'female', 'other'],
    role: ['admin', 'user', 'organizer'],
    status: ['active', 'inactive'],
    event_status: ['scheduled', 'cancelled', 'completed'],
    payment_type: ['credit_card', 'debit_card', 'paypal', 'other'],
    payment_status: ['paid', 'pending', 'failed'],
    priority: ['high', 'medium', 'low'],
  };

  useEffect(() => {
    // Fetch event categories
    fetch('http://localhost:4000/getEventCategories')
      .then(response => response.json())
      .then(data => {
        setEventCategories(data.map(category => category.category_name));
      })
      .catch(error => console.error('Error fetching event categories:', error));
  
  fetch('http://localhost:4000/getVenues')
  .then(response => response.json())
  .then(data => {
    setVenues(data.map(venue => venue.venue_name));
  })
  .catch(error => console.error('Error fetching venues:', error));

  fetch('http://localhost:4000/getNotifications')
      .then(response => response.json())  
      .then(data => {
        setNotifications(data.map(notification => notification.notification_id.toString())); // Assuming notification_id is the identifier
      })
      .catch(error => console.error('Error fetching notifications:', error));

  fetch('http://localhost:4000/getOrders')
      .then(response => response.json())
      .then(data => {
        setOrders(data.map(order => order.order_id.toString())); // Assuming order_id is the identifier
      })
      .catch(error => console.error('Error fetching orders:', error));

  fetch('http://localhost:4000/getSponsors')
      .then(response => response.json())
      .then(data => {
        setSponsors(data.map(sponsor => sponsor.sponsor_name)); // Assuming sponsor_name is the identifier
      })
      .catch(error => console.error('Error fetching sponsors:', error));  

  fetch('http://localhost:4000/getUsers')
      .then(response => response.json())
      .then(data => {
        setUsers(data.map(user => ({ id: user.user_id, name: user.username })));
      })
      .catch(error => console.error('Error fetching users:', error));
      
  fetch('http://localhost:4000/getOrganisers')
      .then(response => response.json())
      .then(data => {
        setOrganisers(data.map(organiser => organiser.organiser_name)); // Assuming organiser_name is the identifier
      })
      .catch(error => console.error('Error fetching organisers:', error));    
    
    // Fetch event names
    fetch('http://localhost:4000/getEvents')
      .then(response => response.json())
      .then(data => {
        setEvents(data.map(event => event.event_name));
      })
      .catch(error => console.error('Error fetching events:', error));
  }, []);

  const validateInput = (columnName, value) => {
    if (integerFields.includes(columnName) && !/^\d*$/.test(value)) {
      return `${columnName.replace(/_/g, " ")} must be an integer.`;
    }
    if (numericFields.includes(columnName) && isNaN(value)) {
      return `${columnName.replace(/_/g, " ")} must be a numeric value.`;
    }
    return "";
  };

  const handleInputChange = (columnName, value) => {
    setFormData((prevData) => ({
      ...prevData,
      [columnName]: value,
    }));

    const errorMessage = validateInput(columnName, value);
    setErrors({ ...errors, [columnName]: errorMessage });
  };

  const handleAdd = () => {
    // Check for errors before adding data
    const formErrors = Object.keys(formData).reduce((acc, key) => {
      const error = validateInput(key, formData[key]);
      if (error) acc[key] = error;
      return acc;
    }, {});

    if (Object.keys(formErrors).length === 0) {
      onAdd(formData);
      setFormData({});
    } else {
      setErrors(formErrors);
    }
  };

  const shouldRenderDropdown = (column) => {
    console.log('currentTable:', currentTable);
    if (
      (currentTable !== 'EventCategories' && column === 'category_name') ||
      (currentTable !== 'Venues' && column === 'venue_name') ||
      (currentTable !== 'Events' && column === 'event_name') ||
      (currentTable !== 'Users' && column === 'user_id') ||
      (currentTable !== 'Orders' && column === 'order_id') ||
      (currentTable !== 'Notifications' && column === 'notification_id') ||
      (currentTable !== 'Sponsors' && column === 'sponsor_name') ||
      (currentTable !== 'Organisers' && column === 'organiser_name')) { // Condition for organiser_name
      return true;
    }
    return false;
  };

  const renderInputField = (column) => {
    // Render dropdown for foreign key fields where appropriate
    if (shouldRenderDropdown(column)) {
      let options = [{ value: "", label: "None" }];
      if (column === 'category_name') {
        options = eventCategories;
      } else if (column === 'venue_name') {
        options = venues;
      } else if (column === 'event_name') {
        options = events;
      } else if (column === 'user_id') {
        options = users.map(user => ({ value: user.id, label: user.name }));  // Assuming user names are to be displayed
      }
      else if (column === 'order_id') {
        options = orders;
      }
      else if (column === 'notification_id') {
        options = notifications;
      }
      if (column === 'sponsor_name') {
        options = sponsors;
      }
      if (column === 'organiser_name') {
        options = organisers;
      }
  
      return (
        <select
          id={column}
          name={column}
          value={formData[column] || ""} // Set value to an empty string ""
          onChange={(e) => handleInputChange(column, e.target.value)}
        >
          <option value="">Select an option</option> {/* Add an empty option */}
          {options.map(option => (
            <option key={option.value || option} value={option.value || option}>
              {option.label || option}
            </option>
          ))}
        </select>
      );
    }
  
    // Check if column is an ENUM field
    if (enumFields[column]) {
      return (
        <select
          id={column}
          name={column}
          value={formData[column] || ""}
          onChange={(e) => handleInputChange(column, e.target.value)}
        >
          <option value="">Select an option</option> {/* Add an empty option */}
          {enumFields[column].map(option => (
            <option key={option} value={option}>
              {option}
            </option>
          ))}
        </select>
      );
    }
  
    // Default input field for other types
    return (
      <input
        type={column.toLowerCase().includes("date") ? "date" : "text"}
        id={column}
        name={column}
        value={formData[column] || ""}
        onChange={(e) => handleInputChange(column, e.target.value)}
      />
    );
  };
  

  return (
    <form>
      {tableData.map((column) => (
        <div key={column}>
          <label htmlFor={column}>{column.replace(/_/g, " ")}:</label>
          {renderInputField(column)}
          {errors[column] && <p style={{ color: 'red' }}>{errors[column]}</p>}
        </div>
      ))}
      <button type="button" onClick={handleAdd}>
        Add Data
      </button>
    </form>
  );
};

export default AddForm;
