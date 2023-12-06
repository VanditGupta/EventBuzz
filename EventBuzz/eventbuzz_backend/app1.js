const express = require("express");
const cors = require("cors");
const { Connection, Request, TYPES } = require("tedious");
const app = express();

app.use(cors());
app.use(express.json());

const DB_HOST = "nitishdmdd6201.database.windows.net";
const DB_NAME = "BANK";
const DB_USER = "nitishahuja";
const DB_PASSWORD = "Bbmmsgbb1!";

const config = {
  server: DB_HOST,
  authentication: {
    type: "default",
    options: {
      userName: DB_USER,
      password: DB_PASSWORD,
    },
  },
  options: {
    database: DB_NAME,
    encrypt: true,
    trustServerCertificate: false,
  },
};

// Function to get data from any table dynamically
const getTableDetails = (req, res, tableName) => {
  const connection = new Connection(config);

  connection.on("connect", (err) => {
    if (err) {
      console.error("Error connecting to the database:", err.message);
      res.status(500).json({
        error: `Failed to connect to the database for ${tableName}.`,
      });
      return;
    } else {
      console.log("Connected to the database.");
    }

    const request = new Request(
      `SELECT * FROM ${tableName}`,
      (err, rowCount) => {
        console.log(`Rows returned for ${tableName}: `, rowCount);
        if (err) {
          console.error(
            `Error executing SQL query for ${tableName}:`,
            err.message
          );
          res.status(500).json({
            error: `Failed to execute SQL query for ${tableName}. ${err.message}`,
          });
          return;
        }

        if (rowCount === 0) {
          res.status(404).json({
            error: `No records found in ${tableName}.`,
          });
          return;
        }

        // The SQL query has executed successfully, and we've processed all rows.
        connection.close();
      }
    );

    const rows = [];

    request.on("row", (columns) => {
      const record = {};
      columns.forEach((column) => {
        record[column.metadata.colName] = column.value;
      });
      rows.push(record);
    });

    request.on("requestCompleted", () => {
      // Send the response after all rows have been processed.
      res.json(rows);
    });

    connection.execSql(request);
  });

  connection.on("end", () => {
    console.log("Connection closed.");
  });

  connection.connect();
};

// Function to insert data into any table dynamically
const executeInsertQuery = (req, res, tableName, data) => {
  const connection = new Connection(config);

  connection.on("connect", (err) => {
    if (err) {
      console.error("Error connecting to the database:", err.message);
      res.status(500).json({
        error: `Failed to connect to the database for ${tableName}.`,
      });
      return;
    } else {
      console.log("Connected to the database.");
    }

    const columns = Object.keys(data).join(", ");
    const values = Object.values(data)
      .map((value) => (typeof value === "string" ? `'${value}'` : value))
      .join(", ");

    const request = new Request(
      `INSERT INTO ${tableName} (${columns}) VALUES (${values})`,
      (err, rowCount) => {
        if (err) {
          console.error(
            `Error executing SQL query for ${tableName}:`,
            err.message
          );
          res.status(500).json({
            error: `Failed to execute SQL query for ${tableName}. ${err.message}`,
          });
          return;
        }

        console.log(`Rows inserted for ${tableName}: `, rowCount);
        res.status(200).json({
          message: `Rows inserted for ${tableName}: ${rowCount}`,
        });
        connection.close();
      }
    );

    connection.execSql(request);
  });

  connection.on("end", () => {
    console.log("Connection closed.");
  });

  connection.connect();
};

