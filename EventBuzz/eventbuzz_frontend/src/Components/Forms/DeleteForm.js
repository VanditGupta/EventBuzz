import React, { useState, useEffect } from "react";

const DeleteForm = ({ tableData, onDelete, activeTable }) => {
  const [formData, setFormData] = useState({});
  const [primaryKeyOptions, setPrimaryKeyOptions] = useState({});

  const determinePrimaryKeys = (tableName) => {
    // Map table names to their respective primary key field(s)
    const primaryKeysMap = {
      Users: ["user_id"],
      EventCategories: ["category_name"],
      Venues: ["venue_name"],
      Events: ["event_name"],
      Orders: ["order_id"],
      Tickets: ["ticket_id"],
      Reviews: ["user_id","event_name"],
      Sponsors: ["sponsor_name"],
      Organisers: ["organiser_name"],
      Notifications: ["notification_id", "event_name"],
      NotificationsSendToUsers: ["notification_id","user_id"],
      UsersRegisterForEvents: ["user_id","event_name"],
      EventsFundedBySponsors: ["event_name", "sponsor_name"],
      EventsOrganisedByOrganisers: ["event_name","organiser_name"]
    };

    return primaryKeysMap[tableName] || [];
  };

  useEffect(() => {
    const primaryKeys = determinePrimaryKeys(activeTable);

    // Fetch data for the active table
    fetch(`http://localhost:4000/get${activeTable}`)
      .then(response => response.json())
      .then(data => {
        primaryKeys.forEach(key => {
          setPrimaryKeyOptions(prevOptions => ({
            ...prevOptions,
            [key]: data.map(item => item[key])
          }));
        });
      })
      .catch(error => console.error(`Error fetching data from ${activeTable}:`, error));
  }, [activeTable]);

  const handleInputChange = (columnName, value) => {
    setFormData((prevData) => ({
      ...prevData,
      [columnName]: value,
    }));
  };

  const handleDelete = () => {
    onDelete(formData);
    setFormData({});
  };

  const primaryKeys = determinePrimaryKeys(activeTable);

  const renderInputField = (column) => {
    if (primaryKeys.includes(column) && primaryKeyOptions[column]) {
      return (
        <select
          id={column}
          name={column}
          value={formData[column] || ""}
          onChange={(e) => handleInputChange(column, e.target.value)}
        >
          <option value="">Select an option</option>
          {primaryKeyOptions[column].map(option => (
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
        type="text"
        id={column}
        name={column}
        value={formData[column] || ""}
        onChange={(e) => handleInputChange(column, e.target.value)}
      />
    );
  };

  return (
    <form>
      {primaryKeys.map((column) => (
        <div key={column}>
          <label htmlFor={column}>{column.replace(/_/g, " ")}</label>
          {renderInputField(column)}
        </div>
      ))}
      <button type="button" onClick={handleDelete}>
        Delete Data
      </button>
    </form>
  );
};

export default DeleteForm;
