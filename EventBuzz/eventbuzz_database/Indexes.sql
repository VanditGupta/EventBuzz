-- Indexes.sql create the indexes for the eventbuzz Schema

USE eventbuzz;

-- Indexes for Users table
CREATE INDEX idx_users_username ON Users(username);
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_role ON Users(role);


-- Indexes for Events table
CREATE INDEX idx_events_date_status ON Events(event_date, event_status);
CREATE INDEX idx_events_category ON Events(category_name);
CREATE INDEX idx_events_venue ON Events(venue_name);


-- Indexes for Orders table
CREATE INDEX idx_orders_user ON Orders(user_id);
CREATE INDEX idx_orders_event ON Orders(event_name);
CREATE INDEX idx_orders_date_status ON Orders(order_date, payment_status);


-- Indexes for Tickets table
CREATE INDEX idx_tickets_event ON Tickets(event_name);
CREATE INDEX idx_tickets_order ON Tickets(order_id);


-- Indexes for Reviews, Notifications, and other junction tables
CREATE INDEX idx_reviews_user_event ON Reviews(user_id, event_name);
CREATE INDEX idx_notifications_event ON Notifications(event_name);
CREATE INDEX idx_notifications_sendto_users ON NotificationsSendToUsers(user_id, notification_id);
CREATE INDEX idx_users_registerfor_events ON UsersRegisterForEvents(user_id, event_name);
CREATE INDEX idx_events_fundedby_sponsors ON EventsFundedBySponsors(event_name, sponsor_name);
CREATE INDEX idx_events_organisedby_organisers ON EventsOrganisedByOrganisers(event_name, organiser_name);

-- Indexes for ErrorLog and UserLog tables

CREATE INDEX idx_errorlog_timestamp ON ErrorLog(error_timestamp);
CREATE INDEX idx_userlog_timestamp ON UserLog(action_timestamp);


