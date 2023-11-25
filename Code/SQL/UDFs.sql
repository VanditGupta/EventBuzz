-- Function to calculate the age of a user based on their date of birth.
CREATE FUNCTION CalculateAge(birthDate DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birthDate, CURDATE());
END;



-- Function to calculate the duration of an event in hours based on start and end times/dates.

CREATE FUNCTION CalculateDuration(startDateTime DATETIME, endDateTime DATETIME)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(HOUR, startDateTime, endDateTime);
END;


