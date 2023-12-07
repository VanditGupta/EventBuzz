-- StoredProcedures.sql create stored procedures for the EventBuzz Schema

USE EventBuzz;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GenerateEventSummary(eventName VARCHAR(255))
BEGIN

    IF eventName IS NULL OR eventName = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Event name is not valid';
    END IF;

    SELECT 
        (SELECT COUNT(*) FROM Orders WHERE event_name = eventName) AS TotalAttendees,
        (SELECT SUM(total_amount) FROM Orders WHERE event_name = eventName) AS TotalRevenue,
        (SELECT COUNT(*) FROM Tickets WHERE event_name = eventName) AS TotalTicketsSold,
        (SELECT SUM(ticket_quantity) FROM Tickets WHERE event_name = eventName) AS TotalTickets,
        (SELECT COUNT(*) FROM Reviews WHERE event_name = eventName) AS TotalReviews,
        (SELECT AVG(rating) FROM Reviews WHERE event_name = eventName) AS AverageRating,
        (SELECT COUNT(*) FROM Notifications WHERE event_name = eventName) AS TotalNotifications,
        (SELECT COUNT(*) FROM UsersRegisterForEvents WHERE event_name = eventName) AS TotalRegistrations,
        (SELECT COUNT(*) FROM EventsFundedBySponsors WHERE event_name = eventName) AS TotalSponsors,
        (SELECT SUM(sponsorship_amount) FROM EventsFundedBySponsors WHERE event_name = eventName) AS TotalSponsorshipAmount,
        (SELECT COUNT(*) FROM EventsOrganisedByOrganisers WHERE event_name = eventName) AS TotalOrganisers;

END $$

DELIMITER ;

-- Call GenerateEventSummary procedure;

-- CALL GenerateEventSummary('Spring Music Fest');


-- Create Stored Procedures for getting data from tables present in the `EventBuzz` database

-- Stored procedure to get values from `Users` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetUsers()
BEGIN
    SELECT * FROM Users;
END $$
DELIMITER ;

-- Stored procedure to get values from `EventCategories` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetEventCategories()
BEGIN
    SELECT * FROM EventCategories;
END $$
DELIMITER ;

-- Stored procedure to get values from `Venues` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetVenues()
BEGIN
    SELECT * FROM Venues;
END $$
DELIMITER ;

-- Stored procedure to get values from `Events` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetEvents()
BEGIN
    SELECT * FROM Events;
END $$
DELIMITER ;

-- Stored procedure to get values from `Orders` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetOrders()
BEGIN
    SELECT * FROM Orders;
END $$
DELIMITER ;

-- Stored procedure to get values from `Tickets` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetTickets()
BEGIN
    SELECT * FROM Tickets;
END $$
DELIMITER ;

-- Stored procedure to get values from `Reviews` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetReviews()
BEGIN
    SELECT * FROM Reviews;
END $$
DELIMITER ;

-- Stored procedure to get values from `Sponsors` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetSponsors()
BEGIN
    SELECT * FROM Sponsors;
END $$
DELIMITER ;

-- Stored procedure to get values from `Organisers` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetOrganisers()
BEGIN
    SELECT * FROM Organisers;
END $$
DELIMITER ;

-- Stored procedure to get values from `Notifications` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetNotifications()
BEGIN
    SELECT * FROM Notifications;
END $$
DELIMITER ;

-- Stored procedure to get values from `NotificationsSendToUsers` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetNotificationsSendToUsers()
BEGIN
    SELECT * FROM NotificationsSendToUsers;
END $$
DELIMITER ;

-- Stored procedure to get values from `UsersRegisterForEvents` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetUsersRegisterForEvents()
BEGIN
    SELECT * FROM UsersRegisterForEvents;
END $$
DELIMITER ;

-- Stored procedure to get values from `EventsFundedBySponsors` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetEventsFundedBySponsors()
BEGIN
    SELECT * FROM EventsFundedBySponsors;
END $$
DELIMITER ;