// Function to update data in any table dynamically
const executeUpdateQuery = (req, res, tableName, primaryKey, updateData) => {
  const connection = new Connection(config);

  connection.on("connect", (err) => {
    if (err) {
      console.error("Error connecting to the database:", err.message);
      res.status(500).json({
        error: `Failed to connect to the database for updating ${tableName}.`,
      });
      return;
    }

    // Construct the SET part of the SQL query
    const setClause = Object.keys(updateData)
      .map((key) => `${key} = @${key}`)
      .join(", ");

    // Construct the WHERE part of the SQL query
    const whereClause = Array.isArray(primaryKey)
      ? primaryKey.map((key) => `${key} = @${key}`).join(" AND ")
      : `${primaryKey} = @PrimaryKey`;

    const request = new Request(
      `UPDATE ${tableName} SET ${setClause} WHERE ${whereClause}`,
      (err, rowCount) => {
        if (err) {
          console.error(
            `Error executing SQL query for updating ${tableName}:`,
            err.message
          );
          res.status(500).json({
            error: `Failed to execute SQL query for updating ${tableName}. ${err.message}`,
          });
          return;
        }

        if (rowCount === 0) {
          res.status(404).json({
            error: `No records found in ${tableName} with specified primary key(s).`,
          });
          return;
        }

        res.status(200).json({
          message: `${tableName} updated successfully.`,
        });
        connection.close();
      }
    );

    // Add parameters for the update data
    Object.keys(updateData).forEach((key) => {
      request.addParameter(key, TYPES.VarChar, updateData[key]);
    });

    // Add parameters for the primary key(s)
    if (Array.isArray(primaryKey)) {
      primaryKey.forEach((key) => {
        request.addParameter(key, TYPES.VarChar, req.params[key]);
      });
    } else {
      request.addParameter("PrimaryKey", TYPES.VarChar, req.params[primaryKey]);
    }

    connection.execSql(request);
  });

  connection.on("end", () => {
    console.log("Connection closed.");
  });

  connection.connect();
};

const executeDeleteQuery = (req, res, tableName, primaryKey) => {
  const connection = new Connection(config);

  connection.on("connect", (err) => {
    if (err) {
      console.error("Error connecting to the database:", err.message);
      res.status(500).json({
        error: `Failed to connect to the database for deleting from ${tableName}.`,
      });
      return;
    } else {
      console.log("Connected to the database.");
    }

    // Construct the WHERE part of the SQL query
    const whereClause = Array.isArray(primaryKey)
      ? primaryKey.map((key) => `${key} = @${key}`).join(" AND ")
      : `${primaryKey} = @PrimaryKey`;

    const request = new Request(
      `DELETE FROM ${tableName} WHERE ${whereClause}`,
      (err, rowCount) => {
        if (err) {
          console.error(
            `Error executing SQL query for deleting from ${tableName}:`,
            err.message
          );
          res.status(500).json({
            error: `Failed to execute SQL query for deleting from ${tableName}. ${err.message}`,
          });
          return;
        }

        if (rowCount === 0) {
          res.status(404).json({
            error: `No records found in ${tableName} with specified primary key(s).`,
          });
          return;
        }

        res.status(200).json({
          message: `${rowCount} row(s) deleted from ${tableName}.`,
        });
        connection.close();
      }
    );

    // Add parameters for the primary key(s)
    if (Array.isArray(primaryKey)) {
      primaryKey.forEach((key) => {
        request.addParameter(key, TYPES.VarChar, req.params[key]);
      });
    } else {
      request.addParameter("PrimaryKey", TYPES.VarChar, req.params[primaryKey]);
    }

    connection.execSql(request);
  });

  connection.on("end", () => {
    console.log("Connection closed.");
  });

  connection.connect();
};

// Routes to insert data into different tables
// Insert route for Account table
app.post("/insertIntoAccount", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Account", data);
});

// Insert route for Access_Log table
app.post("/insertIntoAccessLog", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Access_Log", data);
});

// Insert route for Locker table
app.post("/insertIntoLocker", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Locker", data);
});

// Insert route for [Transaction] table
app.post("/insertIntoTransaction", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "[Transaction]", data);
});

// Insert route for Branch table
app.post("/insertIntoBranch", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Branch", data);
});

// Insert route for Employee table
app.post("/insertIntoEmployee", (req, res) => {
  const data = req.body;
  data.Password = Buffer.from(data.Password, "utf-8");
  executeInsertQuery(req, res, "Employee", data);
});

// Insert route for Customers table
app.post("/insertIntoCustomers", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Customers", data);
});

// Insert route for Policy table
app.post("/insertIntoPolicy", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Policy", data);
});

// Insert route for Complaint table
app.post("/insertIntoComplaint", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Complaint", data);
});

// Insert route for Claims table
app.post("/insertIntoClaims", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Claims", data);
});

// Insert route for Loan_Application table
app.post("/insertIntoLoan", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Loan", data);
});

// Insert route for Loan_Application table
app.post("/insertIntoLoanApplication", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Loan_Application", data);
});

