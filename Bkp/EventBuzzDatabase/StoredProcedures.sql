CREATE PROCEDURE GenerateEventSummary(eventName VARCHAR(255))
BEGIN
    SELECT COUNT(*) AS TotalAttendees, SUM(total_amount) AS TotalRevenue
    FROM Orders
    WHERE event_name = eventName;

    SELECT COUNT(*) AS TotalTicketsSold, SUM(ticket_quantity) AS TotalTickets
    FROM Tickets
    WHERE event_name = eventName;

    SELECT COUNT(*) AS TotalReviews, AVG(rating) AS AverageRating
    FROM Reviews
    WHERE event_name = eventName;

    SELECT COUNT(*) AS TotalNotifications
    FROM Notifications
    WHERE event_name = eventName;

    SELECT COUNT(*) AS TotalRegistrations
    FROM Users_RegisterFor_Events
    WHERE event_name = eventName;

    SELECT COUNT(*) AS TotalSponsors, SUM(sponsorship_amount) AS TotalSponsorshipAmount
    FROM Events_FundedBy_Sponsors
    WHERE event_name = eventName;

    SELECT COUNT(*) AS TotalOrganisers
    FROM Events_OrganisedBy_Organisers
    WHERE event_name = eventName;

END;
