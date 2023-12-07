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
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
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
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
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
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_delete', 'Error occurred',CONCAT('sponsor_name: ', OLD.sponsor_name, ', sponsorship_amount: ', OLD.sponsorship_amount), OLD.event_name);
    END;
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount - OLD.sponsorship_amount
    WHERE sponsor_name = OLD.sponsor_name;
END$$
DELIMITER ;

-- Triggers to INSERT, UPDATE and DELETE the total_ticket_sales in Events table
DROP TRIGGER IF EXISTS after_ticket_insert;
DELIMITER $$
CREATE TRIGGER after_ticket_insert
AFTER INSERT ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_insert', 'Error occurred',CONCAT('ticket_id' + NEW.ticket_id + 'ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity), NEW.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = NEW.order_id)
    WHERE order_id = NEW.order_id;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS after_ticket_update;
DELIMITER $$
CREATE TRIGGER after_ticket_update
AFTER UPDATE ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_update', 'Error occurred',CONCAT('ticket_id' + NEW.ticket_id + 'ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity), NEW.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = NEW.order_id)
    WHERE order_id = NEW.order_id;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS after_ticket_delete;
DELIMITER $$
CREATE TRIGGER after_ticket_delete
AFTER DELETE ON Tickets
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_delete', 'Error occurred',CONCAT('ticket_id' + OLD.ticket_id + 'ticket_price: ', OLD.ticket_price, ', ticket_quantity: ', OLD.ticket_quantity), OLD.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = OLD.order_id)
    WHERE order_id = OLD.order_id;
END$$
DELIMITER ;

-- Triggers to add errors for Create, Read and Update for Users table in the ErrorLog table

DROP TRIGGER IF EXISTS after_user_insert;
DELIMITER $$
CREATE TRIGGER after_user_insert
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_user_insert', 'Error occurred',CONCAT('user_id: ', NEW.user_id, ', user_name: ', NEW.username));
    END;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS after_user_update;
DELIMITER $$
CREATE TRIGGER after_user_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_user_update', 'Error occurred',CONCAT('user_id: ', NEW.user_id, ', user_name: ', NEW.username));
    END;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS after_user_delete;
DELIMITER $$
CREATE TRIGGER after_user_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_user_delete', 'Error occurred',CONCAT('user_id: ', OLD.user_id, ', user_name: ', OLD.username));
    END;
END$$
DELIMITER ;

-- Triggers to add errors for Create, Read and Update for EventCategories table in the ErrorLog table

DROP TRIGGER IF EXISTS after_eventcategory_insert;
DELIMITER $$
CREATE TRIGGER after_eventcategory_insert
AFTER INSERT ON EventCategories
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_eventcategory_insert', 'Error occurred',CONCAT('category_name: ', NEW.category_name));
    END;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS after_eventcategory_update;
DELIMITER $$
CREATE TRIGGER after_eventcategory_update
AFTER UPDATE ON EventCategories
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_eventcategory_update', 'Error occurred',CONCAT('category_name: ', NEW.category_name));
    END;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS after_eventcategory_delete;
DELIMITER $$
CREATE TRIGGER after_eventcategory_delete
AFTER DELETE ON EventCategories
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_eventcategory_delete', 'Error occurred',CONCAT('category_name: ', OLD.category_name));
    END;
END$$
DELIMITER ;

-- Triggers to add errors for Create, Read and Update for Venues table in the ErrorLog table

DROP TRIGGER IF EXISTS after_venue_insert;
DELIMITER $$
CREATE TRIGGER after_venue_insert
AFTER INSERT ON Venues
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_venue_insert', 'Error occurred',CONCAT('venue_name: ', NEW.venue_name));
    END;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS after_venue_update;
DELIMITER $$
CREATE TRIGGER after_venue_update
AFTER UPDATE ON Venues
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_venue_update', 'Error occurred',CONCAT('venue_name: ', NEW.venue_name));
    END;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS after_venue_delete;
DELIMITER $$
CREATE TRIGGER after_venue_delete
AFTER DELETE ON Venues
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_venue_delete', 'Error occurred',CONCAT('venue_name: ', OLD.venue_name));
    END;
END$$
DELIMITER ;

-- select * from `EventBuzzAudit`.`ErrorLog`;
-- show TRIGGERS;