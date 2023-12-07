import React, { useState } from "react";

const UpdateForm = ({ tableData, onUpdate, primaryKeys }) => {
  const [formData, setFormData] = useState({});
  const [errors, setErrors] = useState({});

  // Fields that should be integers
  const integerFields = ["street_no", "unit_no", "zip_code", "max_capacity", "ticket_quantity"];

  // Fields that can be numeric (integer or float)
  const numericFields = ["total_amount", "ticket_price", "sponsorship_amount"];

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
    const newFormData = { ...formData, [columnName]: value.trim() };

    setFormData(newFormData);

    const errorMessage = validateInput(columnName, value);
    setErrors({ ...errors, [columnName]: errorMessage });
  };

  const handleUpdate = () => {
    const formErrors = Object.keys(formData).reduce((acc, key) => {
      const error = validateInput(key, formData[key]);
      if (error) acc[key] = error;
      return acc;
    }, {});

    if (Object.keys(formErrors).length === 0) {
      onUpdate(formData);
    } else {
      setErrors(formErrors);
    }
  };

  const renderInputField = (column) => {
    if (enumFields[column]) {
      return (
        <select
          id={column}
          name={column}
          value={formData[column] || ""}
          onChange={(e) => handleInputChange(column, e.target.value)}
        >
          {enumFields[column].map(option => (
            <option key={option} value={option}>{option}</option>
          ))}
        </select>
      );
    }
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

console.log(Object.values(errors).some(error => error !== "") , Object.keys(formData).length!==tableData.length)

  

  return (
    <form>
      {tableData.map((column) =>
        column.toLowerCase() === "computedcolumn" ? null : (
          <div key={column}>
            <label htmlFor={column}>
              {column.replace(/_/g, " ")}:
            </label>
            {renderInputField(column)}
            {errors[column] && <p style={{ color: 'red' }}>{errors[column]}</p>}
          </div>
        )
      )}
      <button className={`button ${Object.values(errors).some(error => error !== "") || Object.keys(formData).length!==tableData.length?'button disabled':'button'}`} type="button" onClick={handleUpdate} disabled={Object.values(errors).some(error => error !== "") || Object.keys(formData).length!==tableData.length}>
        Update Data
      </button>
    </form>
  );
};

export default UpdateForm;
