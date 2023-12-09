
-- Create VIEW for Users table

DROP VIEW IF EXISTS UsersView;
CREATE VIEW UsersView AS SELECT * FROM Users;

-- SELECT * FROM UsersView;

-- Create VIEW for EventCategories table

DROP VIEW IF EXISTS EventCategoriesView;
CREATE VIEW  EventCategoriesView AS SELECT * FROM EventCategories;

-- SELECT * FROM EventCategoriesView;

-- Create VIEW for Venues table

DROP VIEW IF EXISTS VenuesView;
CREATE VIEW  VenuesView AS SELECT * FROM Venues;

-- SELECT * FROM VenuesView;

-- Create VIEW for Events table

DROP VIEW IF EXISTS EventsView;
CREATE VIEW  EventsView AS SELECT * FROM Events;

-- SELECT * FROM EventsView;

-- Create VIEW for Orders table

DROP VIEW IF EXISTS OrdersView;
CREATE VIEW  OrdersView AS SELECT * FROM Orders;

-- SELECT * FROM OrdersView;

-- Create VIEW for Tickets table

DROP VIEW IF EXISTS TicketsView;
CREATE VIEW  TicketsView AS SELECT * FROM Tickets;

-- SELECT * FROM TicketsView;

-- Create VIEW for Reviews table

DROP VIEW IF EXISTS ReviewsView;
CREATE VIEW  ReviewsView AS SELECT * FROM Reviews;

-- SELECT * FROM ReviewsView;

-- Create VIEW for Sponsors table

DROP VIEW IF EXISTS SponsorsView;
CREATE VIEW  SponsorsView AS SELECT * FROM Sponsors;

-- SELECT * FROM SponsorsView;

-- Create VIEW for Notifications table

DROP VIEW IF EXISTS NotificationsView;
CREATE VIEW  NotificationsView AS SELECT * FROM Notifications;

-- SELECT * FROM NotificationsView;

-- Create VIEW for NotificationsSendToUsers table

DROP VIEW IF EXISTS NotificationsSendToUsersView;
CREATE VIEW  NotificationsSendToUsersView AS SELECT * FROM NotificationsSendToUsers;

-- SELECT * FROM NotificationsSendToUsersView;

-- Create VIEW for UsersRegisterForEvents table

DROP VIEW IF EXISTS UsersRegisterForEventsView;
CREATE VIEW  UsersRegisterForEventsView AS SELECT * FROM UsersRegisterForEvents;

-- SELECT * FROM UsersRegisterForEventsView;

-- Create VIEW for EventsFundedBySponsors table

DROP VIEW IF EXISTS EventsFundedBySponsorsView;
CREATE VIEW  EventsFundedBySponsorsView AS SELECT * FROM EventsFundedBySponsors;

-- SELECT * FROM EventsFundedBySponsorsView;

-- Create VIEW for EventsOrganisedByOrganisers table

DROP VIEW IF EXISTS EventsOrganisedByOrganisersView;
CREATE VIEW  EventsOrganisedByOrganisersView AS SELECT * FROM EventsOrganisedByOrganisers;

-- SELECT * FROM EventsOrganisedByOrganisersView;

-- Create VIEW for ErrorLog table

DROP VIEW IF EXISTS ErrorLogView;
CREATE VIEW  ErrorLogView AS SELECT * FROM ErrorLog;

-- SELECT * FROM ErrorLogView;

-- Create VIEW for UserLog table

DROP VIEW IF EXISTS UserLogView;
CREATE VIEW  UserLogView AS SELECT * FROM UserLog;

-- SELECT * FROM UserLogView;

