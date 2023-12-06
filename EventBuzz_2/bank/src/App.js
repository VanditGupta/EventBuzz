// App.js

import React, { useState, useEffect } from "react";
import "./App.css";
import Navbar from "./Components/Navbar/Navbar";
import Content from "./Components/Content/Content";

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
  "NotificationsSendToUsers",
  "UsersRegisterForEvents",
  "EventsFundedBySponsors",
  "EventsOrganisedByOrganisers",
];

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
      <Content activeTable={activeTable} />
    </div>
  );
};

export default App;
