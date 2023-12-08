-- Triggers.sql creates triggers on the EventBuzz Schema

USE EventBuzz;

-- Triggers to insert, update and delete the total_sponsorship_amount in Sponsors table
DROP TRIGGER IF EXISTS after_sponsorship_insert;
DELIMITER $$
CREATE TRIGGER after_sponsorship_insert
AFTER INSERT ON EventsFundedBySponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_insert', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;

    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount + NEW.sponsorship_amount
    WHERE sponsor_name = NEW.sponsor_name;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS after_sponsorship_update;
DELIMITER $$
CREATE TRIGGER after_sponsorship_update
AFTER UPDATE ON EventsFundedBySponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_update', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount - OLD.sponsorship_amount + NEW.sponsorship_amount
    WHERE sponsor_name = NEW.sponsor_name;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS after_sponsorship_delete;
DELIMITER $$
CREATE TRIGGER after_sponsorship_delete
AFTER DELETE ON EventsFundedBySponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_delete', 'Error occurred',CONCAT('sponsor_name: ', OLD.sponsor_name, ', sponsorship_amount: ', OLD.sponsorship_amount), OLD.event_name);
    END;
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount - OLD.sponsorship_amount
    WHERE sponsor_name = OLD.sponsor_name;
END$$
DELIMITER ;

-- Triggers to INSERT, UPDATE and DELETE the total_ticket_sales in Events table
DROP TRIGGER IF EXISTS after_ticket_insert_total_sum;
DELIMITER $$
CREATE TRIGGER after_ticket_insert_total_sum
AFTER INSERT ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_insert_total_sum', 'Error occurred',CONCAT('ticket_id' + NEW.ticket_id + 'ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity), NEW.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = NEW.order_id)
    WHERE order_id = NEW.order_id;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS after_ticket_update_total_sum;
DELIMITER $$
CREATE TRIGGER after_ticket_update_total_sum
AFTER UPDATE ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_update_total_sum', 'Error occurred',CONCAT('ticket_id' + NEW.ticket_id + 'ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity), NEW.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = NEW.order_id)
    WHERE order_id = NEW.order_id;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS after_ticket_delete_total_sum;
