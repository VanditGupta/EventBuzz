const express = require("express");
const cors = require("cors");
const mysql = require("mysql2");
const app = express();

app.use(cors());
app.use(express.json());

// Update these details with your local MySQL database credentials
const DB_HOST = "localhost";
const DB_NAME = "EventBuzz";
const DB_USER = "root";
const DB_PASSWORD = "Root123!";

// MySQL Database Connection
const connection = mysql.createConnection({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASSWORD,
  database: DB_NAME
});

connection.connect(err => {
  if (err) {
    console.error('Error connecting to MySQL database:', err.message);
    return;
  }
  console.log('Connected to the MySQL database.');
});


// Function to get data from any table dynamically
const getTableDetails = (req, res, tableName) => {
  const query = `SELECT * FROM ${tableName}`;
  connection.query(query, (err, results) => {
      if (err) {
          console.error(`Error executing SQL query for ${tableName}:`, err.message);
          res.status(500).json({ error: `Failed to execute SQL query for ${tableName}. ${err.message}` });
          return;
      }
      if (results.length === 0) {
          res.status(404).json({ error: `No records found in ${tableName}.` });
          return;
      }
      res.json(results);
  });
};

// Function to insert data into any table dynamically

// const requiredUserFields = ['username', 'email', 'password', 'sex', 'role', 'status'];

// const executeInsertQuery = (req, res, tableName, data) => {
//   // Check for required fields if inserting into Users table
//   if (tableName === 'Users') {
//     const missingFields = requiredUserFields.filter(field => !data.hasOwnProperty(field));
//     if (missingFields.length > 0) {
//       res.status(400).json({ error: `Missing required fields: ${missingFields.join(', ')}` });
//       return;
//     }
//   }

//   const columns = Object.keys(data).join(", ");
//   const values = Object.values(data)
//       .map(value => mysql.escape(value))
//       .join(", ");

//   const query = `INSERT INTO ${tableName} (${columns}) VALUES (${values})`;
//   console.log(query);
//   connection.query(query, (err, result) => {
//       if (err) {
//           console.error(`Error executing SQL query for ${tableName}:`, err.message);
//           res.status(500).json({ error: `Failed to execute SQL query for ${tableName}. ${err.message}` });
//           return;
//       }
//       res.status(200).json({ message: `Row inserted in ${tableName}.`, insertedId: result.insertId });
//   });
// };

// Function to insert data into any table dynamically
const executeInsertQuery = (req, res, tableName, data) => {
  const columns = Object.keys(data).join(", ");
  const values = Object.values(data)
      .map(value => mysql.escape(value))
      .join(", ");

  const query = `INSERT INTO ${tableName} (${columns}) VALUES (${values})`;
  connection.query(query, (err, result) => {
      if (err) {
          console.error(`Error executing SQL query for ${tableName}:`, err.message);
          res.status(500).json({ error: `Failed to execute SQL query for ${tableName}. ${err.message}` });
          return;
      }
      res.status(200).json({ message: `Row inserted in ${tableName}.`, insertedId: result.insertId });
  });
};

// Function to update data in any table dynamically
const executeUpdateQuery = (req, res, tableName, primaryKey, updateData) => {
  const setClause = Object.keys(updateData)
      .map(key => `${key} = ${mysql.escape(updateData[key])}`)
      .join(", ");

  const whereClause = Array.isArray(primaryKey)
      ? primaryKey.map(key => `${key} = ${mysql.escape(req.params[key])}`).join(" AND ")
      : `${primaryKey} = ${mysql.escape(req.params[primaryKey])}`;

  const query = `UPDATE ${tableName} SET ${setClause} WHERE ${whereClause}`;
  connection.query(query, (err, result) => {
      if (err) {
          console.error(`Error executing SQL query for updating ${tableName}:`, err.message);
          res.status(500).json({ error: `Failed to execute SQL query for updating ${tableName}. ${err.message}` });
          return;
      }
      if (result.affectedRows === 0) {
          res.status(404).json({ error: `No records found in ${tableName} with specified primary key(s).` });
          return;
      }
      res.status(200).json({ message: `${tableName} updated successfully.` });
  });
};

