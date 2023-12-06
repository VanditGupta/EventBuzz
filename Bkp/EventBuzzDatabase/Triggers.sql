-- Triggers.sql creates triggers on the EventBuzz Schema

USE EventBuzz;


DROP TRIGGER IF EXISTS after_sponsorship_insert;
DELIMITER $$
CREATE TRIGGER after_sponsorship_insert
AFTER INSERT ON Events_FundedBy_Sponsors
FOR EACH ROW
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_insert', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;

>>>>>>> vandit:Bkp/EventBuzzDatabase/Triggers.sql
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount + NEW.sponsorship_amount
    WHERE sponsor_name = NEW.sponsor_name;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS after_sponsorship_update;
DELIMITER $$
CREATE TRIGGER after_sponsorship_update
AFTER UPDATE ON Events_FundedBy_Sponsors
FOR EACH ROW
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_update', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;
>>>>>>> vandit:Bkp/EventBuzzDatabase/Triggers.sql
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount - OLD.sponsorship_amount + NEW.sponsorship_amount
    WHERE sponsor_name = NEW.sponsor_name;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS after_sponsorship_delete;
DELIMITER $$
CREATE TRIGGER after_sponsorship_delete
AFTER DELETE ON Events_FundedBy_Sponsors
FOR EACH ROW
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO EventBuzzAudit.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_delete', 'Error occurred',CONCAT('sponsor_name: ', OLD.sponsor_name, ', sponsorship_amount: ', OLD.sponsorship_amount), OLD.event_name);
    END;
>>>>>>> vandit:Bkp/EventBuzzDatabase/Triggers.sql
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount - OLD.sponsorship_amount
    WHERE sponsor_name = OLD.sponsor_name;
END$$
DELIMITER ;


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
>>>>>>> vandit:Bkp/EventBuzzDatabase/Triggers.sql
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
>>>>>>> vandit:Bkp/EventBuzzDatabase/Triggers.sql
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
>>>>>>> vandit:Bkp/EventBuzzDatabase/Triggers.sql
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = OLD.order_id)
    WHERE order_id = OLD.order_id;
END$$

DELIMITER ;




=======
DELIMITER ;
>>>>>>> vandit:Bkp/EventBuzzDatabase/Triggers.sql
