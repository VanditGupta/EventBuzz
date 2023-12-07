// AddForm.js
import React, { useState } from "react";

const AddForm = ({ tableData, onAdd }) => {
  const [formData, setFormData] = useState({});
  const [errors, setErrors] = useState({});

  const integerFields = [
    "contact_phone",
    "street_no",
    "unit_no",
    "zip_code",
    "max_capacity",
    "ticket_quantity"
  ];

  const numericFields = [
    "total_amount",
    "ticket_price",
    "sponsorship_amount"
  ];

  const validateInput = (columnName, value) => {
    // Check if the field should be an integer
    if (integerFields.includes(columnName) && !/^\d*$/.test(value)) {
      return `${columnName.replace(/_/g, " ")} must be an integer.`;
    }

    // Check if the field should be numeric (integer or float)
    if (numericFields.includes(columnName) && isNaN(value)) {
      return `${columnName.replace(/_/g, " ")} must be a numeric value.`;
    }

    return "";
  };

  const handleInputChange = (columnName, value) => {
    const keys = columnName.split(".");
    const newFormData = keys.length === 1
      ? { ...formData, [columnName]: value.trim() }
      : { ...formData, [keys[0]]: { ...(formData[keys[0]] || {}), [keys[1]]: value.trim() } };

    setFormData(newFormData);

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

  return (
    <form>
      {tableData.map(
        (column) =>
          column !== "ComputedColumn" && (
            <div key={column}>
              <label htmlFor={column}>
                {column.replace(/_/g, " ")}:
              </label>
              <input
                type={column.toLowerCase().includes("date") ? "date" : "text"}
                id={column}
                name={column}
                value={formData[column] || ""}
                onChange={(e) => handleInputChange(column, e.target.value)}
              />
              {errors[column] && <p style={{ color: 'red' }}>{errors[column]}</p>}
            </div>
          )
      )}
      <button type="button" onClick={handleAdd}>
        Add Data
      </button>
    </form>
  );
};

export default AddForm;
