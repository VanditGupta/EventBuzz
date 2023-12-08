-- CreateAuditTables.sql creates the audit tables in the EventBuzz Schema

-- DROP DATABASE IF EXISTS EventBuzz;
USE EventBuzz;

-- Create the errorlog table
-- DROP TABLE IF EXISTS EventBuzz.ErrorLog;
CREATE TABLE IF NOT EXISTS ErrorLog (
    error_id INT AUTO_INCREMENT PRIMARY KEY,
    error_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    error_source VARCHAR(255),        -- Indicates where the error occurred
    error_message TEXT,               -- Detailed error message
    error_context TEXT,               -- Additional context about the error
    user_id INT,                      -- Optional: User ID associated with the error
    event_name VARCHAR(255),          -- Optional: Event related to the error
    additional_info TEXT              -- Any additional information
);

-- DROP TABLE IF EXISTS EventBuzz.UserLog;
CREATE TABLE IF NOT EXISTS UserLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    general_id VARCHAR(255),              -- General ID for storing primary key from various tables
    action_type VARCHAR(255),             -- Type of action (e.g., 'login', 'logout', 'registration')
    action_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- When the action occurred
    details TEXT                          -- Additional details about the action
);

