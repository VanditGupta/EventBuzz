# EventBuzz Database Schema

This SQL script creates a database for an event management system named `EventBuzz`. The database consists of several tables that store information about users, events, venues, orders, tickets, reviews, sponsors, organizers, and notifications.

## Tables

### Users

Stores information about the users of the system. Each user has a unique ID, username, email, and password. Additional information such as name, date of birth, sex, phone number, address, profile picture URL, role, status, and registration date are also stored.

### EventCategories

Stores different categories of events. Each category has a name and a description.

### Venues

Stores information about the venues where events are held. Each venue has a name, address, maximum capacity, and contact information.

### Events

Stores information about the events. Each event has a name, description, date, time, status, image URL, category, and venue.

### Orders

Stores information about the orders made by users. Each order has an ID, user ID, total amount, date, payment type, payment status, and event name.

### Tickets

Stores information about the tickets for events. Each ticket has an ID, order ID, price, quantity, start and end sale date, and event name.

### Reviews

Stores reviews made by users for events. Each review has a user ID, event name, rating, comment, and date.

### Sponsors

Stores information about the sponsors. Each sponsor has a name, description, website URL, logo URL, contact information, and total sponsorship amount.

### Organisers

Stores information about the organisers. Each organiser has a name, description, logo URL, and contact information.

### Notifications

Stores information about the notifications sent to users. Each notification has an ID, event name, text, and date.

### Notifications_SendTo_Users

Stores information about which notifications were sent to which users.

### Users_RegisterFor_Events

Stores information about which users registered for which events.

### Events_FundedBy_Sponsors

Stores information about which events are funded by which sponsors and the amount of sponsorship.

### Events_OrganisedBy_Organisers

Stores information about which events are organised by which organisers and their roles.

## Note

The script first checks if the `EventBuzz` database exists and creates it if it doesn't. It then uses the `EventBuzz` database and creates the tables. If any of the tables already exist, it doesn't create them.