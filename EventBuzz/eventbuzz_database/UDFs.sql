-- UDFs.sql create the user-defined functions for the eventbuzz Schema

-- Function to calculate the age of a user based on their date of birth.
USE eventbuzz;

DROP FUNCTION IF EXISTS CalculateAge;
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

DROP FUNCTION IF EXISTS CalculateDuration;
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

DROP FUNCTION IF EXISTS CalculateTotalAmount;
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

-- Call the CalculateTotalAmount function

-- select CalculateTotalAmount(1);


-- Call the CalculateAge function

-- select CalculateAge('1999-02-22');

-- select CalculateAge('2900-01-01');


-- Call the CalculateDuration function

-- select CalculateDuration('2021-01-01 10:00:00', '2021-01-01 12:00:00');

-- select CalculateDuration('2021-01-01 10:00:00', '2021-01-01 09:00:00');

-- Function to calculate the number of events booked by a user

DROP FUNCTION IF EXISTS CalculateNumberOfEventsBooked;
CREATE FUNCTION IF NOT EXISTS CalculateNumberOfEventsBooked(userId INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numberOfEventsBooked INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM UsersRegisterForEvents WHERE user_id = userId;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO numberOfEventsBooked;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;

    RETURN numberOfEventsBooked;
END;

-- SELECT * FROM UsersRegisterForEvents;

-- Call the CalculateNumberOfEventsBooked function

-- select CalculateNumberOfEventsBooked(1);

-- Function to calculate the total amount spent by a sponsor on all the events

DROP FUNCTION IF EXISTS CalculateTotalAmountSponsorSpends;
CREATE FUNCTION IF NOT EXISTS CalculateTotalAmountSponsorSpends(sponsorName VARCHAR(255))
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE totalAmountSpent DOUBLE DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT SUM(sponsorship_amount) FROM EventsFundedBySponsors WHERE sponsor_name = sponsorName;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO totalAmountSpent;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;

    RETURN totalAmountSpent;
END;

-- Call the CalculateTotalAmountSponsorSpends function

-- select CalculateTotalAmountSponsorSpends('BizNetwork');

-- SELECT CalculateTotalAmountSponsorSpends('EduMinds');


-- Function to calculate the number of organizers for an event

DROP FUNCTION IF EXISTS CalculateNumberOfOrganizers;
CREATE FUNCTION IF NOT EXISTS CalculateNumberOfOrganizers(eventName VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numberOfOrganizers INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM EventsOrganisedByOrganisers WHERE event_name = eventName;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO numberOfOrganizers;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;

    RETURN numberOfOrganizers;
END;

-- Call the CalculateNumberOfOrganizers function

-- select CalculateNumberOfOrganizers('Business Networking Event');


-- Function to calculate the number of times a venue has been booked

DROP FUNCTION IF EXISTS CalculateNumberOfTimesVenueBooked;
CREATE FUNCTION IF NOT EXISTS CalculateNumberOfTimesVenueBooked(venueName VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numberOfTimesVenueBooked INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM Events WHERE venue_name = venueName;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO numberOfTimesVenueBooked;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;

    RETURN numberOfTimesVenueBooked;
END;

-- Call the CalculateNumberOfTimesVenueBooked function

-- select CalculateNumberOfTimesVenueBooked('The Grand Hall');


-- Function to calculate the number of payments done using a payment type

DROP FUNCTION IF EXISTS CalculateNumberOfPaymentsDone;
CREATE FUNCTION IF NOT EXISTS CalculateNumberOfPaymentsDone(paymentType VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numberOfPaymentsDone INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM Orders WHERE payment_type = paymentType;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO numberOfPaymentsDone;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;

    RETURN numberOfPaymentsDone;
END;

-- Call the CalculateNumberOfPaymentsDone function

-- select CalculateNumberOfPaymentsDone('credit_card');