DELIMITER $$
CREATE TRIGGER after_ticket_delete_total_sum
AFTER DELETE ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_delete_total_sum', 'Error occurred',CONCAT('ticket_id' + OLD.ticket_id + 'ticket_price: ', OLD.ticket_price, ', ticket_quantity: ', OLD.ticket_quantity), OLD.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = OLD.order_id)
    WHERE order_id = OLD.order_id;
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is 
-- error during insert on Users table, then insert into `EventBuzz`.ErrorLog table.
DROP TRIGGER IF EXISTS after_user_insert;
DELIMITER $$
CREATE TRIGGER after_user_insert
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_user_insert', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.user_id, 'registration', CONCAT('user_id: ', NEW.user_id, ', user_name: ', NEW.username));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is 
-- error during update on Users table, then insert into `EventBuzz`.ErrorLog table.
DROP TRIGGER IF EXISTS after_user_update;
DELIMITER $$
CREATE TRIGGER after_user_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_user_update', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.user_id, 'update', CONCAT('user_id: ', NEW.user_id, ', user_name: ', NEW.username));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is 
-- error during delete on Users table, then insert into `EventBuzz`.ErrorLog table.
DROP TRIGGER IF EXISTS after_user_delete;
DELIMITER $$
CREATE TRIGGER after_user_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_user_delete', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.user_id, 'delete', CONCAT('user_id: ', OLD.user_id, ', user_name: ', OLD.username));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on EventCategories table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_event_category_insert;
DELIMITER $$
CREATE TRIGGER after_event_category_insert
AFTER INSERT ON EventCategories
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_event_category_insert', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.category_name, 'insert', CONCAT('category_name: ', NEW.category_name, ', description: ', NEW.description));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on EventCategories table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_event_category_update;
DELIMITER $$
CREATE TRIGGER after_event_category_update
AFTER UPDATE ON EventCategories
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_event_category_update', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.category_name, 'update', CONCAT('category_name: ', NEW.category_name, ', description: ', NEW.description));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on EventCategories table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_event_category_delete;
DELIMITER $$
CREATE TRIGGER after_event_category_delete
AFTER DELETE ON EventCategories
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_event_category_delete', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.category_name, 'delete', CONCAT('category_name: ', OLD.category_name, ', description: ', OLD.description));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on Venues table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_venue_insert;
DELIMITER $$
CREATE TRIGGER after_venue_insert
AFTER INSERT ON Venues
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_venue_insert', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.venue_name, 'insert', CONCAT('venue_name: ', NEW.venue_name, ', street_no: ', NEW.street_no, ', street_name: ', NEW.street_name, ', unit_no: ', NEW.unit_no, ', city: ', NEW.city, ', state: ', NEW.state, ', zip_code: ', NEW.zip_code, ', max_capacity: ', NEW.max_capacity, ', contact_email: ', NEW.contact_email, ', contact_phone: ', NEW.contact_phone));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on Venues table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_venue_update;
DELIMITER $$
CREATE TRIGGER after_venue_update
AFTER UPDATE ON Venues
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_venue_update', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.venue_name, 'update', CONCAT('venue_name: ', NEW.venue_name, ', street_no: ', NEW.street_no, ', street_name: ', NEW.street_name, ', unit_no: ', NEW.unit_no, ', city: ', NEW.city, ', state: ', NEW.state, ', zip_code: ', NEW.zip_code, ', max_capacity: ', NEW.max_capacity, ', contact_email: ', NEW.contact_email, ', contact_phone: ', NEW.contact_phone));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on Venues table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_venue_delete;
DELIMITER $$
CREATE TRIGGER after_venue_delete
AFTER DELETE ON Venues
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_venue_delete', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.venue_name, 'delete', CONCAT('venue_name: ', OLD.venue_name, ', street_no: ', OLD.street_no, ', street_name: ', OLD.street_name, ', unit_no: ', OLD.unit_no, ', city: ', OLD.city, ', state: ', OLD.state, ', zip_code: ', OLD.zip_code, ', max_capacity: ', OLD.max_capacity, ', contact_email: ', OLD.contact_email, ', contact_phone: ', OLD.contact_phone));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on Events table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_event_insert;
DELIMITER $$
CREATE TRIGGER after_event_insert
AFTER INSERT ON Events
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_event_insert', 'Error occurred', CONCAT('event_name: ', NEW.event_name, ', event_description: ', NEW.event_description, ', event_date: ', NEW.event_date, ', event_time: ', NEW.event_time, ', event_status: ', NEW.event_status, ', event_image_url: ', NEW.event_image_url, ', category_name: ', NEW.category_name, ', venue_name: ', NEW.venue_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.event_name, 'insert', CONCAT('event_name: ', NEW.event_name, ', event_description: ', NEW.event_description, ', event_date: ', NEW.event_date, ', event_time: ', NEW.event_time, ', event_status: ', NEW.event_status, ', event_image_url: ', NEW.event_image_url, ', category_name: ', NEW.category_name, ', venue_name: ', NEW.venue_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on Events table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_event_update;
DELIMITER $$
CREATE TRIGGER after_event_update
AFTER UPDATE ON Events
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_event_update', 'Error occurred', CONCAT('event_name: ', NEW.event_name, ', event_description: ', NEW.event_description, ', event_date: ', NEW.event_date, ', event_time: ', NEW.event_time, ', event_status: ', NEW.event_status, ', event_image_url: ', NEW.event_image_url, ', category_name: ', NEW.category_name, ', venue_name: ', NEW.venue_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.event_name, 'update', CONCAT('event_name: ', NEW.event_name, ', event_description: ', NEW.event_description, ', event_date: ', NEW.event_date, ', event_time: ', NEW.event_time, ', event_status: ', NEW.event_status, ', event_image_url: ', NEW.event_image_url, ', category_name: ', NEW.category_name, ', venue_name: ', NEW.venue_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on Events table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_event_delete;
DELIMITER $$
CREATE TRIGGER after_event_delete
AFTER DELETE ON Events
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_event_delete', 'Error occurred', CONCAT('event_name: ', OLD.event_name, ', event_description: ', OLD.event_description, ', event_date: ', OLD.event_date, ', event_time: ', OLD.event_time, ', event_status: ', OLD.event_status, ', event_image_url: ', OLD.event_image_url, ', category_name: ', OLD.category_name, ', venue_name: ', OLD.venue_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.event_name, 'delete', CONCAT('event_name: ', OLD.event_name, ', event_description: ', OLD.event_description, ', event_date: ', OLD.event_date, ', event_time: ', OLD.event_time, ', event_status: ', OLD.event_status, ', event_image_url: ', OLD.event_image_url, ', category_name: ', OLD.category_name, ', venue_name: ', OLD.venue_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on Orders table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_order_insert;
DELIMITER $$
CREATE TRIGGER after_order_insert
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_order_insert', 'Error occurred', CONCAT('order_date: ', NEW.order_date, ', payment_type: ', NEW.payment_type, ', payment_status: ', NEW.payment_status, ', total_amount: ', NEW.total_amount, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.order_id, 'insert', CONCAT('order_date: ', NEW.order_date, ', payment_type: ', NEW.payment_type, ', payment_status: ', NEW.payment_status, ', total_amount: ', NEW.total_amount, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on Orders table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_order_update;
DELIMITER $$
CREATE TRIGGER after_order_update
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_order_update', 'Error occurred', CONCAT('order_date: ', NEW.order_date, ', payment_type: ', NEW.payment_type, ', payment_status: ', NEW.payment_status, ', total_amount: ', NEW.total_amount, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.order_id, 'update', CONCAT('order_date: ', NEW.order_date, ', payment_type: ', NEW.payment_type, ', payment_status: ', NEW.payment_status, ', total_amount: ', NEW.total_amount, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on Orders table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_order_delete;
DELIMITER $$
CREATE TRIGGER after_order_delete
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_order_delete', 'Error occurred', CONCAT('order_date: ', OLD.order_date, ', payment_type: ', OLD.payment_type, ', payment_status: ', OLD.payment_status, ', total_amount: ', OLD.total_amount, ', user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.order_id, 'delete', CONCAT('order_date: ', OLD.order_date, ', payment_type: ', OLD.payment_type, ', payment_status: ', OLD.payment_status, ', total_amount: ', OLD.total_amount, ', user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on Tickets table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_ticket_insert;
DELIMITER $$
CREATE TRIGGER after_ticket_insert
AFTER INSERT ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_ticket_insert', 'Error occurred', CONCAT('ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity, ', start_sale_date: ', NEW.start_sale_date, ', end_sale_date: ', NEW.end_sale_date, ', event_name: ', NEW.event_name, ', order_id: ', NEW.order_id));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.ticket_id, 'insert', CONCAT('ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity, ', start_sale_date: ', NEW.start_sale_date, ', end_sale_date: ', NEW.end_sale_date, ', event_name: ', NEW.event_name, ', order_id: ', NEW.order_id));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on Tickets table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_ticket_update;
DELIMITER $$
CREATE TRIGGER after_ticket_update
AFTER UPDATE ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_ticket_update', 'Error occurred', CONCAT('ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity, ', start_sale_date: ', NEW.start_sale_date, ', end_sale_date: ', NEW.end_sale_date, ', event_name: ', NEW.event_name, ', order_id: ', NEW.order_id));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.ticket_id, 'update', CONCAT('ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity, ', start_sale_date: ', NEW.start_sale_date, ', end_sale_date: ', NEW.end_sale_date, ', event_name: ', NEW.event_name, ', order_id: ', NEW.order_id));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on Tickets table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_ticket_delete;
DELIMITER $$
CREATE TRIGGER after_ticket_delete
AFTER DELETE ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_ticket_delete', 'Error occurred', CONCAT('ticket_price: ', OLD.ticket_price, ', ticket_quantity: ', OLD.ticket_quantity, ', start_sale_date: ', OLD.start_sale_date, ', end_sale_date: ', OLD.end_sale_date, ', event_name: ', OLD.event_name, ', order_id: ', OLD.order_id));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.ticket_id, 'delete', CONCAT('ticket_price: ', OLD.ticket_price, ', ticket_quantity: ', OLD.ticket_quantity, ', start_sale_date: ', OLD.start_sale_date, ', end_sale_date: ', OLD.end_sale_date, ', event_name: ', OLD.event_name, ', order_id: ', OLD.order_id));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on Reviews table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_review_insert;
DELIMITER $$
CREATE TRIGGER after_review_insert
AFTER INSERT ON Reviews
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_review_insert', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.event_name), 'insert', CONCAT('rating: ', NEW.rating, ', comment: ', NEW.comment, ', review_date: ', NEW.review_date, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on Reviews table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_review_update;
DELIMITER $$
CREATE TRIGGER after_review_update
AFTER UPDATE ON Reviews
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_review_update', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.event_name), 'update', CONCAT('rating: ', NEW.rating, ', comment: ', NEW.comment, ', review_date: ', NEW.review_date, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on Reviews table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_review_delete;
DELIMITER $$
CREATE TRIGGER after_review_delete
AFTER DELETE ON Reviews
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_review_delete', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.user_id, '&&', OLD.event_name), 'delete', CONCAT('rating: ', OLD.rating, ', comment: ', OLD.comment, ', review_date: ', OLD.review_date, ', user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on Sponsors table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_sponsor_insert;
DELIMITER $$
CREATE TRIGGER after_sponsor_insert
AFTER INSERT ON Sponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_sponsor_insert', 'Error occurred', CONCAT('sponsor_name: ', NEW.sponsor_name, ', description: ', NEW.description));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.sponsor_name, 'insert', CONCAT('sponsor_name: ', NEW.sponsor_name, ', description: ', NEW.description));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on Sponsors table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_sponsor_update;
DELIMITER $$
CREATE TRIGGER after_sponsor_update
AFTER UPDATE ON Sponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_sponsor_update', 'Error occurred', CONCAT('sponsor_name: ', NEW.sponsor_name, ', description: ', NEW.description));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.sponsor_name, 'update', CONCAT('sponsor_name: ', NEW.sponsor_name, ', description: ', NEW.description));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on Sponsors table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_sponsor_delete;
DELIMITER $$
CREATE TRIGGER after_sponsor_delete
AFTER DELETE ON Sponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_sponsor_delete', 'Error occurred', CONCAT('sponsor_name: ', OLD.sponsor_name, ', description: ', OLD.description));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.sponsor_name, 'delete', CONCAT('sponsor_name: ', OLD.sponsor_name, ', description: ', OLD.description));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on Organisers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_organiser_insert;
DELIMITER $$
CREATE TRIGGER after_organiser_insert
AFTER INSERT ON Organisers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source)
        VALUES ('after_organiser_insert', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.organiser_name, 'insert', CONCAT('organiser_name: ', NEW.organiser_name, ', organiser_email: ', NEW.contact_email, ', organiser_phone: ', NEW.contact_phone, ', organiser_description: ', NEW.description));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on Organisers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_organiser_update;