const executeDeleteQuery = (req, res, tableName, primaryKey) => {
  const whereClause = Array.isArray(primaryKey)
      ? primaryKey.map(key => `${key} = ${mysql.escape(req.params[key])}`).join(" AND ")
      : `${primaryKey} = ${mysql.escape(req.params[primaryKey])}`;

  const query = `DELETE FROM ${tableName} WHERE ${whereClause}`;
  connection.query(query, (err, result) => {
      if (err) {
          console.error(`Error executing SQL query for deleting from ${tableName}:`, err.message);
          res.status(500).json({ error: `Failed to execute SQL query for deleting from ${tableName}. ${err.message}` });
          return;
      }
      if (result.affectedRows === 0) {
          res.status(404).json({ error: `No records found in ${tableName} with specified primary key(s).` });
          return;
      }
      res.status(200).json({ message: `${result.affectedRows} row(s) deleted from ${tableName}.` });
  });
};



// Routes for EventBuzz Schema

// Routes for inserting data into EventBuzz Schema

// Route for inserting into Users table
app.post("/insertIntoUsers", (req, res) => {
  const data = req.body;
  console.log(data);
  executeInsertQuery(req, res, "Users", data);
});

// Route for inserting into EventCategories table
app.post("/insertIntoEventCategories", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "EventCategories", data);
});

// Route for inserting into Venues table
app.post("/insertIntoVenues", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Venues", data);
});

// Route for inserting into Events table
app.post("/insertIntoEvents", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Events", data);
});

// Route for inserting into Orders table
app.post("/insertIntoOrders", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Orders", data);
});

// Route for inserting into Tickets table
app.post("/insertIntoTickets", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Tickets", data);
});

// Route for inserting into Reviews table
app.post("/insertIntoReviews", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Reviews", data);
});

// Route for inserting into Sponsors table
app.post("/insertIntoSponsors", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Sponsors", data);
});


// Route for inserting into Organisers table
app.post("/insertIntoOrganisers", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Organisers", data);
});


// Route for inserting into Notifications table
app.post("/insertIntoNotifications", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Notifications", data);
});

// Route for inserting into NotificationsSendToUsers table
app.post("/insertIntoNotificationsSendToUsers", (req, res) => {
  const tableName = "NotificationsSendToUsers";
  const data = req.body; 
  executeInsertQuery(req, res, tableName, data);
});

// Route for inserting into UsersRegisterForEvents table
app.post("/insertIntoUsersRegisterForEvents", (req, res) => {
  const tableName = "UsersRegisterForEvents";
  const data = req.body; 
  executeInsertQuery(req, res, tableName, data);
});

// Route for inserting into EventsFundedBySponsors table
app.post("/insertIntoEventsFundedBySponsors", (req, res) => {
  const tableName = "EventsFundedBySponsors";
  const data = req.body;
  executeInsertQuery(req, res, tableName, data);
});

// Route for inserting into EventsOrganisedByOrganisers table
app.post("/insertIntoEventsOrganisedByOrganisers", (req, res) => {
  const tableName = "EventsOrganisedByOrganisers";
  const data = req.body;
  executeInsertQuery(req, res, tableName, data);
});

// Routes for getting data from EventBuzz Schema

// Route for getting data from Users table
app.get("/getUsers", (req, res) =>
  getTableDetails(req, res, "Users")
);

// Route for getting data from EventCategories table
app.get("/getEventCategories", (req, res) =>
  getTableDetails(req, res, "EventCategories")
);

// Route for getting data from Venues table
app.get("/getVenues", (req, res) =>
  getTableDetails(req, res, "Venues")
);

// Route for getting data from Events table
app.get("/getEvents", (req, res) =>
  getTableDetails(req, res, "Events")
);

// Route for getting data from Orders table
app.get("/getOrders", (req, res) =>
  getTableDetails(req, res, "Orders")
);

