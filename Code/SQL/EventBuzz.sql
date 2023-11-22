CREATE DATABASE IF NOT EXISTS EventBuzz;
USE EventBuzz;

-- DROP DATABASE EventBuzz;

CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE,
    sex ENUM('male', 'female', 'other'),
    phone_number VARCHAR(20),
    street_no VARCHAR(255),
    street_name VARCHAR(255),
    unit_no VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    country VARCHAR(255),
    profile_picture_url TEXT,
    role ENUM('admin', 'user', 'organizer') NOT NULL,
    status ENUM('active', 'inactive') NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Event Categories Table
CREATE TABLE IF NOT EXISTS EventCategories (
    category_name VARCHAR(50) PRIMARY KEY NOT NULL,
    description TEXT
);

-- Venues Table
CREATE TABLE IF NOT EXISTS Venues (
    venue_name VARCHAR(255) PRIMARY KEY NOT NULL,
    street_no VARCHAR(10),
    street_name VARCHAR(100),
    unit_no VARCHAR(10),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    max_capacity INT,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(15)
);

-- Events Table
CREATE TABLE IF NOT EXISTS Events (
    event_name VARCHAR(255) PRIMARY KEY NOT NULL,
    event_description TEXT,
    event_date DATETIME,
    event_time TIME,
    event_status ENUM('scheduled', 'cancelled', 'completed'),
    event_image_url VARCHAR(255),
    category_name VARCHAR(50),
    venue_name VARCHAR(255),
    FOREIGN KEY (category_name)
        REFERENCES EventCategories (category_name),
    FOREIGN KEY (venue_name)
        REFERENCES Venues (venue_name)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT,
    total_amount DECIMAL(10 , 2 ),
    order_date DATETIME,
    payment_type ENUM('credit_card', 'debit_card', 'paypal', 'other'),
    payment_status ENUM('paid', 'pending', 'failed'),
    event_name VARCHAR(255),
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
);

-- Tickets Table
CREATE TABLE IF NOT EXISTS Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    ticket_price DECIMAL(10 , 2 ),
    ticket_quantity INT,
    start_sale_date DATETIME,
    end_sale_date DATETIME,
    event_name VARCHAR(255),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name),
    FOREIGN KEY (order_id)
        REFERENCES Orders (order_id)
);

-- Reviews Table
CREATE TABLE IF NOT EXISTS Reviews (
    user_id INT,
    event_name VARCHAR(255),
    rating TINYINT NOT NULL,
    comment TEXT,
    review_date DATETIME,
    CONSTRAINT reviews_pk PRIMARY KEY (user_id , event_name),
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
);

-- Sponsors Table
CREATE TABLE IF NOT EXISTS Sponsors (
    sponsor_name VARCHAR(255) PRIMARY KEY,
    description TEXT,
    website_url VARCHAR(255),
    logo_url VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(15),
    total_sponsorship_amount DECIMAL(10 , 2 )
);

-- Organisers Table
CREATE TABLE IF NOT EXISTS Organisers (
    organiser_name VARCHAR(255) PRIMARY KEY,
    description TEXT,
    logo_url VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(15)
);

-- Notifications Table
CREATE TABLE IF NOT EXISTS Notifications (
    notification_id INT,
    event_name VARCHAR(255),
    notification_text TEXT,
    notification_date DATETIME,
    CONSTRAINT notifications_pk PRIMARY KEY (notification_id , event_name),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
);

-- Users-Notifications Table
CREATE TABLE IF NOT EXISTS Notifications_SendTo_Users (
    user_id INT,
    notification_id INT,
    CONSTRAINT notifications_users_pk PRIMARY KEY (user_id , notification_id),
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id),
    FOREIGN KEY (notification_id)
        REFERENCES Notifications (notification_id)
);

-- Users-Events Table
CREATE TABLE IF NOT EXISTS Users_RegisterFor_Events (
    user_id INT,
    event_name VARCHAR(255),
    registration_date DATETIME,
    CONSTRAINT events_users_pk PRIMARY KEY (user_id , event_name),
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
);	

-- Events-Sponsors Table
CREATE TABLE IF NOT EXISTS Events_FundedBy_Sponsors (
    event_name VARCHAR(255),
    sponsor_name VARCHAR(255),
    sponsorship_amount DECIMAL(10 , 2 ),
    sponsorship_date DATETIME,
    PRIMARY KEY (event_name , sponsor_name),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name),
    FOREIGN KEY (sponsor_name)
        REFERENCES Sponsors (sponsor_name)
);

-- Events-Organisers Table
CREATE TABLE IF NOT EXISTS Events_OrganisedBy_Organisers (
    event_name VARCHAR(255),
    organiser_name VARCHAR(255),
    organiser_role VARCHAR(100),
    PRIMARY KEY (event_name , organiser_name),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name),
    FOREIGN KEY (organiser_name)
        REFERENCES Organisers (organiser_name)
);

