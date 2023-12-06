USE EventBuzz;

-- Insert data into Users table
INSERT INTO Users (username, email, password, first_name, last_name, date_of_birth, sex, phone_number, street_no, street_name, unit_no, city, state, zip_code, country, profile_picture_url, role, status)
VALUES 
('johndoe', 'johndoe@example.com', 'hashed_password', 'John', 'Doe', '1990-01-01', 'male', '1234567890', '123', 'Main St', '1', 'Anytown', 'Anystate', '12345', 'Country', 'url_to_picture', 'user', 'active'),
('vandit', 'vandit@example.com', 'hashed_pwd', 'Vandit','Gupta', '1999-02-22', 'male', '1234567890', '123', 'Washington St', '3', 'town', 'state', '02210', 'USA', 'url', 'user', 'active');



INSERT INTO Users (username, email, password, first_name, last_name, date_of_birth, sex, phone_number, street_no, street_name, unit_no, city, state, zip_code, country, profile_picture_url, role, status)
VALUES 
('test', 'johndoe@sasadas.com', 'dssa', 'John', 'Doe', '1990-01-01', 'male', '1234567890', '123', 'Main St', '1', 'Anytown', 'Anystate', '12345', 'Country', 'url_to_picture', 'user', 'active');

-- delete from users where username = 'test';

DROP table Tickets;
DROP table orders;
DROP table reviews;
DROP table NotificationsSendToUsers;
DROP table UsersRegisterForEvents;
DROP table users;

select * from users;




-- Insert data into EventCategories table
INSERT INTO EventCategories (category_name, description)
VALUES ('Music', 'Music events'),
       ('Sports', 'Sports events'),
       ('Arts & Theatre', 'Arts & Theatre events'),
       ('Family', 'Family events'),
       ('Miscellaneous', 'Miscellaneous events');

-- Insert data into Venues table
INSERT INTO Venues (venue_name, street_no, street_name, unit_no, city, state, zip_code, max_capacity, contact_email, contact_phone)
VALUES ('The Grand Hall', '456', 'Broadway', '101', 'Metropolis', 'State', '67890', 500, 'contact@grandhall.com', '0987654321');

-- Insert data into Events table
INSERT INTO Events (event_name, event_description, event_date, event_time, event_status, event_image_url, category_name, venue_name)
VALUES ('Spring Music Fest', 'Annual Spring Music Festival', '2023-05-15', '18:00:00', 'scheduled', 'url_to_event_image', 'Music', 'The Grand Hall');

-- Insert data into Orders table
INSERT INTO Orders (order_date, payment_type, payment_status, user_id, event_name)
VALUES (NOW(), 'credit_card', 'paid', 1, 'Spring Music Fest');

-- Insert data into Tickets table
INSERT INTO Tickets (ticket_price, ticket_quantity, start_sale_date, end_sale_date, event_name, order_id)
VALUES (25.00, 2, '2023-04-01', '2023-05-01', 'Spring Music Fest', 1);

-- Insert data into Reviews table
INSERT INTO Reviews (rating, comment, review_date, user_id, event_name)
VALUES (5, 'Great event!', NOW(), 1, 'Spring Music Fest');

-- Insert data into Sponsors table
INSERT INTO Sponsors (sponsor_name, description, website_url, logo_url, contact_email, contact_phone, total_sponsorship_amount)
VALUES ('Sponsor Inc', 'Leading Event Sponsor', 'https://sponsorinc.com', 'url_to_logo', 'info@sponsorinc.com', '1231231234', 10000.00);

-- Insert data into Organisers table
INSERT INTO Organisers (organiser_name, description, logo_url, contact_email, contact_phone)
VALUES ('Organiser Pro', 'Top Event Organiser', 'url_to_organiser_logo', 'contact@organiserpro.com', '3213214321');

-- Insert data into Notifications table
INSERT INTO Notifications (notification_text, notification_date, event_name)
VALUES ('New event Spring Music Fest is available!', NOW(), 'Spring Music Fest');

-- Insert data into NotificationsSendToUsers table
INSERT INTO NotificationsSendToUsers (user_id, notification_id)
VALUES (1, 1);

-- Insert data into UsersRegisterForEvents table
INSERT INTO UsersRegisterForEvents (user_id, event_name, registration_date)
VALUES (1, 'Spring Music Fest', NOW());

-- Insert data into EventsFundedBySponsors table
INSERT INTO EventsFundedBySponsors (event_name, sponsor_name, sponsorship_amount, sponsorship_date)
VALUES ('Spring Music Fest', 'Sponsor Inc', 5000.00, NOW());

-- Insert data into EventsOrganisedByOrganisers table
INSERT INTO EventsOrganisedByOrganisers (event_name, organiser_name, organiser_role)
VALUES ('Spring Music Fest', 'Organiser Pro', 'Main Organiser');


SELECT * FROM Users;
SELECT * FROM EventCategories;
SELECT * FROM Venues;
SELECT * FROM Events;
SELECT * FROM Orders;
SELECT * FROM Tickets;
SELECT * FROM Reviews;
SELECT * FROM Sponsors;
SELECT * FROM Organisers;
SELECT * FROM Notifications;
SELECT * FROM NotificationsSendToUsers;
SELECT * FROM UsersRegisterForEvents;
SELECT * FROM EventsFundedBySponsors;
SELECT * FROM EventsOrganisedByOrganisers;
select * from EventBuzzAudit.ErrorLog;
select * from EventBuzzAudit.UserLog;


-- Truncate child tables first

DELETE FROM NotificationsSendToUsers;
DELETE FROM UsersRegisterForEvents;
DELETE FROM EventsFundedBySponsors;
DELETE FROM EventsOrganisedByOrganisers;

DELETE FROM Tickets;
DELETE FROM Reviews;

DELETE FROM Orders;

-- Then truncate parent tables
DELETE FROM Users;
DELETE FROM Events;
DELETE FROM EventCategories;
DELETE FROM Venues;
DELETE FROM Sponsors;
DELETE FROM Organisers;
DELETE FROM Notifications;


-- Drop all tables
DROP TABLE IF EXISTS NotificationsSendToUsers;
DROP TABLE IF EXISTS UsersRegisterForEvents;
DROP TABLE IF EXISTS EventsFundedBySponsors;
DROP TABLE IF EXISTS EventsOrganisedByOrganisers;

DROP TABLE IF EXISTS EventBuzzAudit.ErrorLog;
DROP TABLE IF EXISTS EventBuzzAudit.UserLog;
DROP TABLE IF EXISTS Tickets;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Notifications;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS EventCategories;
DROP TABLE IF EXISTS Venues;
DROP TABLE IF EXISTS Sponsors;
DROP TABLE IF EXISTS Organisers;

