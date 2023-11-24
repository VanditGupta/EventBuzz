-- Triggers.sql creates triggers on the EventBuzz Schema

USE EventBuzz;


DROP TRIGGER IF EXISTS after_sponsorship_insert;
DELIMITER $$
CREATE TRIGGER after_sponsorship_insert
AFTER INSERT ON Events_FundedBy_Sponsors
FOR EACH ROW
BEGIN
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
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = OLD.order_id)
    WHERE order_id = OLD.order_id;
END$$
DELIMITER ;




