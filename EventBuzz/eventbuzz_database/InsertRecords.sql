USE EventBuzz;

-- INSERT INTO Users (username, email, password, first_name, last_name, date_of_birth, sex, phone_number, street_no, street_name, unit_no, city, state, zip_code, country, profile_picture_url, role, status)
-- VALUES 
-- ('test', 'johndoe@sasadas.com', 'dssa', 'John', 'Doe', '1990-01-01', 'male', '1234567890', '123', 'Main St', '1', 'Anytown', 'Anystate', '12345', 'Country', 'url_to_picture', 'user', 'active');

-- delete from users where username = 'test';

-- DROP table Tickets;
-- DROP table orders;
-- DROP table reviews;
-- DROP table NotificationsSendToUsers;
-- DROP table UsersRegisterForEvents;
-- DROP table users;

-- select * from users;


-- Insert data into Users table
INSERT INTO Users (username, email, password, first_name, last_name, date_of_birth, sex, phone_number, street_no, street_name, unit_no, city, state, zip_code, country, profile_picture_url, role, status)
VALUES 
('johndoe', 'johndoe@example.com', 'hashed_password', 'John', 'Doe', '1990-01-01', 'male', '1234567890', '123', 'Main St', '1', 'Anytown', 'Anystate', '12345', 'Country', 'url_to_picture', 'user', 'active'),
('vandit', 'vandit@example.com', 'hashed_pwd', 'Vandit','Gupta', '1999-02-22', 'male', '1234567890', '123', 'Washington St', '3', 'town', 'state', '02210', 'USA', 'url', 'user', 'active'),
('emilyross', 'emilyross@example.com', 'hashed_password123', 'Emily', 'Ross', '1985-07-12', 'female', '2345678901', '321', 'Pine St', '10', 'Springfield', 'StateX', '54321', 'CountryX', 'url_to_emilypic', 'user', 'active'),
('alexsmith', 'alexsmith@example.com', 'hashed_password456', 'Alex', 'Smith', '1992-05-30', 'male', '3456789012', '456', 'Oak St', '15', 'Rivertown', 'StateY', '65432', 'CountryY', 'url_to_alexpic', 'admin', 'active'),
('sarahlee', 'sarahlee@example.com', 'hashed_password789', 'Sarah', 'Lee', '1988-11-23', 'female', '4567890123', '789', 'Elm St', '20', 'Laketown', 'StateZ', '76543', 'CountryZ', 'url_to_sarahpic', 'user', 'inactive'),
('michaelbrown', 'michaelbrown@example.com', 'hashed_pwd_mike', 'Michael', 'Brown', '1993-04-15', 'male', '5678901234', '147', 'Maple St', '25', 'Hilltown', 'StateA', '87654', 'CountryA', 'url_to_mikepic', 'user', 'active'),
('lucywhite', 'lucywhite@example.com', 'hashed_pwd_lucy', 'Lucy', 'White', '1991-09-19', 'female', '6789012345', '258', 'Birch St', '30', 'Forest City', 'StateB', '98765', 'CountryB', 'url_to_lucypic', 'user', 'active'),
('davidthomas', 'davidthomas@example.com', 'hashed_pwd_dave', 'David', 'Thomas', '1984-03-27', 'male', '7890123456', '369', 'Cedar St', '35', 'Mountain View', 'StateC', '11223', 'CountryC', 'url_to_davepic', 'user', 'inactive'),
('jenniferwilson', 'jenniferwilson@example.com', 'hashed_pwd_jenn', 'Jennifer', 'Wilson', '1987-06-04', 'female', '8901234567', '741', 'Aspen St', '40', 'Sunnyvale', 'StateD', '22334', 'CountryD', 'url_to_jennpic', 'admin', 'active'),
('kevinmartin', 'kevinmartin@example.com', 'hashed_pwd_kevin', 'Kevin', 'Martin', '1995-12-20', 'male', '9012345678', '852', 'Willow St', '45', 'Beachside', 'StateE', '33445', 'CountryE', 'url_to_kevinpic', 'user', 'active');

-- Insert data into EventCategories table
INSERT INTO EventCategories (category_name, description)
VALUES 
       ('Music', 'Music events'),
       ('Sports', 'Sports events'),
       ('Arts & Theatre', 'Arts & Theatre events'),
       ('Family', 'Family events'),
       ('Miscellaneous', 'Miscellaneous events'),
       ('Technology', 'Events related to technology, such as tech expos, seminars, and workshops'),
       ('Education', 'Educational events including workshops, seminars, and conferences'),
       ('Health & Wellness', 'Events focused on health, wellness, and fitness, including workshops and health fairs'),
       ('Food & Drink', 'Culinary events such as food festivals, wine tastings, and cooking classes'),
       ('Business & Networking', 'Business-related events including networking meetups, seminars, and conferences');

