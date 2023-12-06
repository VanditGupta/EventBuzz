import React, { useState } from "react";

const DeleteForm = ({ tableData, onDelete, activeTable }) => {
  const [formData, setFormData] = useState({});

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

  return (
    <form>
      {tableData.map((column) => {
        // Render only the primary key fields
        if (primaryKeys.includes(column)) {
          return (
            <div key={column}>
              <label htmlFor={column}>
                {column.replace("_", " ").replace("_", " ").replace("_", " ")}:{" "}
              </label>
              <input
                type={column.toLowerCase().includes("date") ? "date" : "text"}
                id={column}
                name={column}
                value={formData[column] || ""}
                onChange={(e) => handleInputChange(column, e.target.value)}
              />
            </div>
          );
        }
        return null;
      })}
      <button type="button" onClick={handleDelete}>
        Delete Data
      </button>
    </form>
  );
};

export default DeleteForm;
