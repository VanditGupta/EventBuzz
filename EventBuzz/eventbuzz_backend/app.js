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
app.get("/getUsersV2", (req, res) =>
  getTableDetails(req, res, "Users")
);

// Route for getting data from EventCategories table
app.get("/getEventCategoriesV2", (req, res) =>
  getTableDetails(req, res, "EventCategories")
);

// Route for getting data from Venues table
app.get("/getVenuesV2", (req, res) =>
  getTableDetails(req, res, "Venues")
);

// Route for getting data from Events table
app.get("/getEventsV2", (req, res) =>
  getTableDetails(req, res, "Events")
);

// Route for getting data from Orders table
app.get("/getOrdersV2", (req, res) =>
  getTableDetails(req, res, "Orders")
);

// Route for getting data from Tickets table
app.get("/getTicketsV2", (req, res) =>
  getTableDetails(req, res, "Tickets")
);

// Route for getting data from Reviews table
app.get("/getReviewsV2", (req, res) =>
  getTableDetails(req, res, "Reviews")
);

// Route for getting data from Sponsors table
app.get("/getSponsorsV2", (req, res) =>
  getTableDetails(req, res, "Sponsors")
);

// Route for getting data from Organisers table
app.get("/getOrganisersV2", (req, res) =>
  getTableDetails(req, res, "Organisers")
);

// Route for getting data from Notifications table
app.get("/getNotificationsV2", (req, res) =>
  getTableDetails(req, res, "Notifications")
);

// Route for getting data from NotificationsSendToUsers table
app.get("/getNotificationsSendToUsersV2", (req, res) =>
  getTableDetails(req, res, "NotificationsSendToUsers")
);

// Route for getting data from UsersRegisterForEvents table
app.get("/getUsersRegisterForEventsV2", (req, res) =>
  getTableDetails(req, res, "UsersRegisterForEvents")
);

// Route for getting data from EventsFundedBySponsors table
app.get("/getEventsFundedBySponsorsV2", (req, res) =>
  getTableDetails(req, res, "EventsFundedBySponsors")
);

// Route for getting data from EventsOrganisedByOrganisers table
app.get("/getEventsOrganisedByOrganisersV2", (req, res) =>
  getTableDetails(req, res, "EventsOrganisedByOrganisers")
);


// Update Routes for EventBuzz Schema

// Route for updating Users table

app.put("/updateUsers/:user_id", (req, res) => {
  const primaryKey = "user_id";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Users", primaryKey, updateData);
});

// Route for updating EventCategories table
app.put("/updateEventCategories/:category_name", (req, res) => {
  const primaryKey = "category_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "EventCategories", primaryKey, updateData);
});

// Route for updating Venues table
app.put("/updateVenues/:venue_name", (req, res) => {
  const primaryKey = "venue_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Venues", primaryKey, updateData);
});

// Route for updating Events table
app.put("/updateEvents/:event_name", (req, res) => {
  const primaryKey = "event_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Events", primaryKey, updateData);
});

// Route for updating Orders table
app.put("/updateOrders/:order_id", (req, res) => {
  const primaryKey = "order_id";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Orders", primaryKey, updateData);
});

// Route for updating Tickets table
app.put("/updateTickets/:ticket_id", (req, res) => {
  const primaryKey = "ticket_id";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Tickets", primaryKey, updateData);
});

// Route for updating Reviews table with composite primary key
app.put("/updateReviews/:user_id/:event_name", (req, res) => {
  const primaryKey = ["user_id", "event_name"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "Reviews", primaryKey, updateData);
});

// Route for updating Sponsors table
app.put("/updateSponsors/:sponsor_name", (req, res) => {
  const primaryKey = "sponsor_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Sponsors", primaryKey, updateData);
});

// Route for updating Organisers table
app.put("/updateOrganisers/:organiser_name", (req, res) => {
  const primaryKey = "organiser_name";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Organisers", primaryKey, updateData);
});

