-- UDFs.sql create the user-defined functions for the EventBuzz Schema

-- Function to calculate the age of a user based on their date of birth.
USE EventBuzz;

CREATE FUNCTION IF NOT EXISTS CalculateAge(birthDate DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE currentDate DATE;
    SET currentDate = CURDATE();

    IF birthDate IS NULL OR birthDate > currentDate THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid birth date';
    END IF;

    RETURN TIMESTAMPDIFF(YEAR, birthDate, currentDate);
END;




-- Function to calculate the duration of an event in hours based on start and end times/dates.

CREATE FUNCTION IF NOT EXISTS CalculateDuration(startDateTime DATETIME, endDateTime DATETIME)
RETURNS INT
DETERMINISTIC
BEGIN
    IF startDateTime IS NULL OR endDateTime IS NULL OR endDateTime < startDateTime THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid start or end date or start-date greater than end-date';
    END IF;

    RETURN TIMESTAMPDIFF(HOUR, startDateTime, endDateTime);
END;

-- Function to calculate total amount a user spends on the tickets for all the EVENTS

CREATE FUNCTION IF NOT EXISTS CalculateTotalAmount(userId INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE totalAmount DOUBLE DEFAULT 0;
    DECLARE ticketPrice DOUBLE DEFAULT 0;
    DECLARE ticketQuantity INT DEFAULT 0;
    DECLARE eventId INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT ticket_price, ticket_quantity, event_name FROM Tickets WHERE order_id IN (SELECT order_id FROM Orders WHERE user_id = userId);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO ticketPrice, ticketQuantity, eventId;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET totalAmount = totalAmount + (ticketPrice * ticketQuantity);
    END LOOP;
    CLOSE cur;

    RETURN totalAmount;
END;


-- Call the CalculateAge function

-- select CalculateAge('1999-02-22');

-- select CalculateAge('2900-01-01');


-- Call the CalculateDuration function

-- select CalculateDuration('2021-01-01 10:00:00', '2021-01-01 12:00:00');

-- select CalculateDuration('2021-01-01 10:00:00', '2021-01-01 09:00:00');
-- test