-- Insert data into Venues table
INSERT INTO Venues (venue_name, street_no, street_name, unit_no, city, state, zip_code, max_capacity, contact_email, contact_phone)
VALUES 
('The Grand Hall', '456', 'Broadway', '101', 'Metropolis', 'State', '67890', 500, 'contact@grandhall.com', '0987654321'),
('Riverside Theater', '789', 'River Rd', '202', 'Lakeside', 'StateB', '12345', 350, 'info@riversidetheater.com', '1234567890'),
('Sunshine Auditorium', '321', 'Sunset Blvd', '303', 'Sunnyville', 'StateC', '23456', 750, 'contact@sunshineauditorium.com', '2345678901'),
('Mountain View Arena', '654', 'Highland Ave', '404', 'Hilltown', 'StateD', '34567', 1000, 'info@mountainviewarena.com', '3456789012'),
('Starlight Ballroom', '987', 'Star St', '505', 'Nightcity', 'StateE', '45678', 600, 'contact@starlightballroom.com', '4567890123'),
('Oceanfront Pavilion', '123', 'Beach Blvd', '606', 'Seaside', 'StateF', '56789', 450, 'info@oceanfrontpavilion.com', '5678901234'),
('City Center Convention Hall', '456', 'Central Ave', '707', 'Downtown', 'StateG', '67890', 1200, 'contact@citycenterconvention.com', '6789012345'),
('Forest Lodge', '789', 'Woodland Rd', '808', 'Forestville', 'StateH', '78901', 300, 'info@forestlodge.com', '7890123456'),
('Harbor View Gallery', '321', 'Harbor Way', '909', 'Portside', 'StateI', '89012', 400, 'contact@harborviewgallery.com', '8901234567'),
('Crystal Palace', '654', 'Crystal Rd', '1010', 'Gemtown', 'StateJ', '90123', 550, 'info@crystalpalace.com', '9012345678');

-- Insert data into Events table
INSERT INTO Events (event_name, event_description, event_date, event_time, event_status, event_image_url, category_name, venue_name)
VALUES 
('Spring Music Fest', 'Annual Spring Music Festival', '2023-05-15', '18:00:00', 'scheduled', 'url_to_event_image', 'Music', 'The Grand Hall'),
('Summer Art Exhibition', 'Exhibition of contemporary art', '2023-07-20', '10:00:00', 'scheduled', 'url_to_art_image', 'Arts & Theatre', 'City Center Convention Hall'),
('Tech Expo 2023', 'Technology and Innovation Expo', '2023-09-05', '09:00:00', 'scheduled', 'url_to_techexpo_image', 'Technology', 'Mountain View Arena'),
('Marathon City Run', 'Annual marathon through the city', '2023-10-10', '07:00:00', 'scheduled', 'url_to_marathon_image', 'Sports', 'Sunshine Auditorium'),
('Health and Wellness Fair', 'Event focusing on health and wellness', '2023-08-15', '09:30:00', 'scheduled', 'url_to_healthfair_image', 'Health & Wellness', 'Oceanfront Pavilion'),
('Culinary Delights Festival', 'Festival showcasing local and international cuisine', '2023-06-18', '11:00:00', 'scheduled', 'url_to_culinaryfest_image', 'Food & Drink', 'Harbor View Gallery'),
('Business Networking Event', 'Meet and connect with business professionals', '2023-11-25', '17:00:00', 'scheduled', 'url_to_networking_image', 'Business & Networking', 'Riverside Theater'),
('Educational Workshop Series', 'Series of educational and skill-building workshops', '2023-12-05', '10:00:00', 'scheduled', 'url_to_workshop_image', 'Education', 'Forest Lodge'),
('Winter Family Carnival', 'Fun and games for the entire family', '2023-12-15', '15:00:00', 'scheduled', 'url_to_carnival_image', 'Family', 'Starlight Ballroom'),
('Indie Film Nights', 'Screening of independent films', '2023-08-30', '19:00:00', 'scheduled', 'url_to_indiefilm_image', 'Arts & Theatre', 'Crystal Palace');