// Route for getting data from Tickets table
app.get("/getTickets", (req, res) =>
  getTableDetails(req, res, "Tickets")
);

// Route for getting data from Reviews table
app.get("/getReviews", (req, res) =>
  getTableDetails(req, res, "Reviews")
);

// Route for getting data from Sponsors table
app.get("/getSponsors", (req, res) =>
  getTableDetails(req, res, "Sponsors")
);

// Route for getting data from Organisers table
app.get("/getOrganisers", (req, res) =>
  getTableDetails(req, res, "Organisers")
);

// Route for getting data from Notifications table
app.get("/getNotifications", (req, res) =>
  getTableDetails(req, res, "Notifications")
);

// Route for getting data from NotificationsSendToUsers table
app.get("/getNotificationsSendToUsers", (req, res) =>
  getTableDetails(req, res, "NotificationsSendToUsers")
);

// Route for getting data from UsersRegisterForEvents table
app.get("/getUsersRegisterForEvents", (req, res) =>
  getTableDetails(req, res, "UsersRegisterForEvents")
);

// Route for getting data from EventsFundedBySponsors table
app.get("/getEventsFundedBySponsors", (req, res) =>
  getTableDetails(req, res, "EventsFundedBySponsors")
);

// Route for getting data from EventsOrganisedByOrganisers table
app.get("/getEventsOrganisedByOrganisers", (req, res) =>
  getTableDetails(req, res, "EventsOrganisedByOrganisers")
);


// Update Routes for EventBuzz Schema

// Route for updating Users table

app.put("/updateUser/:user_id", (req, res) => {
  const primaryKey = "user_id";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Users", primaryKey, updateData);
});

// Route for updating EventCategories table
app.put("/updateEventCategory/:category_name", (req, res) => {
  const primaryKey = "category_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "EventCategories", primaryKey, updateData);
});

// Route for updating Venues table
app.put("/updateVenue/:venue_name", (req, res) => {
  const primaryKey = "venue_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Venues", primaryKey, updateData);
});

// Route for updating Events table
app.put("/updateEvent/:event_name", (req, res) => {
  const primaryKey = "event_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Events", primaryKey, updateData);
});

// Route for updating Orders table
app.put("/updateOrder/:order_id", (req, res) => {
  const primaryKey = "order_id";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Orders", primaryKey, updateData);
});

// Route for updating Tickets table
app.put("/updateTicket/:ticket_id", (req, res) => {
  const primaryKey = "ticket_id";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Tickets", primaryKey, updateData);
});

// Route for updating Reviews table with composite primary key
app.put("/updateReview/:user_id/:event_name", (req, res) => {
  const primaryKey = ["user_id", "event_name"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "Reviews", primaryKey, updateData);
});

// Route for updating Sponsors table
app.put("/updateSponsor/:sponsor_name", (req, res) => {
  const primaryKey = "sponsor_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Sponsors", primaryKey, updateData);
});

// Route for updating Organisers table
app.put("/updateOrganiser/:organiser_name", (req, res) => {
  const primaryKey = "organiser_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Organisers", primaryKey, updateData);
});

// Route for updating Notifications table with composite primary keys
app.put("/updateNotification/:notification_id/:event_name", (req, res) => {
  const primaryKey = ["notification_id", "event_name"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "Notifications", primaryKey, updateData);
});

// Route for updating NotificationsSendToUsers table with composite primary keys
app.put("/updateNotificationsSendToUsers/:notification_id/:user_id", (req, res) => {
  const primaryKey = ["notification_id", "user_id"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "NotificationsSendToUsers", primaryKey, updateData);
});

// Route for updating UsersRegisterForEvents table with composite primary keys
app.put("/updateUsersRegisterForEvents/:user_id/:event_name", (req, res) => {
  const primaryKey = ["user_id", "event_name"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "UsersRegisterForEvents", primaryKey, updateData);
});

// Route for updating EventsFundedBySponsors table with composite primary keys
app.put("/updateEventsFundedBySponsors/:event_name/:sponsor_name", (req, res) => {
  const primaryKey = ["event_name", "sponsor_name"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "EventsFundedBySponsors", primaryKey, updateData);
});

