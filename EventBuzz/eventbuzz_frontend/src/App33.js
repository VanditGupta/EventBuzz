// App.js

import React, { useState, useEffect } from "react";
import "./App.css";
import Navbar from "./Components/Navbar/Navbar";

const tables = [
  "Users",
  "EventCategories",
  "Venues",
  "Events",
  "Orders",
  "Tickets",
  "Reviews",
  "Sponsors",
  "Organisers",
  "Notifications",
  "Notifications_SendTo_Users",
  "Users_RegisterFor_Events",
  "Events_FundedBy_Sponsors",
  "Events_OrganisedBy_Organisers",
];

const TableData = ({ activeTable }) => {
  const [tableData, setTableData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(`http://localhost:4000/${activeTable}`); // Adjust URL as needed
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        setTableData(data);
      } catch (error) {
        console.error("Error fetching data:", error);
        // Handle the error appropriately in your UI
      }
    };

    fetchData();
  }, [activeTable]);

  return (
    <div>
      <h1>{activeTable}</h1>
      <table>
        <thead>
          <tr>
            {tableData.length > 0 && Object.keys(tableData[0]).map((key, index) => (
              <th key={index}>{key}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {tableData.map((row, rowIndex) => (
            <tr key={rowIndex}>
              {Object.values(row).map((value, colIndex) => (
                <td key={colIndex}>{value}</td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

const App = () => {
  const [activeTable, setActiveTable] = useState(tables[0]);
  const [isNavbarOpen, setNavbarOpen] = useState(false);

  const handleTableClick = (tableName) => {
    setActiveTable(tableName);
    setNavbarOpen(false);
  };

  const toggleNavbar = () => {
    setNavbarOpen(!isNavbarOpen);
  };

  return (
    <div className={`app-container ${isNavbarOpen ? "open" : ""}`}>
      <Navbar
        tables={tables}
        activeTable={activeTable}
        onTableClick={handleTableClick}
        isNavbarOpen={isNavbarOpen}
        onToggleNavbar={toggleNavbar}
      />
      <TableData activeTable={activeTable} />
    </div>
  );
};

export default App;