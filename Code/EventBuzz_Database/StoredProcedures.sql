-- StoredProcedures.sql create stored procedures for the EventBuzz Schema

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
        (SELECT COUNT(*) FROM Users_RegisterFor_Events WHERE event_name = eventName) AS TotalRegistrations,
        (SELECT COUNT(*) FROM Events_FundedBy_Sponsors WHERE event_name = eventName) AS TotalSponsors,
        (SELECT SUM(sponsorship_amount) FROM Events_FundedBy_Sponsors WHERE event_name = eventName) AS TotalSponsorshipAmount,
        (SELECT COUNT(*) FROM Events_OrganisedBy_Organisers WHERE event_name = eventName) AS TotalOrganisers;

END $$

DELIMITER ;