// Route for updating EventsOrganisedByOrganisers table with composite primary keys
app.put("/updateEventsOrganisedByOrganisers/:event_name/:organiser_name", (req, res) => {
  const primaryKey = ["event_name", "organiser_name"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "EventsOrganisedByOrganisers", primaryKey, updateData);
});


// Delete Routes for EventBuzz Schema

// Route for deleting from Users table
app.delete("/deleteUsers/:user_id", (req, res) => {
  const primaryKey = "user_id";
  executeDeleteQuery(req, res, "Users", primaryKey);
});

// Route for deleting from EventCategories table
app.delete("/deleteEventCategories/:category_name", (req, res) => {
  const primaryKey = "category_name";
  executeDeleteQuery(req, res, "EventCategories", primaryKey);
});

// Route for deleting from Venues table
app.delete("/deleteVenues/:venue_name", (req, res) => {
  const primaryKey = "venue_name";
  executeDeleteQuery(req, res, "Venues", primaryKey);
});

// Route for deleting from Events table
app.delete("/deleteEvents/:event_name", (req, res) => {
  const primaryKey = "event_name";
  executeDeleteQuery(req, res, "Events", primaryKey);
});

// Route for deleting from Orders table
app.delete("/deleteOrders/:order_id", (req, res) => {
  const primaryKey = "order_id";
  executeDeleteQuery(req, res, "Orders", primaryKey);
});

// Route for deleting from Tickets table
app.delete("/deleteTickets/:ticket_id", (req, res) => {
  const primaryKey = "ticket_id";
  executeDeleteQuery(req, res, "Tickets", primaryKey);
});

// Route for deleting from Reviews table with composite primary key
app.delete("/deleteReviews/:user_id/:event_name", (req, res) => {
  const primaryKey = ["user_id", "event_name"];
  executeDeleteQuery(req, res, "Reviews", primaryKey);
});

// Route for deleting from Sponsors table
app.delete("/deleteSponsors/:sponsor_name", (req, res) => {
  const primaryKey = "sponsor_name";
  executeDeleteQuery(req, res, "Sponsors", primaryKey);
});

// Route for deleting from Organisers table
app.delete("/deleteOrganisers/:organiser_name", (req, res) => {
  const primaryKey = "organiser_name";
  executeDeleteQuery(req, res, "Organisers", primaryKey);
});

// Route for deleting from Notifications table with composite primary keys
app.delete("/deleteNotifications/:notification_id/:event_name", (req, res) => {
  const primaryKey = ["notification_id", "event_name"];
  executeDeleteQuery(req, res, "Notifications", primaryKey);
});

// Route for deleting from NotificationsSendToUsers table with composite primary keys
app.delete("/deleteNotificationsSendToUsers/:notification_id/:user_id", (req, res) => {
  const primaryKey = ["notification_id", "user_id"];
  executeDeleteQuery(req, res, "NotificationsSendToUsers", primaryKey);
});

// Route for deleting from UsersRegisterForEvents table with composite primary keys
app.delete("/deleteUsersRegisterForEvents/:user_id/:event_name", (req, res) => {
  const primaryKey = ["user_id", "event_name"];
  executeDeleteQuery(req, res, "UsersRegisterForEvents", primaryKey);
});

// Route for deleting from EventsFundedBySponsors table with composite primary keys
app.delete("/deleteEventsFundedBySponsors/:event_name/:sponsor_name", (req, res) => {
  const primaryKey = ["event_name", "sponsor_name"];
  executeDeleteQuery(req, res, "EventsFundedBySponsors", primaryKey);
});

// Route for deleting from EventsOrganisedByOrganisers table with composite primary keys
app.delete("/deleteEventsOrganisedByOrganisers/:event_name/:organiser_name", (req, res) => {
  const primaryKey = ["event_name", "organiser_name"];
  executeDeleteQuery(req, res, "EventsOrganisedByOrganisers", primaryKey);
});

// Server Initialization
const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