DELIMITER $$
CREATE TRIGGER after_organiser_update
AFTER UPDATE ON Organisers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source)
        VALUES ('after_organiser_update', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.organiser_name, 'update', CONCAT('organiser_name: ', NEW.organiser_name, ', organiser_email: ', NEW.contact_email, ', organiser_phone: ', NEW.contact_phone, ', organiser_description: ', NEW.description));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on Organisers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_organiser_delete;
DELIMITER $$
CREATE TRIGGER after_organiser_delete
AFTER DELETE ON Organisers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source)
        VALUES ('after_organiser_delete', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.organiser_name, 'delete', CONCAT('organiser_name: ', OLD.organiser_name, ', organiser_email: ', OLD.contact_email, ', organiser_phone: ', OLD.contact_phone, ', organiser_description: ', OLD.description));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on Notifications table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_notification_insert;
DELIMITER $$
CREATE TRIGGER after_notification_insert
AFTER INSERT ON Notifications
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_insert', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.notification_id, '&&', NEW.event_name), 'insert', CONCAT('notification_text: ', NEW.notification_text, ', notification_date: ', NEW.notification_date, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on Notifications table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_notification_update;
DELIMITER $$
CREATE TRIGGER after_notification_update
AFTER UPDATE ON Notifications
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_update', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.notification_id, '&&', NEW.event_name), 'update', CONCAT('notification_text: ', NEW.notification_text, ', notification_date: ', NEW.notification_date, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on Notifications table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_notification_delete;
DELIMITER $$
CREATE TRIGGER after_notification_delete
AFTER DELETE ON Notifications
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_delete', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.notification_id, '&&', OLD.event_name), 'delete', CONCAT('notification_text: ', OLD.notification_text, ', notification_date: ', OLD.notification_date, ', event_name: ', OLD.event_name));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on NotificationsSendToUsers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_notification_user_insert;
DELIMITER $$
CREATE TRIGGER after_notification_user_insert
AFTER INSERT ON NotificationsSendToUsers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_user_insert', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.notification_id), 'insert', CONCAT('priority: ', NEW.priority, ', notification_id: ', NEW.notification_id, ', user_id: ', NEW.user_id));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on NotificationsSendToUsers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_notification_user_update;
DELIMITER $$
CREATE TRIGGER after_notification_user_update
AFTER UPDATE ON NotificationsSendToUsers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_user_update', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.notification_id), 'update', CONCAT('priority: ', NEW.priority, ', notification_id: ', NEW.notification_id, ', user_id: ', NEW.user_id));
END$$
DELIMITER ;