-- Stored procedure to get values from `EventsOrganisedByOrganisers` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS GetEventsOrganisedByOrganisers()
BEGIN
    SELECT * FROM EventsOrganisedByOrganisers;
END $$
DELIMITER ;


-- Create Stored Procedures for inserting data into tables present in the `EventBuzz` database

-- Stored procedure to insert values into `Users` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertUser(
    IN p_username VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_date_of_birth VARCHAR(255),
    IN p_sex ENUM('male', 'female', 'other'),
    IN p_contact_phone VARCHAR(20),
    IN p_street_no INT,
    IN p_street_name VARCHAR(255),
    IN p_unit_no INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_zip_code VARCHAR(10),
    IN p_country VARCHAR(255),
    IN p_profile_picture_url VARCHAR(255),
    IN p_role ENUM('admin', 'user', 'organizer'),
    IN p_status ENUM('active', 'inactive')
)
BEGIN
    INSERT INTO Users (
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
    ) VALUES (
        p_username,
        p_email,
        p_password,
        p_first_name,
        p_last_name,
        p_date_of_birth,
        p_sex,
        p_contact_phone,
        p_street_no,
        p_street_name,
        p_unit_no,
        p_city,
        p_state,
        p_zip_code,
        p_country,
        p_profile_picture_url,
        p_role,
        p_status
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `EventCategories` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertEventCategory(
    IN p_category_name VARCHAR(50),
    IN p_description VARCHAR(255)
)
BEGIN
    INSERT INTO EventCategories (
        category_name,
        description
    ) VALUES (
        p_category_name,
        p_description
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `Venues` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertVenue(
    IN p_venue_name VARCHAR(255),
    IN p_street_no INT,
    IN p_street_name VARCHAR(255),
    IN p_unit_no INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_zip_code INT,
    IN p_max_capacity INT,
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20)
)
BEGIN
    INSERT INTO Venues (
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
    ) VALUES (
        p_venue_name,
        p_street_no,
        p_street_name,
        p_unit_no,
        p_city,
        p_state,
        p_zip_code,
        p_max_capacity,
        p_contact_email,
        p_contact_phone
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `Events` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertEvent(
    IN p_event_name VARCHAR(255),
    IN p_event_description VARCHAR(255),
    IN p_event_date VARCHAR(255),
    IN p_event_time VARCHAR(255),
    IN p_event_status ENUM('scheduled', 'cancelled', 'completed'),
    IN p_event_image_url VARCHAR(255),
    IN p_category_name VARCHAR(50),
    IN p_venue_name VARCHAR(255)
)
BEGIN
    INSERT INTO Events (
        event_name,
        event_description,
        event_date,
        event_time,
        event_status,
        event_image_url,
        category_name,
        venue_name
    ) VALUES (
        p_event_name,
        p_event_description,
        p_event_date,
        p_event_time,
        p_event_status,
        p_event_image_url,
        p_category_name,
        p_venue_name
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `Orders` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertOrder(
    IN p_order_id INT,
    IN p_order_date VARCHAR(255),
    IN p_payment_type ENUM('credit_card', 'debit_card', 'paypal', 'other'),
    IN p_payment_status ENUM('paid', 'pending', 'failed'),
    IN total_amount DOUBLE,
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    INSERT INTO Orders (
        order_id,
        order_date,
        payment_type,
        payment_status,
        total_amount,
        user_id,
        event_name
    ) VALUES (
        p_order_id,
        p_order_date,
        p_payment_type,
        p_payment_status,
        total_amount,
        p_user_id,
        p_event_name
    );
END $$
DELIMITER ;


-- Stored procedure to insert values into `Tickets` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertTicket(
    IN p_ticket_id INT,
    IN p_ticket_price DOUBLE,
    IN p_ticket_quantity INT,
    IN p_order_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    INSERT INTO Tickets (
        ticket_id,
        ticket_price,
        ticket_quantity,
        order_id,
        event_name
    ) VALUES (
        p_ticket_id,
        p_ticket_price,
        p_ticket_quantity,
        p_order_id,
        p_event_name
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `Reviews` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertReview(
    IN p_rating TINYINT,
    IN p_comment VARCHAR(255),
    IN p_review_date VARCHAR(255),
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    INSERT INTO Reviews (
        rating,
        comment,
        review_date,
        user_id,
        event_name
    ) VALUES (
        p_rating,
        p_comment,
        p_review_date,
        p_user_id,
        p_event_name
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `Sponsors` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertSponsor(
    IN p_sponsor_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_website_url VARCHAR(255),
    IN p_logo_url VARCHAR(255),
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20),
    IN p_total_sponsorship_amount DOUBLE
)
BEGIN
    INSERT INTO Sponsors (
        sponsor_name,
        description,
        website_url,
        logo_url,
        contact_email,
        contact_phone,
        total_sponsorship_amount
    ) VALUES (
        p_sponsor_name,
        p_description,
        p_website_url,
        p_logo_url,
        p_contact_email,
        p_contact_phone,
        p_total_sponsorship_amount
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `Organisers` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertOrganiser(
    IN p_organiser_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_logo_url VARCHAR(255),
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20)
)
BEGIN
    INSERT INTO Organisers (
        organiser_name,
        description,
        logo_url,
        contact_email,
        contact_phone
    ) VALUES (
        p_organiser_name,
        p_description,
        p_logo_url,
        p_contact_email,
        p_contact_phone
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `Notifications` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertNotification(
    IN p_notification_id INT,
    IN p_notification_text VARCHAR(255),
    IN p_notification_date VARCHAR(255),
    IN p_event_name VARCHAR(255)
)
BEGIN
    INSERT INTO Notifications (
        notification_id,
        notification_text,
        notification_date,
        event_name
    ) VALUES (
        p_notification_id,
        p_notification_text,
        p_notification_date,
        p_event_name
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `NotificationsSendToUsers` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertNotificationSendToUsers(
    IN p_user_id INT,
    IN p_notification_id INT,
    IN p_priority ENUM('high', 'medium', 'low')
)
BEGIN
    INSERT INTO NotificationsSendToUsers (
        user_id,
        notification_id,
        priority
    ) VALUES (
        p_user_id,
        p_notification_id,
        p_priority
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `UsersRegisterForEvents` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertUserRegisterForEvents(
    IN p_user_id INT,
    IN p_event_name VARCHAR(255),
    IN p_registration_date VARCHAR(255)
)
BEGIN
    INSERT INTO UsersRegisterForEvents (
        user_id,
        event_name,
        registration_date
    ) VALUES (
        p_user_id,
        p_event_name,
        p_registration_date
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `EventsFundedBySponsors` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertEventFundedBySponsors(
    IN p_event_name VARCHAR(255),
    IN p_sponsor_name VARCHAR(255),
    IN p_sponsorship_amount DOUBLE,
    IN p_sponsorship_date VARCHAR(255)
)
BEGIN
    INSERT INTO EventsFundedBySponsors (
        event_name,
        sponsor_name,
        sponsorship_amount,
        sponsorship_date
    ) VALUES (
        p_event_name,
        p_sponsor_name,
        p_sponsorship_amount,
        p_sponsorship_date
    );
END $$
DELIMITER ;

-- Stored procedure to insert values into `EventsOrganisedByOrganisers` table
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS InsertEventOrganisedByOrganisers(
    IN p_event_name VARCHAR(255),
    IN p_organiser_name VARCHAR(255),
    IN p_organiser_role VARCHAR(100)
)
BEGIN
    INSERT INTO EventsOrganisedByOrganisers (
        event_name,
        organiser_name,
        organiser_role
    ) VALUES (
        p_event_name,
        p_organiser_name,
        p_organiser_role
    );
END $$
DELIMITER ;


-- Create Stored Procedures for updating data in tables present in the `EventBuzz` database

-- Stored procedure to update values in `Users` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateUser(
    IN p_user_id INT,
    IN p_username VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_date_of_birth VARCHAR(255),
    IN p_sex ENUM('male', 'female', 'other'),
    IN p_contact_phone VARCHAR(20),
    IN p_street_no INT,
    IN p_street_name VARCHAR(255),
    IN p_unit_no INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_zip_code VARCHAR(10),
    IN p_country VARCHAR(255),
    IN p_profile_picture_url VARCHAR(255),
    IN p_role ENUM('admin', 'user', 'organizer'),
    IN p_status ENUM('active', 'inactive')
)
BEGIN
    UPDATE Users SET
        username = p_username,
        email = p_email,
        first_name = p_first_name,
        last_name = p_last_name,
        date_of_birth = p_date_of_birth,
        sex = p_sex,
        contact_phone = p_contact_phone,
        street_no = p_street_no,
        street_name = p_street_name,
        unit_no = p_unit_no,
        city = p_city,
        state = p_state,
        zip_code = p_zip_code,
        country = p_country,
        profile_picture_url = p_profile_picture_url,
        role = p_role,
        status = p_status
    WHERE user_id = p_user_id;
END $$
DELIMITER ;

-- Stored procedure to update values in `EventCategories` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateEventCategory(
    IN p_category_name VARCHAR(50),
    IN p_description VARCHAR(255)
)
BEGIN
    UPDATE EventCategories SET
        description = p_description
    WHERE category_name = p_category_name;
END $$

DELIMITER ;

-- Stored procedure to update values in `Venues` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateVenue(
    IN p_venue_name VARCHAR(255),
    IN p_street_no INT,
    IN p_street_name VARCHAR(255),
    IN p_unit_no INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_zip_code INT,
    IN p_max_capacity INT,
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20)
)
BEGIN
    UPDATE Venues SET
        street_no = p_street_no,
        street_name = p_street_name,
        unit_no = p_unit_no,
        city = p_city,
        state = p_state,
        zip_code = p_zip_code,
        max_capacity = p_max_capacity,
        contact_email = p_contact_email,
        contact_phone = p_contact_phone
    WHERE venue_name = p_venue_name;
END $$
DELIMITER ;

-- Stored procedure to update values in `Events` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateEvent(
    IN p_event_name VARCHAR(255),
    IN p_event_description VARCHAR(255),
    IN p_event_date VARCHAR(255),
    IN p_event_time VARCHAR(255),
    IN p_event_status ENUM('scheduled', 'cancelled', 'completed'),
    IN p_event_image_url VARCHAR(255),
    IN p_category_name VARCHAR(50),
    IN p_venue_name VARCHAR(255)
)
BEGIN
    UPDATE Events SET
        event_description = p_event_description,
        event_date = p_event_date,
        event_time = p_event_time,
        event_status = p_event_status,
        event_image_url = p_event_image_url,
        category_name = p_category_name,
        venue_name = p_venue_name
    WHERE event_name = p_event_name;
END $$
DELIMITER ;

-- Stored procedure to update values in `Orders` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateOrder(
    IN p_order_id INT,
    IN p_order_date VARCHAR(255),
    IN p_payment_type ENUM('credit_card', 'debit_card', 'paypal', 'other'),
    IN p_payment_status ENUM('paid', 'pending', 'failed'),
    IN total_amount DOUBLE,
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    UPDATE Orders SET
        order_date = p_order_date,
        payment_type = p_payment_type,
        payment_status = p_payment_status,
        total_amount = total_amount,
        user_id = p_user_id,
        event_name = p_event_name
    WHERE order_id = p_order_id;
END $$
DELIMITER ;

-- Stored procedure to update values in `Tickets` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateTicket(
    IN p_ticket_id INT,
    IN p_ticket_price DOUBLE,
    IN p_ticket_quantity INT,
    IN start_sale_date VARCHAR(255),
    IN end_sale_date VARCHAR(255),
    IN p_order_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    UPDATE Tickets SET
        ticket_price = p_ticket_price,
        ticket_quantity = p_ticket_quantity,
        start_sale_date = start_sale_date,
        end_sale_date = end_sale_date,
        order_id = p_order_id,
        event_name = p_event_name
    WHERE ticket_id = p_ticket_id;
END $$
DELIMITER ;

-- Stored procedure to update values in `Reviews` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateReview(
    IN p_rating TINYINT,
    IN p_comment VARCHAR(255),
    IN p_review_date VARCHAR(255),
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    UPDATE Reviews SET
        rating = p_rating,
        comment = p_comment,
        review_date = p_review_date,
        user_id = p_user_id,
        event_name = p_event_name
    WHERE user_id = p_user_id AND event_name = p_event_name;
END $$
DELIMITER ;

-- Stored procedure to update values in `Sponsors` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateSponsor(
    IN p_sponsor_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_website_url VARCHAR(255),
    IN p_logo_url VARCHAR(255),
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20),
    IN p_total_sponsorship_amount DOUBLE
)
BEGIN
    UPDATE Sponsors SET
        description = p_description,
        website_url = p_website_url,
        logo_url = p_logo_url,
        contact_email = p_contact_email,
        contact_phone = p_contact_phone,
        total_sponsorship_amount = p_total_sponsorship_amount
    WHERE sponsor_name = p_sponsor_name;
END $$
DELIMITER ;

-- Stored procedure to update values in `Organisers` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateOrganiser(
    IN p_organiser_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_logo_url VARCHAR(255),
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20)
)
BEGIN
    UPDATE Organisers SET
        description = p_description,
        logo_url = p_logo_url,
        contact_email = p_contact_email,
        contact_phone = p_contact_phone
    WHERE organiser_name = p_organiser_name;
END $$
DELIMITER ;

-- Stored procedure to update values in `Notifications` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateNotification(
    IN p_notification_id INT,
    IN p_notification_text VARCHAR(255),
    IN p_notification_date VARCHAR(255),
    IN p_event_name VARCHAR(255)
)
BEGIN
    UPDATE Notifications SET
        notification_text = p_notification_text,
        notification_date = p_notification_date,
        event_name = p_event_name
    WHERE notification_id = p_notification_id;
END $$
DELIMITER ;

-- Stored procedure to update values in `NotificationsSendToUsers` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateNotificationSendToUsers(
    IN p_user_id INT,
    IN p_notification_id INT,
    IN p_priority ENUM('high', 'medium', 'low')
)
BEGIN
    UPDATE NotificationsSendToUsers SET
        priority = p_priority
    WHERE user_id = p_user_id AND notification_id = p_notification_id;
END $$
DELIMITER ;

-- Stored procedure to update values in `UsersRegisterForEvents` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateUserRegisterForEvents(
    IN p_user_id INT,
    IN p_event_name VARCHAR(255),
    IN p_registration_date VARCHAR(255)
)
BEGIN
    UPDATE UsersRegisterForEvents SET
        registration_date = p_registration_date
    WHERE user_id = p_user_id AND event_name = p_event_name;
END $$
DELIMITER ;

-- Stored procedure to update values in `EventsFundedBySponsors` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateEventFundedBySponsors(
    IN p_event_name VARCHAR(255),
    IN p_sponsor_name VARCHAR(255),
    IN p_sponsorship_amount DOUBLE,
    IN p_sponsorship_date VARCHAR(255)
)
BEGIN
    UPDATE EventsFundedBySponsors SET
        sponsorship_amount = p_sponsorship_amount,
        sponsorship_date = p_sponsorship_date
    WHERE event_name = p_event_name AND sponsor_name = p_sponsor_name;
END $$
DELIMITER ;

-- Stored procedure to update values in `EventsOrganisedByOrganisers` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS UpdateEventOrganisedByOrganisers(
    IN p_event_name VARCHAR(255),
    IN p_organiser_name VARCHAR(255),
    IN p_organiser_role VARCHAR(100)
)
BEGIN
    UPDATE EventsOrganisedByOrganisers SET
        organiser_role = p_organiser_role
    WHERE event_name = p_event_name AND organiser_name = p_organiser_name;
END $$
DELIMITER ;


-- Create Stored Procedures for deleting data from tables present in the `EventBuzz` database

-- Stored procedure to delete values from `Users` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteUser(
    IN p_user_id INT
)
BEGIN
    DELETE FROM Users WHERE user_id = p_user_id;
END $$
DELIMITER ;

-- Stored procedure to delete values from `EventCategories` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteEventCategory(
    IN p_category_name VARCHAR(50)
)
BEGIN
    DELETE FROM EventCategories WHERE category_name = p_category_name;
END $$

DELIMITER ;

-- Stored procedure to delete values from `Venues` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteVenue(
    IN p_venue_name VARCHAR(255)
)
BEGIN
    DELETE FROM Venues WHERE venue_name = p_venue_name;
END $$
DELIMITER ;

-- Stored procedure to delete values from `Events` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteEvent(
    IN p_event_name VARCHAR(255)
)
BEGIN
    DELETE FROM Events WHERE event_name = p_event_name;
END $$
DELIMITER ;

-- Stored procedure to delete values from `Orders` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteOrder(
    IN p_order_id INT
)
BEGIN
    DELETE FROM Orders WHERE order_id = p_order_id;
END $$
DELIMITER ;

-- Stored procedure to delete values from `Tickets` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteTicket(
    IN p_ticket_id INT
)
BEGIN
    DELETE FROM Tickets WHERE ticket_id = p_ticket_id;
END $$

DELIMITER ;

-- Stored procedure to delete values from `Reviews` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteReview(
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    DELETE FROM Reviews WHERE user_id = p_user_id AND event_name = p_event_name;
END $$
DELIMITER ;

-- Stored procedure to delete values from `Sponsors` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteSponsor(
    IN p_sponsor_name VARCHAR(255)
)
BEGIN
    DELETE FROM Sponsors WHERE sponsor_name = p_sponsor_name;
END $$
DELIMITER ;

-- Stored procedure to delete values from `Organisers` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteOrganiser(
    IN p_organiser_name VARCHAR(255)
)
BEGIN
    DELETE FROM Organisers WHERE organiser_name = p_organiser_name;
END $$
DELIMITER ;

-- Stored procedure to delete values from `Notifications` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteNotification(
    IN p_notification_id INT
)
BEGIN
    DELETE FROM Notifications WHERE notification_id = p_notification_id;
END $$
DELIMITER ;

-- Stored procedure to delete values from `NotificationsSendToUsers` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteNotificationSendToUsers(
    IN p_user_id INT,
    IN p_notification_id INT
)
BEGIN
    DELETE FROM NotificationsSendToUsers WHERE user_id = p_user_id AND notification_id = p_notification_id;
END $$
DELIMITER ;

-- Stored procedure to delete values from `UsersRegisterForEvents` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteUserRegisterForEvents(
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    DELETE FROM UsersRegisterForEvents WHERE user_id = p_user_id AND event_name = p_event_name;
END $$
DELIMITER ;

-- Stored procedure to delete values from `EventsFundedBySponsors` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteEventFundedBySponsors(
    IN p_event_name VARCHAR(255),
    IN p_sponsor_name VARCHAR(255)
)
BEGIN
    DELETE FROM EventsFundedBySponsors WHERE event_name = p_event_name AND sponsor_name = p_sponsor_name;
END $$
DELIMITER ;

-- Stored procedure to delete values from `EventsOrganisedByOrganisers` table

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS DeleteEventOrganisedByOrganisers(
    IN p_event_name VARCHAR(255),
    IN p_organiser_name VARCHAR(255)
)
BEGIN
    DELETE FROM EventsOrganisedByOrganisers WHERE event_name = p_event_name AND organiser_name = p_organiser_name;
END $$
DELIMITER ;