// Route for updating Notifications table with composite primary keys
app.put("/updateNotifications/:notification_id/:event_name", (req, res) => {
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
app.delete("/deleteUsersV2/:user_id", (req, res) => {
  const primaryKey = "user_id";
  executeDeleteQuery(req, res, "Users", primaryKey);
});

// Route for deleting from EventCategories table
app.delete("/deleteEventCategoriesV2/:category_name", (req, res) => {
  const primaryKey = "category_name";
  executeDeleteQuery(req, res, "EventCategories", primaryKey);
});

// Route for deleting from Venues table
app.delete("/deleteVenuesV2/:venue_name", (req, res) => {
  const primaryKey = "venue_name";
  executeDeleteQuery(req, res, "Venues", primaryKey);
});

// Route for deleting from Events table
app.delete("/deleteEventsV2/:event_name", (req, res) => {
  const primaryKey = "event_name";
  executeDeleteQuery(req, res, "Events", primaryKey);
});

// Route for deleting from Orders table
app.delete("/deleteOrdersV2/:order_id", (req, res) => {
  const primaryKey = "order_id";
  executeDeleteQuery(req, res, "Orders", primaryKey);
});

// Route for deleting from Tickets table
app.delete("/deleteTicketsV2/:ticket_id", (req, res) => {
  const primaryKey = "ticket_id";
  executeDeleteQuery(req, res, "Tickets", primaryKey);
});

// Route for deleting from Reviews table with composite primary key
app.delete("/deleteReviewsV2/:user_id/:event_name", (req, res) => {
  const primaryKey = ["user_id", "event_name"];
  executeDeleteQuery(req, res, "Reviews", primaryKey);
});

// Route for deleting from Sponsors table
app.delete("/deleteSponsorsV2/:sponsor_name", (req, res) => {
  const primaryKey = "sponsor_name";
  executeDeleteQuery(req, res, "Sponsors", primaryKey);
});

// Route for deleting from Organisers table
app.delete("/deleteOrganisersV2/:organiser_name", (req, res) => {
  const primaryKey = "organiser_name";
  executeDeleteQuery(req, res, "Organisers", primaryKey);
});

// Route for deleting from Notifications table with composite primary keys
app.delete("/deleteNotificationsV2/:notification_id/:event_name", (req, res) => {
  const primaryKey = ["notification_id", "event_name"];
  executeDeleteQuery(req, res, "Notifications", primaryKey);
});

// Route for deleting from NotificationsSendToUsers table with composite primary keys
app.delete("/deleteNotificationsSendToUsersV2/:notification_id/:user_id", (req, res) => {
  const primaryKey = ["notification_id", "user_id"];
  executeDeleteQuery(req, res, "NotificationsSendToUsers", primaryKey);
});

// Route for deleting from UsersRegisterForEvents table with composite primary keys
app.delete("/deleteUsersRegisterForEventsV2/:user_id/:event_name", (req, res) => {
  const primaryKey = ["user_id", "event_name"];
  executeDeleteQuery(req, res, "UsersRegisterForEvents", primaryKey);
});

// Route for deleting from EventsFundedBySponsors table with composite primary keys
app.delete("/deleteEventsFundedBySponsorsV2/:event_name/:sponsor_name", (req, res) => {
  const primaryKey = ["event_name", "sponsor_name"];
  executeDeleteQuery(req, res, "EventsFundedBySponsors", primaryKey);
});

// Route for deleting from EventsOrganisedByOrganisers table with composite primary keys
app.delete("/deleteEventsOrganisedByOrganisersV2/:event_name/:organiser_name", (req, res) => {
  const primaryKey = ["event_name", "organiser_name"];
  executeDeleteQuery(req, res, "EventsOrganisedByOrganisers", primaryKey);
});

/* ------------------------ */

// Route for calling the GetUsers() using stored procedure

app.get("/getUsers", (req, res) => {
  connection.query(
      'CALL GetUsers()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetUsers:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
});

// Route for calling the GetEventCategories() using stored procedure

app.get("/getEventCategories", (req, res) => {
  connection.query(
      'CALL GetEventCategories()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetEventCategories:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the GetVenues() using stored procedure

app.get("/getVenues", (req, res) => {
  connection.query(
      'CALL GetVenues()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetVenues:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the GetEvents() using stored procedure

app.get("/getEvents", (req, res) => {
  connection.query(
      'CALL GetEvents()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetEvents:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the GetOrders() using stored procedure

app.get("/getOrders", (req, res) => {
  connection.query(
      'CALL GetOrders()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetOrders:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the GetTickets() using stored procedure

app.get("/getTickets", (req, res) => {
  connection.query(
      'CALL GetTickets()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetTickets:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the GetReviews() using stored procedure

app.get("/getReviews", (req, res) => {
  connection.query(
      'CALL GetReviews()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetReviews:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the GetSponsors() using stored procedure

app.get("/getSponsors", (req, res) => {
  connection.query(
      'CALL GetSponsors()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetSponsors:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the GetOrganisers() using stored procedure

app.get("/getOrganisers", (req, res) => {
  connection.query(
      'CALL GetOrganisers()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetOrganisers:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the GetNotifications() using stored procedure

app.get("/getNotifications", (req, res) => {
  connection.query(
      'CALL GetNotifications()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetNotifications:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);


// Route for calling the GetNotificationsSendToUsers() using stored procedure

app.get("/getNotificationsSendToUsers", (req, res) => {
  connection.query(
      'CALL GetNotificationsSendToUsers()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetNotificationsSendToUsers:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);


// Route for calling the GetUsersRegisterForEvents() using stored procedure

app.get("/getUsersRegisterForEvents", (req, res) => {
  connection.query(
      'CALL GetUsersRegisterForEvents()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetUsersRegisterForEvents:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);


// Route for calling the GetEventsFundedBySponsors() using stored procedure

app.get("/getEventsFundedBySponsors", (req, res) => {
  connection.query(
      'CALL GetEventsFundedBySponsors()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetEventsFundedBySponsors:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);


// Route for calling the GetEventsOrganisedByOrganisers() using stored procedure

app.get("/getEventsOrganisedByOrganisers", (req, res) => {
  connection.query(
      'CALL GetEventsOrganisedByOrganisers()',
      (err, results) => {
          if (err) {
              console.error('Error executing stored procedure GetEventsOrganisedByOrganisers:', err.message);
              res.status(500).json({ error: err.message });
              return;
          }
          res.json(results[0]);
      }
  );
}
);

// Route for calling the InsertUser() using stored procedure

app.post('/insertIntoUsersV2', (req, res) => {
  const {
      username,
      email,
      password,
      first_name,
      last_name,
      date_of_birth,
      sex,
      contact_phone,
      street_no,
      street_name,
      unit_no,
      city,
      state,
      zip_code,
      country,
      profile_picture_url,
      role,
      status
  } = req.body;

  connection.query(
      'CALL InsertUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
          username,
          email,
          password,
          first_name,
          last_name,
          date_of_birth,
          sex,
          contact_phone,
          street_no,
          street_name,
          unit_no,
          city,
          state,
          zip_code,
          country,
          profile_picture_url,
          role,
          status
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new user:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New user added successfully' });
      }
  );
});

// Route for calling the InsertEventCategory() using stored procedure

app.post('/insertIntoEventCategoriesV2', (req, res) => {
  const { category_name, description } = req.body;

  connection.query(
      'CALL InsertEventCategory(?, ?)',
      [category_name, description],
      (err, results) => {
          if (err) {
              console.error('Error inserting new event category:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New event category added successfully' });
      }
  );
}
);

// Route for calling the InsertVenue() using stored procedure

app.post('/insertIntoVenuesV2', (req, res) => {
  const {
      venue_name,
      street_no,
      street_name,
      unit_no,
      city,
      state,
      zip_code,
      max_capacity,
      contact_email,
      contact_phone
  } = req.body;

  connection.query(
      'CALL InsertVenue(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
          venue_name,
          street_no,
          street_name,
          unit_no,
          city,
          state,
          zip_code,
          max_capacity,
          contact_email,
          contact_phone
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new venue:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New venue added successfully' });
      }
  );
});

// Route for calling the InsertEvent() using stored procedure

app.post('/insertIntoEventsV2', (req, res) => {
  const {
      event_name,
      event_description,
      event_date,
      event_time,
      event_status,
      event_image_url,
      category_name,
      venue_name
  } = req.body;

  connection.query(
      'CALL InsertEvent(?, ?, ?, ?, ?, ?, ?, ?)',
      [
          event_name,
          event_description,
          event_date,
          event_time,
          event_status,
          event_image_url,
          category_name,
          venue_name
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new event:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New event added successfully' });
      }
  );
});


// Route for calling the InsertOrder() using stored procedure

app.post('/insertIntoOrdersV2', (req, res) => {
  const {
      order_id,
      order_date,
      payment_type,
      payment_status,
      total_amount,
      user_id,
      event_name
  } = req.body;

  connection.query(
      'CALL InsertOrder(?, ?, ?, ?, ?, ?, ?)',
      [
          order_id,
          order_date,
          payment_type,
          payment_status,
          total_amount,
          user_id,
          event_name
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new order:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New order added successfully' });
      }
  );
});


// Route for calling the InsertTicket() using stored procedure

app.post('/insertIntoTicketsV2', (req, res) => {
  const {
      ticket_price,
      ticket_quantity,
      start_sale_date,
      end_sale_date,
      event_name,
      order_id
  } = req.body;

  connection.query(
      'CALL InsertTicket(?, ?, ?, ?, ?, ?)',
      [
          ticket_price,
          ticket_quantity,
          start_sale_date,
          end_sale_date,
          event_name,
          order_id
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new ticket:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New ticket added successfully' });
      }
  );
});


// Route for calling the InsertReview() using stored procedure

app.post('/insertIntoReviewsV2', (req, res) => {
  const {
      rating,
      comment,
      review_date,
      user_id,
      event_name
  } = req.body;

  connection.query(
      'CALL InsertReview(?, ?, ?, ?, ?)',
      [
          rating,
          comment,
          review_date,
          user_id,
          event_name
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new review:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New review added successfully' });
      }
  );
});


// Route for calling the InsertSponsor() using stored procedure

app.post('/insertIntoSponsorsV2', (req, res) => {
  const {
      sponsor_name,
      description,
      website_url,
      logo_url,
      contact_email,
      contact_phone,
      total_sponsorship_amount
  } = req.body;

  connection.query(
      'CALL InsertSponsor(?, ?, ?, ?, ?, ?, ?)',
      [
          sponsor_name,
          description,
          website_url,
          logo_url,
          contact_email,
          contact_phone,
          total_sponsorship_amount
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new sponsor:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New sponsor added successfully' });
      }
  );
});


// Route for calling the InsertOrganiser() using stored procedure

app.post('/insertIntoOrganisersV2', (req, res) => {
  const {
      organiser_name,
      description,
      logo_url,
      contact_email,
      contact_phone
  } = req.body;

  connection.query(
      'CALL InsertOrganiser(?, ?, ?, ?, ?)',
      [
          organiser_name,
          description,
          logo_url,
          contact_email,
          contact_phone
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new organiser:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New organiser added successfully' });
      }
  );
});


// Route for calling the InsertNotification() using stored procedure

app.post('/insertIntoNotificationsV2', (req, res) => {
  const {
      notification_id,
      notification_text,
      notification_date,
      event_name
  } = req.body;

  connection.query(
      'CALL InsertNotification(?, ?, ?, ?)',
      [
          notification_id,
          notification_text,
          notification_date,
          event_name
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting new notification:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'New notification added successfully' });
      }
  );
});


// Route for calling the InsertNotificationSendToUsers() using stored procedure

app.post('/insertIntoNotificationsSendToUsersV2', (req, res) => {
  const {
      user_id,
      notification_id,
      priority
  } = req.body;

  connection.query(
      'CALL InsertNotificationSendToUsers(?, ?, ?)',
      [
          user_id,
          notification_id,
          priority
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting notification-user linkage:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'Notification-user linkage added successfully' });
      }
  );
});


// Route for calling the InsertUserRegisterForEvent() using stored procedure

app.post('/insertIntoUsersRegisterForEventsV2', (req, res) => {
  const {
      user_id,
      event_name,
      registration_date
  } = req.body;

  connection.query(
      'CALL InsertUserRegisterForEvents(?, ?, ?)',
      [
          user_id,
          event_name,
          registration_date
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting user event registration:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'User event registration added successfully' });
      }
  );
});


// Route for calling the InsertEventFundedBySponsor() using stored procedure

app.post('/insertIntoEventsFundedBySponsorsV2', (req, res) => {
  const {
      event_name,
      sponsor_name,
      sponsorship_amount,
      sponsorship_date
  } = req.body;

  connection.query(
      'CALL InsertEventFundedBySponsors(?, ?, ?, ?)',
      [
          event_name,
          sponsor_name,
          sponsorship_amount,
          sponsorship_date
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting event sponsorship:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'Event sponsorship added successfully' });
      }
  );
});


// Route for calling the InsertEventOrganisedByOrganiser() using stored procedure

app.post('/insertIntoEventsOrganisedByOrganisersV2', (req, res) => {
  const {
      event_name,
      organiser_name,
      organiser_role
  } = req.body;

  connection.query(
      'CALL InsertEventOrganisedByOrganisers(?, ?, ?)',
      [
          event_name,
          organiser_name,
          organiser_role
      ],
      (err, results) => {
          if (err) {
              console.error('Error inserting event-organiser linkage:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(201).json({ message: 'Event-organiser linkage added successfully' });
      }
  );
});

// Route for calling the UpdateUser() using stored procedure

app.put('/updateUsersV2/:user_id', (req, res) => {
  const { user_id } = req.params;
  const {
      username,
      email,
      first_name,
      last_name,
      date_of_birth,
      sex,
      contact_phone,
      street_no,
      street_name,
      unit_no,
      city,
      state,
      zip_code,
      country,
      profile_picture_url,
      role,
      status
  } = req.body;

  connection.query(
      'CALL UpdateUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
          user_id,
          username,
          email,
          first_name,
          last_name,
          date_of_birth,
          sex,
          contact_phone,
          street_no,
          street_name,
          unit_no,
          city,
          state,
          zip_code,
          country,
          profile_picture_url,
          role,
          status
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating user:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'User updated successfully' });
      }
  );
});

// Route for calling the UpdateEventCategory() using stored procedure

app.put('/updateEventCategoriesV2/:category_name', (req, res) => {
  const { category_name } = req.params;
  const { description } = req.body;

  connection.query(
      'CALL UpdateEventCategory(?, ?)',
      [category_name, description],
      (err, results) => {
          if (err) {
              console.error('Error updating event category:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Event category updated successfully' });
      }
  );
});

// Route for calling the UpdateVenue() using stored procedure

app.put('/updateVenuesV2/:venue_name', (req, res) => {
  const { venue_name } = req.params;
  const {
      street_no,
      street_name,
      unit_no,
      city,
      state,
      zip_code,
      max_capacity,
      contact_email,
      contact_phone
  } = req.body;

  connection.query(
      'CALL UpdateVenue(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
          venue_name,
          street_no,
          street_name,
          unit_no,
          city,
          state,
          zip_code,
          max_capacity,
          contact_email,
          contact_phone
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating venue:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Venue updated successfully' });
      }
  );
});


// Route for calling the UpdateEvent() using stored procedure

app.put('/updateEventsV2/:event_name', (req, res) => {
  const { event_name } = req.params;
  const {
      event_description,
      event_date,
      event_time,
      event_status,
      event_image_url,
      category_name,
      venue_name
  } = req.body;

  connection.query(
      'CALL UpdateEvent(?, ?, ?, ?, ?, ?, ?, ?)',
      [
          event_name,
          event_description,
          event_date,
          event_time,
          event_status,
          event_image_url,
          category_name,
          venue_name
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating event:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Event updated successfully' });
      }
  );
});


// Route for calling the UpdateOrder() using stored procedure

app.put('/updateOrdersV2/:order_id', (req, res) => {
  const { order_id } = req.params;
  const {
      order_date,
      payment_type,
      payment_status,
      total_amount,
      user_id,
      event_name
  } = req.body;

  connection.query(
      'CALL UpdateOrder(?, ?, ?, ?, ?, ?, ?)',
      [
          order_id,
          order_date,
          payment_type,
          payment_status,
          total_amount,
          user_id,
          event_name
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating order:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Order updated successfully' });
      }
  );
});


// Route for calling the UpdateTicket() using stored procedure

app.put('/updateTicketsV2/:ticket_id', (req, res) => {
  const { ticket_id } = req.params;
  const {
      ticket_price,
      ticket_quantity,
      start_sale_date,
      end_sale_date,
      event_name,
      order_id
  } = req.body;

  connection.query(
      'CALL UpdateTicket(?, ?, ?, ?, ?)',
      [
          ticket_id,
          ticket_price,
          ticket_quantity,
          start_sale_date,
          end_sale_date,
          event_name,
          order_id
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating ticket:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Ticket updated successfully' });
      }
  );
});


// Route for calling the UpdateReview() using stored procedure

app.put('/updateReviewsV2/:user_id/:event_name', (req, res) => {
  const { user_id, event_name } = req.params;
  const {
      rating,
      comment,
      review_date
  } = req.body;

  connection.query(
      'CALL UpdateReview(?, ?, ?, ?, ?)',
      [
          rating,
          comment,
          review_date,
          user_id,
          event_name
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating review:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Review updated successfully' });
      }
  );
});


// Route for calling the UpdateSponsor() using stored procedure

app.put('/updateSponsorsV2/:sponsor_name', (req, res) => {
  const { sponsor_name } = req.params;
  const {
      description,
      website_url,
      logo_url,
      contact_email,
      contact_phone,
      total_sponsorship_amount
  } = req.body;

  connection.query(
      'CALL UpdateSponsor(?, ?, ?, ?, ?, ?, ?)',
      [
          sponsor_name,
          description,
          website_url,
          logo_url,
          contact_email,
          contact_phone,
          total_sponsorship_amount
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating sponsor:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Sponsor updated successfully' });
      }
  );
});


// Route for calling the UpdateOrganiser() using stored procedure

app.put('/updateOrganisersV2/:organiser_name', (req, res) => {
  const { organiser_name } = req.params;
  const {
      description,
      logo_url,
      contact_email,
      contact_phone
  } = req.body;

  connection.query(
      'CALL UpdateOrganiser(?, ?, ?, ?, ?)',
      [
          organiser_name,
          description,
          logo_url,
          contact_email,
          contact_phone
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating organiser:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Organiser updated successfully' });
      }
  );
});


// Route for calling the UpdateNotification() using stored procedure

app.put('/updateNotificationsV2/:notification_id/:event_name', (req, res) => {
  const { notification_id } = req.params;
  const {
      notification_text,
      notification_date,
      event_name
  } = req.body;

  connection.query(
      'CALL UpdateNotification(?, ?, ?, ?)',
      [
          notification_id,
          notification_text,
          notification_date,
          event_name
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating notification:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Notification updated successfully' });
      }
  );
});


// Route for calling the updateNotificationsSendToUsers() using stored procedure

app.put('/updateNotificationsSendToUsersV2/:user_id/:notification_id', (req, res) => {
  const { user_id, notification_id } = req.params;
  const { priority } = req.body;

  connection.query(
      'CALL UpdateNotificationSendToUsers(?, ?, ?)',
      [
          user_id,
          notification_id,
          priority
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating NotificationSendToUser:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'NotificationSendToUser updated successfully' });
      }
  );
});


// Route for calling the updateUsersRegisterForEvents() using stored procedure

app.put('/updateUsersRegisterForEventsV2/:user_id/:event_name', (req, res) => {
  const { user_id, event_name } = req.params;
  const { registration_date } = req.body;

  connection.query(
      'CALL UpdateUserRegisterForEvents(?, ?, ?)',
      [
          user_id,
          event_name,
          registration_date
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating UserRegisterForEvent:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'User registration for event updated successfully' });
      }
  );
});


// Route for calling the updateEventsFundedBySponsors() using stored procedure

app.put('/updateEventsFundedBySponsorsV2/:event_name/:sponsor_name', (req, res) => {
  const { event_name, sponsor_name } = req.params;
  const { sponsorship_amount, sponsorship_date } = req.body;

  connection.query(
      'CALL UpdateEventFundedBySponsors(?, ?, ?, ?)',
      [
          event_name,
          sponsor_name,
          sponsorship_amount,
          sponsorship_date
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating EventFundedBySponsor:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Event sponsorship updated successfully' });
      }
  );
});


// Route for calling the updateEventsOrganisedByOrganisers() using stored procedure

app.put('/updateEventsOrganisedByOrganisersV2/:event_name/:organiser_name', (req, res) => {
  const { event_name, organiser_name } = req.params;
  const { organiser_role } = req.body;

  connection.query(
      'CALL UpdateEventOrganisedByOrganisers(?, ?, ?)',
      [
          event_name,
          organiser_name,
          organiser_role
      ],
      (err, results) => {
          if (err) {
              console.error('Error updating EventOrganisedByOrganiser:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Event organiser updated successfully' });
      }
  );
});


// Route for calling the DeleteUser() using stored procedure

app.delete('/deleteUsers/:user_id', (req, res) => {
  const { user_id } = req.params;

  connection.query(
      'CALL DeleteUser(?)',
      [user_id],
      (err, results) => {
          if (err) {
              console.error('Error deleting user:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'User deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteEventCategory() using stored procedure

app.delete('/deleteEventCategories/:category_name', (req, res) => {
  const { category_name } = req.params;

  connection.query(
      'CALL DeleteEventCategory(?)',
      [category_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting event category:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Event category deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteVenue() using stored procedure

app.delete('/deleteVenues/:venue_name', (req, res) => {
  const { venue_name } = req.params;

  connection.query(
      'CALL DeleteVenue(?)',
      [venue_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting venue:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Venue deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteEvent() using stored procedure

app.delete('/deleteEvents/:event_name', (req, res) => {
  const { event_name } = req.params;

  connection.query(
      'CALL DeleteEvent(?)',
      [event_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting event:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Event deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteOrder() using stored procedure

app.delete('/deleteOrders/:order_id', (req, res) => {
  const { order_id } = req.params;

  connection.query(
      'CALL DeleteOrder(?)',
      [order_id],
      (err, results) => {
          if (err) {
              console.error('Error deleting order:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Order deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteTicket() using stored procedure

app.delete('/deleteTickets/:ticket_id', (req, res) => {
  const { ticket_id } = req.params;

  connection.query(
      'CALL DeleteTicket(?)',
      [ticket_id],
      (err, results) => {
          if (err) {
              console.error('Error deleting ticket:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Ticket deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteReview() using stored procedure

app.delete('/deleteReviews/:user_id/:event_name', (req, res) => {
  const { user_id, event_name } = req.params;

  connection.query(
      'CALL DeleteReview(?, ?)',
      [user_id, event_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting review:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Review deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteSponsor() using stored procedure

app.delete('/deleteSponsors/:sponsor_name', (req, res) => {
  const { sponsor_name } = req.params;

  connection.query(
      'CALL DeleteSponsor(?)',
      [sponsor_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting sponsor:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Sponsor deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteOrganiser() using stored procedure

app.delete('/deleteOrganisers/:organiser_name', (req, res) => {
  const { organiser_name } = req.params;

  connection.query(
      'CALL DeleteOrganiser(?)',
      [organiser_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting organiser:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Organiser deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteNotification() using stored procedure

app.delete('/deleteNotifications/:notification_id/:event_name', (req, res) => {
  const { notification_id } = req.params;

  connection.query(
      'CALL DeleteNotification(?)',
      [notification_id],
      (err, results) => {
          if (err) {
              console.error('Error deleting notification:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Notification deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteNotificationSendToUsers() using stored procedure

app.delete('/deleteNotificationsSendToUsers/:user_id/:notification_id', (req, res) => {
  const { user_id, notification_id } = req.params;

  connection.query(
      'CALL DeleteNotificationSendToUsers(?, ?)',
      [user_id, notification_id],
      (err, results) => {
          if (err) {
              console.error('Error deleting NotificationSendToUser:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'NotificationSendToUser deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteUserRegisterForEvent() using stored procedure

app.delete('/deleteUsersRegisterForEvents/:user_id/:event_name', (req, res) => {
  const { user_id, event_name } = req.params;

  connection.query(
      'CALL DeleteUserRegisterForEvents(?, ?)',
      [user_id, event_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting UserRegisterForEvent:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'User registration for event deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteEventFundedBySponsor() using stored procedure

app.delete('/deleteEventsFundedBySponsors/:event_name/:sponsor_name', (req, res) => {
  const { event_name, sponsor_name } = req.params;

  connection.query(
      'CALL DeleteEventFundedBySponsors(?, ?)',
      [event_name, sponsor_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting EventFundedBySponsor:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Event sponsorship deleted successfully' });
      }
  );
}
);

// Route for calling the DeleteEventOrganisedByOrganiser() using stored procedure

app.delete('/deleteEventsOrganisedByOrganisers/:event_name/:organiser_name', (req, res) => {
  const { event_name, organiser_name } = req.params;

  connection.query(
      'CALL DeleteEventOrganisedByOrganisers(?, ?)',
      [event_name, organiser_name],
      (err, results) => {
          if (err) {
              console.error('Error deleting EventOrganisedByOrganiser:', err);
              res.status(500).json({ error: err.message });
              return;
          }
          res.status(200).json({ message: 'Event organiser deleted successfully' });
      }
  );
}
);

// Server Initialization
const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