-- Insert data into Orders table
INSERT INTO Orders (order_date, payment_type, payment_status, user_id, event_name)
VALUES 
('2023-02-11', 'credit_card', 'paid', 1, 'Spring Music Fest'),
('2023-03-15', 'debit_card', 'paid', 2, 'Summer Art Exhibition'),
('2023-04-20', 'paypal', 'pending', 3, 'Tech Expo 2023'),
('2023-05-25', 'credit_card', 'paid', 4, 'Marathon City Run'),
('2023-06-30', 'other', 'failed', 5, 'Health and Wellness Fair'),
('2023-07-05', 'debit_card', 'paid', 6, 'Culinary Delights Festival'),
('2023-08-10', 'credit_card', 'pending', 7, 'Business Networking Event'),
('2023-09-15', 'paypal', 'paid', 8, 'Educational Workshop Series'),
('2023-10-21', 'credit_card', 'paid', 9, 'Winter Family Carnival'),
('2023-11-30', 'debit_card', 'paid', 10, 'Indie Film Nights');

-- Insert data into Tickets table
INSERT INTO Tickets (ticket_price, ticket_quantity, start_sale_date, end_sale_date, event_name, order_id)
VALUES 
(25.00, 2, '2023-04-01', '2023-05-01', 'Spring Music Fest', 1),
(30.00, 4, '2023-06-01', '2023-07-01', 'Summer Art Exhibition', 2),
(50.00, 1, '2023-07-15', '2023-09-01', 'Tech Expo 2023', 3),
(20.00, 3, '2023-09-10', '2023-10-05', 'Marathon City Run', 4),
(15.00, 2, '2023-07-20', '2023-08-10', 'Health and Wellness Fair', 5),
(40.00, 5, '2023-05-25', '2023-06-18', 'Culinary Delights Festival', 6),
(35.00, 2, '2023-10-20', '2023-11-20', 'Business Networking Event', 7),
(45.00, 1, '2023-11-01', '2023-12-01', 'Educational Workshop Series', 8),
(25.00, 4, '2023-11-15', '2023-12-10', 'Winter Family Carnival', 9),
(60.00, 2, '2023-07-30', '2023-08-25', 'Indie Film Nights', 10);

-- Insert data into Reviews table
INSERT INTO Reviews (rating, comment, review_date, user_id, event_name)
VALUES 
(5, 'Great event!', '2023-02-11', 1, 'Spring Music Fest'),
(4, 'Really enjoyed the exhibition.', '2023-07-21', 2, 'Summer Art Exhibition'),
(3, 'Interesting expo, but could be better.', '2023-09-06', 3, 'Tech Expo 2023'),
(5, 'Loved the marathon! Well organized.', '2023-10-11', 4, 'Marathon City Run'),
(2, 'Fair was okay, not many activities.', '2023-08-16', 5, 'Health and Wellness Fair'),
(5, 'Amazing food, great atmosphere!', '2023-06-19', 6, 'Culinary Delights Festival'),
(4, 'Great networking opportunities.', '2023-11-26', 7, 'Business Networking Event'),
(5, 'The workshops were very informative.', '2023-12-06', 8, 'Educational Workshop Series'),
(3, 'Fun family event but quite crowded.', '2023-12-16', 9, 'Winter Family Carnival'),
(4, 'Loved the indie films, great selection.', '2023-08-31', 10, 'Indie Film Nights');

-- Insert data into Sponsors table
INSERT INTO Sponsors (sponsor_name, description, website_url, logo_url, contact_email, contact_phone, total_sponsorship_amount)
VALUES 
('Sponsor Inc', 'Leading Event Sponsor', 'https://sponsorinc.com', 'url_to_logo', 'info@sponsorinc.com', '1231231234', 10000.00),
('Tech Giants', 'Technology and Innovation Leaders', 'https://techgiants.com', 'url_to_techgiants_logo', 'contact@techgiants.com', '2342342345', 15000.00),
('HealthFirst', 'Healthcare and Wellness Sponsor', 'https://healthfirst.com', 'url_to_healthfirst_logo', 'info@healthfirst.com', '3453453456', 8000.00),
('EduMinds', 'Education and Learning Sponsor', 'https://eduminds.com', 'url_to_eduminds_logo', 'support@eduminds.com', '4564564567', 12000.00),
('Green Earth', 'Eco-friendly Initiatives and Sustainability', 'https://greenearth.com', 'url_to_greenearth_logo', 'green@earth.com', '5675675678', 9000.00),
('Foodie Heaven', 'Culinary Arts and Food Festivals', 'https://foodieheaven.com', 'url_to_foodieheaven_logo', 'yum@foodieheaven.com', '6786786789', 7000.00),
('BizNetwork', 'Business Networking and Corporate Events', 'https://biznetwork.com', 'url_to_biznetwork_logo', 'connect@biznetwork.com', '7897897890', 11000.00),
('Sportify', 'Sports Events and Athletic Sponsor', 'https://sportify.com', 'url_to_sportify_logo', 'sports@sportify.com', '8908908901', 9500.00),
('Artistic Minds', 'Supporting Arts and Theatre', 'https://artisticminds.com', 'url_to_artisticminds_logo', 'creativity@artisticminds.com', '9019019012', 8500.00),
('Family Fun Time', 'Family and Community Events', 'https://familyfuntime.com', 'url_to_familyfuntime_logo', 'family@funtime.com', '0120120123', 6000.00);