-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on NotificationsSendToUsers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_notification_user_delete;
DELIMITER $$
CREATE TRIGGER after_notification_user_delete
AFTER DELETE ON NotificationsSendToUsers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_user_delete', 'Error occurred');
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.user_id, '&&', OLD.notification_id), 'delete', CONCAT('priority: ', OLD.priority, ', notification_id: ', OLD.notification_id, ', user_id: ', OLD.user_id));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on UsersRegisterForEvents table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_user_event_insert;
DELIMITER $$
CREATE TRIGGER after_user_event_insert
AFTER INSERT ON UsersRegisterForEvents
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_message, error_context)
        VALUES ('after_user_event_insert', 'Error occurred', CONCAT('user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.event_name), 'insert', CONCAT('user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on UsersRegisterForEvents table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_user_event_update;
DELIMITER $$
CREATE TRIGGER after_user_event_update
AFTER UPDATE ON UsersRegisterForEvents
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_message, error_context)
        VALUES ('after_user_event_update', 'Error occurred', CONCAT('user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.event_name), 'update', CONCAT('user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on UsersRegisterForEvents table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_user_event_delete;
DELIMITER $$
CREATE TRIGGER after_user_event_delete
AFTER DELETE ON UsersRegisterForEvents
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_message, error_context)
        VALUES ('after_user_event_delete', 'Error occurred', CONCAT('user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.user_id, '&&', OLD.event_name), 'delete', CONCAT('user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on EventsFundedBySponsors table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_events_sponsors_insert;
DELIMITER $$
CREATE TRIGGER after_events_sponsors_insert
AFTER INSERT ON EventsFundedBySponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_message, error_context, event_name)
        VALUES ('after_events_sponsors_insert', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.event_name, '&&', NEW.sponsor_name), 'insert', CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on EventsFundedBySponsors table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_events_sponsors_update;
DELIMITER $$
CREATE TRIGGER after_events_sponsors_update
AFTER UPDATE ON EventsFundedBySponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_message, error_context, event_name)
        VALUES ('after_events_sponsors_update', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.event_name, '&&', NEW.sponsor_name), 'update', CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on EventsFundedBySponsors table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_events_sponsors_delete;
DELIMITER $$
CREATE TRIGGER after_events_sponsors_delete
AFTER DELETE ON EventsFundedBySponsors
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_context, event_name)
        VALUES ('after_events_sponsors_delete', 'Error occurred',CONCAT('sponsor_name: ', OLD.sponsor_name, ', sponsorship_amount: ', OLD.sponsorship_amount), OLD.event_name);
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.event_name, '&&', OLD.sponsor_name), 'delete', CONCAT('sponsor_name: ', OLD.sponsor_name, ', sponsorship_amount: ', OLD.sponsorship_amount, ', event_name: ', OLD.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during insert on EventsOrganisedByOrganisers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_events_organiser_insert;
DELIMITER $$
CREATE TRIGGER after_events_organiser_insert
AFTER INSERT ON EventsOrganisedByOrganisers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_context, event_name)
        VALUES ('after_events_organiser_insert', 'Error occurred',CONCAT('organiser_name: ', NEW.organiser_name), NEW.event_name);
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.event_name, '&&', NEW.organiser_name), 'insert', CONCAT('organiser_name: ', NEW.organiser_name, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during update on EventsOrganisedByOrganisers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_events_organiser_update;
DELIMITER $$
CREATE TRIGGER after_events_organiser_update
AFTER UPDATE ON EventsOrganisedByOrganisers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_context, event_name)
        VALUES ('after_events_organiser_update', 'Error occurred',CONCAT('organiser_name: ', NEW.organiser_name), NEW.event_name);
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.event_name, '&&', NEW.organiser_name), 'update', CONCAT('organiser_name: ', NEW.organiser_name, ', event_name: ', NEW.event_name));
END$$
DELIMITER ;

-- Trigger to insert logs into `EventBuzz`.UserLog table. If there is
-- error during delete on EventsOrganisedByOrganisers table, then insert into `EventBuzz`.ErrorLog table.

DROP TRIGGER IF EXISTS after_events_organiser_delete;
DELIMITER $$
CREATE TRIGGER after_events_organiser_delete
AFTER DELETE ON EventsOrganisedByOrganisers
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzz.ErrorLog (error_context, event_name)
        VALUES ('after_events_organiser_delete', 'Error occurred',CONCAT('organiser_name: ', OLD.organiser_name), OLD.event_name);
    END;
    INSERT INTO EventBuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.event_name, '&&', OLD.organiser_name), 'delete', CONCAT('organiser_name: ', OLD.organiser_name, ', event_name: ', OLD.event_name));
END$$
DELIMITER ;

-- select * from EventBuzz.UserLog;
-- select * from EventBuzz.ErrorLog;
-- delete from EventBuzz.UserLog;
-- show TRIGGERS;