// Insert route for Customer_Policy table
app.post("/insertIntoCustomerPolicy", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Customer_Policy", data);
});

// Insert route for Customers_Employee table
app.post("/insertIntoCustomersEmployee", (req, res) => {
  const data = req.body;
  executeInsertQuery(req, res, "Customers_Employee", data);
});

// Routes to get data from different tables
app.get("/getAccountDetails", (req, res) =>
  getTableDetails(req, res, "Account")
);

app.get("/getAccessLogDetails", (req, res) =>
  getTableDetails(req, res, "Access_Log")
);

app.get("/getLockerDetails", (req, res) => getTableDetails(req, res, "Locker"));

app.get("/getTransactionDetails", (req, res) =>
  getTableDetails(req, res, "[Transaction]")
);

app.get("/getBranchDetails", (req, res) => getTableDetails(req, res, "Branch"));

app.get("/getEmployeeDetails", (req, res) =>
  getTableDetails(req, res, "Employee")
);

app.get("/getCustomersDetails", (req, res) =>
  getTableDetails(req, res, "Customers")
);

app.get("/getPolicyDetails", (req, res) => getTableDetails(req, res, "Policy"));

app.get("/getComplaintDetails", (req, res) =>
  getTableDetails(req, res, "Complaint")
);

app.get("/getClaimsDetails", (req, res) => getTableDetails(req, res, "claims"));

app.get("/getLoanDetails", (req, res) => getTableDetails(req, res, "Loan"));

app.get("/getLoanApplicationDetails", (req, res) =>
  getTableDetails(req, res, "Loan_Application")
);

app.get("/getCustomerPolicyDetails", (req, res) =>
  getTableDetails(req, res, "Customer_Policy")
);

app.get("/getCustomersEmployeeDetails", (req, res) =>
  getTableDetails(req, res, "Customers_Employee")
);
// Routes to update data in different tables
// Update route for Branch table
app.put("/updateBranch/:Branch_Code", (req, res) => {
  const primaryKey = "Branch_Code";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Branch", primaryKey, updateData);
});

// Update route for Customers table
app.put("/updateCustomers/:Customer_ID", (req, res) => {
  const primaryKey = "Customer_ID";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Customers", primaryKey, updateData);
});

// Update route for Policy table
app.put("/updatePolicy/:Policy_ID", (req, res) => {
  const primaryKey = "Policy_ID";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Policy", primaryKey, updateData);
});

// Update route for Claims table
app.put("/updateClaims/:Issue_ID", (req, res) => {
  const primaryKey = "Issue_ID";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Claims", primaryKey, updateData);
});

// Update route for Locker table
app.put("/updateLocker/:LockerID", (req, res) => {
  const primaryKey = "LockerID";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Locker", primaryKey, updateData);
});

// Update route for Employee table
app.put("/updateEmployee/:Employee_ID", (req, res) => {
  const primaryKey = "Employee_ID";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Employee", primaryKey, updateData);
});

// Update route for Account table
app.put("/updateAccount/:AccountNumber", (req, res) => {
  const primaryKey = "AccountNumber";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Account", primaryKey, updateData);
});

// Update route for [Transaction] table
app.put("/updateTransaction/:TransactionID", (req, res) => {
  const primaryKey = "TransactionID";
  const updateData = req.body;
  executeUpdateQuery(req, res, "[Transaction]", primaryKey, updateData);
});

// Update route for Loan_Application table
app.put("/updateLoan/:Loan_ID", (req, res) => {
  const primaryKey = "Loan_ID";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Loan", primaryKey, updateData);
});

// Update route for Loan_Application table
app.put("/updateLoanApplication/:Customer_ID/:Loan_ID", (req, res) => {
  const primaryKey = ["Customer_ID", "Loan_ID"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "Loan_Application", primaryKey, updateData);
});

// Update route for Customer_Policy table
app.put("/updateCustomerPolicy/:Customer_ID/:Policy_ID", (req, res) => {
  const primaryKey = ["Customer_ID", "Policy_ID"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "Customer_Policy", primaryKey, updateData);
});

// Update route for Complaint table
app.put("/updateComplaint/:Complaint_ID", (req, res) => {
  const primaryKey = "Complaint_ID";
  const updateData = req.body;
  executeUpdateQuery(req, res, "Complaint", primaryKey, updateData);
});