-- Insert data into Organisers table
INSERT INTO Organisers (organiser_name, description, logo_url, contact_email, contact_phone)
VALUES 
('Organiser Pro', 'Top Event Organiser', 'url_to_organiser_logo', 'contact@organiserpro.com', '3213214321'),
('Event Masters', 'Expert in Corporate Event Planning', 'url_to_eventmasters_logo', 'info@eventmasters.com', '4324325432'),
('Showtime Events', 'Specialists in Entertainment and Shows', 'url_to_showtime_logo', 'contact@showtimeevents.com', '5435436543'),
('EduEvents', 'Focused on Educational and Workshop Events', 'url_to_eduevents_logo', 'support@eduevents.com', '6546547654'),
('Health Horizons', 'Health and Wellness Event Organisers', 'url_to_healthhorizons_logo', 'wellness@healthhorizons.com', '7657658765'),
('Tech Conventions', 'Organising Tech and Innovation Conferences', 'url_to_techconventions_logo', 'tech@techconventions.com', '8768769876'),
('Gourmet Gatherings', 'Food and Culinary Event Experts', 'url_to_gourmetgatherings_logo', 'hello@gourmetgatherings.com', '9879870987'),
('SportsMania Org', 'Organising Sports Events and Tournaments', 'url_to_sportsmania_logo', 'sports@sportsmaniaorg.com', '0980981098'),
('Artistic Ventures', 'Art and Theatre Event Specialists', 'url_to_artisticventures_logo', 'arts@artisticventures.com', '1091092109'),
('Family Fest Organisers', 'Creating Memorable Family Events', 'url_to_familyfest_logo', 'family@familyfestorganisers.com', '2102103210');

-- Insert data into Notifications table
INSERT INTO Notifications (notification_text, notification_date, event_name)
VALUES 
('New event Spring Music Fest is available!', '2023-09-15','Spring Music Fest'),
('Summer Art Exhibition tickets now on sale!', '2023-06-01', 'Summer Art Exhibition'),
('Tech Expo 2023 coming this fall', '2023-08-20', 'Tech Expo 2023'),
('Join us for the Marathon City Run!', '2023-09-05', 'Marathon City Run'),
('Health and Wellness Fair this weekend', '2023-07-10', 'Health and Wellness Fair'),
('Don’t miss the Culinary Delights Festival', '2023-05-15', 'Culinary Delights Festival'),
('Network at the Business Networking Event', '2023-10-30', 'Business Networking Event'),
('Register for Educational Workshop Series', '2023-11-10', 'Educational Workshop Series'),
('Winter Family Carnival - Fun for all ages', '2023-11-25', 'Winter Family Carnival'),
('Experience unique films at Indie Film Nights', '2023-08-01', 'Indie Film Nights');

-- Insert data into NotificationsSendToUsers table
INSERT INTO NotificationsSendToUsers (user_id, notification_id, priority)
VALUES 
(1, 1, 'medium'),
(2, 2, 'high'),
(3, 3, 'low'),
(4, 4, 'medium'),
(5, 5, 'high'),
(6, 6, 'low'),
(7, 7, 'medium'),
(8, 8, 'high'),
(9, 9, 'low'),
(10, 10, 'medium');

-- Insert data into UsersRegisterForEvents table
INSERT INTO UsersRegisterForEvents (user_id, event_name, registration_date)
VALUES 
(1, 'Spring Music Fest', '2022-09-18'),
(2, 'Summer Art Exhibition', '2023-06-01'),
(3, 'Tech Expo 2023', '2023-08-15'),
(4, 'Marathon City Run', '2023-09-01'),
(5, 'Health and Wellness Fair', '2023-07-05'),
(6, 'Culinary Delights Festival', '2023-05-10'),
(7, 'Business Networking Event', '2023-10-20'),
(8, 'Educational Workshop Series', '2023-11-05'),
(9, 'Winter Family Carnival', '2023-11-20'),
(10, 'Indie Film Nights', '2023-08-01');

