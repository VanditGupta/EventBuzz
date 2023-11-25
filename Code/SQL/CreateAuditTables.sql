-- CreateAuditTables.sql creates the audit tables for the EventBuzzAudit Schema

CREATE DATABASE IF NOT EXISTS EventBuzzAudit;
USE EventBuzzAudit;

-- DROP DATABASE EventBuzzAudit;

-- Create the errorlog table
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

CREATE TABLE IF NOT EXISTS UserLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,                    -- ID of the user performing the action
    action_type VARCHAR(255),       -- Type of action (e.g., 'login', 'logout', 'registration')
    action_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- When the action occurred
    details TEXT,                   -- Additional details about the action
    FOREIGN KEY (user_id) REFERENCES EventBuzz.Users (user_id) -- Assuming EventBuzz is the main DB and Users is the table
);