// Update route for Access_Log table
app.put("/updateAccessLog/:Customer_ID/:LockerID", (req, res) => {
  const primaryKey = ["Customer_ID", "LockerID"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "Access_Log", primaryKey, updateData);
});

// Update route for Customers_Employee table
app.put("/updateCustomersEmployee/:Customer_ID/:Employee_ID", (req, res) => {
  const primaryKey = ["Customer_ID", "Employee_ID"];
  const updateData = req.body;
  executeUpdateQuery(req, res, "Customers_Employee", primaryKey, updateData);
});

// Routes to delete data from different tables
// Delete route for Account table
app.delete("/deleteAccount/:AccountNumber", (req, res) => {
  const primaryKey = "AccountNumber";
  executeDeleteQuery(req, res, "Account", primaryKey);
});

// Delete route for Access_Log table
app.delete("/deleteAccessLog/:Customer_ID/:LockerID", (req, res) => {
  const primaryKey = ["Customer_ID", "LockerID"];
  executeDeleteQuery(req, res, "Access_Log", primaryKey);
});

// Delete route for Locker table
app.delete("/deleteLocker/:LockerID", (req, res) => {
  const primaryKey = "LockerID";
  executeDeleteQuery(req, res, "Locker", primaryKey);
});

// Delete route for [Transaction] table
app.delete("/deleteTransaction/:TransactionID", (req, res) => {
  const primaryKey = "TransactionID";
  executeDeleteQuery(req, res, "[Transaction]", primaryKey);
});

// Delete route for Branch table
app.delete("/deleteBranch/:Branch_Code", (req, res) => {
  const primaryKey = "Branch_Code";
  executeDeleteQuery(req, res, "Branch", primaryKey);
});

// Delete route for Employee table
app.delete("/deleteEmployee/:Employee_ID", (req, res) => {
  const primaryKey = "Employee_ID";
  executeDeleteQuery(req, res, "Employee", primaryKey);
});

// Delete route for Customers table
app.delete("/deleteCustomers/:Customer_ID", (req, res) => {
  const primaryKey = "Customer_ID";
  executeDeleteQuery(req, res, "Customers", primaryKey);
});

// Delete route for Policy table
app.delete("/deletePolicy/:Policy_ID", (req, res) => {
  const primaryKey = "Policy_ID";
  executeDeleteQuery(req, res, "Policy", primaryKey);
});

// Delete route for Complaint table
app.delete("/deleteComplaint/:Complaint_ID", (req, res) => {
  const primaryKey = "Complaint_ID";
  executeDeleteQuery(req, res, "Complaint", primaryKey);
});

// Delete route for Claims table
app.delete("/deleteClaims/:Issue_ID", (req, res) => {
  const primaryKey = "Issue_ID";
  executeDeleteQuery(req, res, "Claims", primaryKey);
});

// Delete route for Loan table
app.delete("/deleteLoan/:Loan_ID", (req, res) => {
  const primaryKey = "Loan_ID";
  executeDeleteQuery(req, res, "Loan", primaryKey);
});

// Delete route for Loan_Application table
app.delete("/deleteLoanApplication/:Customer_ID/:Loan_ID", (req, res) => {
  const primaryKey = ["Customer_ID", "Loan_ID"];
  executeDeleteQuery(req, res, "Loan_Application", primaryKey);
});

// Delete route for Customer_Policy table
app.delete("/deleteCustomerPolicy/:Customer_ID/:Policy_ID", (req, res) => {
  const primaryKey = ["Customer_ID", "Policy_ID"];
  executeDeleteQuery(req, res, "Customer_Policy", primaryKey);
});

// Delete route for Access_Log table
app.delete("/deleteAccessLog/:Customer_ID/:LockerID", (req, res) => {
  const primaryKey = ["Customer_ID", "LockerID"];
  executeDeleteQuery(req, res, "Access_Log", primaryKey);
});

// Delete route for Customers_Employee table
app.delete("/deleteCustomersEmployee/:Customer_ID/:Employee_ID", (req, res) => {
  const primaryKey = ["Customer_ID", "Employee_ID"];
  executeDeleteQuery(req, res, "Customers_Employee", primaryKey);
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