-- Insert data into EventsFundedBySponsors table
INSERT INTO EventsFundedBySponsors (event_name, sponsor_name, sponsorship_amount, sponsorship_date)
VALUES 
('Spring Music Fest', 'Sponsor Inc', 5000.00, '2023-11-09'),
('Summer Art Exhibition', 'Tech Giants', 4000.00, '2023-05-20'),
('Tech Expo 2023', 'Tech Giants', 6000.00, '2023-07-15'),
('Marathon City Run', 'HealthFirst', 3000.00, '2023-08-05'),
('Health and Wellness Fair', 'HealthFirst', 2500.00, '2023-06-10'),
('Culinary Delights Festival', 'Foodie Heaven', 3500.00, '2023-04-22'),
('Business Networking Event', 'BizNetwork', 4500.00, '2023-09-30'),
('Educational Workshop Series', 'EduMinds', 5000.00, '2023-10-11'),
('Winter Family Carnival', 'Family Fun Time', 2000.00, '2023-11-01'),
('Indie Film Nights', 'Artistic Minds', 3000.00, '2023-07-20');

-- Insert data into EventsOrganisedByOrganisers table
INSERT INTO EventsOrganisedByOrganisers (event_name, organiser_name, organiser_role)
VALUES 
('Spring Music Fest', 'Organiser Pro', 'Main Organiser'),
('Summer Art Exhibition', 'Event Masters', 'Coordinator'),
('Tech Expo 2023', 'Tech Conventions', 'Main Organiser'),
('Marathon City Run', 'SportsMania Org', 'Event Planner'),
('Health and Wellness Fair', 'Health Horizons', 'Coordinator'),
('Culinary Delights Festival', 'Gourmet Gatherings', 'Main Organiser'),
('Business Networking Event', 'Artistic Ventures', 'Event Planner'),
('Educational Workshop Series', 'EduEvents', 'Coordinator'),
('Winter Family Carnival', 'Family Fest Organisers', 'Main Organiser'),
('Indie Film Nights', 'Showtime Events', 'Event Planner');

-- Select statments for all the tables
-- SELECT * FROM Users;
-- SELECT * FROM EventCategories;
-- SELECT * FROM Venues;
-- SELECT * FROM Events;
-- SELECT * FROM Orders;
-- SELECT * FROM Tickets;
-- SELECT * FROM Reviews;
-- SELECT * FROM Sponsors;
-- SELECT * FROM Organisers;
-- SELECT * FROM Notifications;
-- SELECT * FROM NotificationsSendToUsers;
-- SELECT * FROM UsersRegisterForEvents;
-- SELECT * FROM EventsFundedBySponsors;
-- SELECT * FROM EventsOrganisedByOrganisers;
-- select * from EventBuzzAudit.ErrorLog;
-- select * from EventBuzzAudit.UserLog;


-- Truncate child tables first

-- DELETE FROM NotificationsSendToUsers;
-- DELETE FROM UsersRegisterForEvents;
-- DELETE FROM EventsFundedBySponsors;
-- DELETE FROM EventsOrganisedByOrganisers;

-- DELETE FROM Tickets;
-- DELETE FROM Reviews;

-- DELETE FROM Orders;

-- Then truncate parent tables
-- DELETE FROM Users;
-- DELETE FROM Events;
-- DELETE FROM EventCategories;
-- DELETE FROM Venues;
-- DELETE FROM Sponsors;
-- DELETE FROM Organisers;
-- DELETE FROM Notifications;


-- Drop all tables

-- DROP TABLE IF EXISTS NotificationsSendToUsers;
-- DROP TABLE IF EXISTS UsersRegisterForEvents;
-- DROP TABLE IF EXISTS EventsFundedBySponsors;
-- DROP TABLE IF EXISTS EventsOrganisedByOrganisers;

-- DROP TABLE IF EXISTS EventBuzzAudit.ErrorLog;
-- DROP TABLE IF EXISTS EventBuzzAudit.UserLog;
-- DROP TABLE IF EXISTS Tickets;
-- DROP TABLE IF EXISTS Reviews;
-- DROP TABLE IF EXISTS Orders;
-- DROP TABLE IF EXISTS Notifications;
-- DROP TABLE IF EXISTS Users;
-- DROP TABLE IF EXISTS Events;
-- DROP TABLE IF EXISTS EventCategories;
-- DROP TABLE IF EXISTS Venues;
-- DROP TABLE IF EXISTS Sponsors;
-- DROP TABLE IF EXISTS Organisers;

