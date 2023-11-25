-- UDFs.sql create the user-defined functions for the EventBuzz Schema

-- Function to calculate the age of a user based on their date of birth.
CREATE FUNCTION CalculateAge(birthDate DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    IF birthDate IS NULL OR birthDate > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid birth date';
    END IF;

    RETURN TIMESTAMPDIFF(YEAR, birthDate, CURDATE());
END;




-- Function to calculate the duration of an event in hours based on start and end times/dates.

CREATE FUNCTION CalculateDuration(startDateTime DATETIME, endDateTime DATETIME)
RETURNS INT
DETERMINISTIC
BEGIN
    IF startDateTime IS NULL OR endDateTime IS NULL OR endDateTime < startDateTime THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid start or end date-time';
    END IF;

    RETURN TIMESTAMPDIFF(HOUR, startDateTime, endDateTime);
END;

