-- CreateSchema.sql creates the EventBuzz schema with base tables

CREATE DATABASE IF NOT EXISTS EventBuzz;
USE EventBuzz;

-- DROP DATABASE EventBuzz;


CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth VARCHAR(255),
    sex ENUM('male', 'female', 'other') NOT NULL DEFAULT 'female',
    contact_phone VARCHAR(20),
    street_no INT,
    street_name VARCHAR(255),
    unit_no INT,
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    country VARCHAR(255),
    profile_picture_url VARCHAR(255),
    role ENUM('admin', 'user', 'organizer') NOT NULL DEFAULT 'user',
    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active'
);


-- Event Categories Table
CREATE TABLE IF NOT EXISTS EventCategories (
    category_name VARCHAR(50) PRIMARY KEY NOT NULL,
    description VARCHAR(255)
);

-- Venues Table
CREATE TABLE IF NOT EXISTS Venues (
    venue_name VARCHAR(255) PRIMARY KEY NOT NULL,
    street_no INT,
    street_name VARCHAR(255),
    unit_no INT,
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code INT,
    max_capacity INT CHECK (max_capacity > 0),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20)
);

-- Events Table
CREATE TABLE IF NOT EXISTS Events (
    event_name VARCHAR(255) PRIMARY KEY NOT NULL,
    event_description VARCHAR(255),
    event_date VARCHAR(255),
    event_time VARCHAR(255),
    event_status ENUM('scheduled', 'cancelled', 'completed') NOT NULL DEFAULT 'scheduled',
    event_image_url VARCHAR(255),
    category_name VARCHAR(50),
    venue_name VARCHAR(255),
    FOREIGN KEY (category_name)
        REFERENCES EventCategories (category_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (venue_name)
        REFERENCES Venues (venue_name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    order_date VARCHAR(255),
    payment_type ENUM('credit_card', 'debit_card', 'paypal', 'other') NOT NULL DEFAULT 'credit_card',
    payment_status ENUM('paid', 'pending', 'failed') NOT NULL DEFAULT 'pending',
    total_amount DOUBLE DEFAULT 0 CHECK (total_amount >= 0),
    user_id INT,
    event_name VARCHAR(255),
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tickets Table
CREATE TABLE IF NOT EXISTS Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_price DOUBLE NOT NULL CHECK (ticket_price >= 0) DEFAULT 0,
    ticket_quantity INT NOT NULL CHECK (ticket_quantity >= 0) DEFAULT 0,
    start_sale_date VARCHAR(255),
    end_sale_date VARCHAR(255),
    event_name VARCHAR(255),
    order_id INT,
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (order_id)
        REFERENCES Orders (order_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Reviews Table (Weak Entity)
CREATE TABLE IF NOT EXISTS Reviews (
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5) DEFAULT 1,
    comment VARCHAR(255),
    review_date VARCHAR(255),
    user_id INT,
    event_name VARCHAR(255),
    CONSTRAINT reviews_pk PRIMARY KEY (user_id , event_name),
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Sponsors Table
CREATE TABLE IF NOT EXISTS Sponsors (
    sponsor_name VARCHAR(255) PRIMARY KEY NOT NULL,
    description VARCHAR(255),
    website_url VARCHAR(255),
    logo_url VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(255),
    total_sponsorship_amount DOUBLE DEFAULT 0 CHECK (total_sponsorship_amount >= 0)
);

-- Organisers Table
CREATE TABLE IF NOT EXISTS Organisers (
    organiser_name VARCHAR(255) PRIMARY KEY NOT NULL,
    description VARCHAR(255),
    logo_url VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20)
);

-- Notifications Table (Weak entity)
CREATE TABLE IF NOT EXISTS Notifications (
    notification_id INT AUTO_INCREMENT,
    notification_text VARCHAR(255),
    notification_date VARCHAR(255),
    event_name VARCHAR(255),
    CONSTRAINT notifications_pk PRIMARY KEY (notification_id , event_name),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Users-Notifications Table
CREATE TABLE IF NOT EXISTS NotificationsSendToUsers (
    user_id INT,
    notification_id INT,
    priority ENUM('high', 'medium', 'low') NOT NULL DEFAULT 'low',
    CONSTRAINT notifications_users_pk PRIMARY KEY (user_id , notification_id),
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (notification_id)
        REFERENCES Notifications (notification_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Users-Events Table
CREATE TABLE IF NOT EXISTS UsersRegisterForEvents (
    user_id INT,
    event_name VARCHAR(255),
    registration_date VARCHAR(255),
    CONSTRAINT users_events_pk PRIMARY KEY (user_id , event_name),
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Events-Sponsors Table
CREATE TABLE IF NOT EXISTS EventsFundedBySponsors (
    event_name VARCHAR(255),
    sponsor_name VARCHAR(255),
    sponsorship_amount DOUBLE NOT NULL CHECK (sponsorship_amount >= 0) DEFAULT 0,
    sponsorship_date VARCHAR(255),
    PRIMARY KEY (event_name , sponsor_name),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (sponsor_name)
        REFERENCES Sponsors (sponsor_name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Events-Organisers Table
CREATE TABLE IF NOT EXISTS EventsOrganisedByOrganisers (
    event_name VARCHAR(255),
    organiser_name VARCHAR(255),
    organiser_role VARCHAR(100),
    PRIMARY KEY (event_name , organiser_name),
    FOREIGN KEY (event_name)
        REFERENCES Events (event_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (organiser_name)
        REFERENCES Organisers (organiser_name)
        ON UPDATE CASCADE ON DELETE CASCADE
);