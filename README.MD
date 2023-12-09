# EventBuzz

## Description
EventBuzz is a comprehensive event management application designed to streamline the organization, planning, and attendance of various types of events. It provides an intuitive platform for event organizers, attendees, and sponsors to create, manage, and engage with events seamlessly.

## Features
- **CRUD Operations:** Complete control over creating, reading, updating, and deleting events.
- **User-Friendly Interface:** Easy navigation and interaction for users.
- **Event Organization:** Effortless creation and management of event details.
- **Dynamic Data Presentation:** Utilizes derived attributes and real-time data updates.
- **Robust Backend Logic:** Sophisticated stored procedures for efficient data handling.
- **Automatic Data Updates:** Database triggers for real-time data integrity.
- **Secure and Reliable:** Comprehensive error handling and data validation.
- **User and Error Logs:** The system's user and error log tables are essential for tracking requests and maintaining operational integrity, enabling swift issue resolution and performance monitoring.

## Technical Stack
- **Backend:** Node.js with Express.js
- **Frontend:** React.js
- **Database:** MySQL

## Installation

### Prerequisites
- [Node.js](https://nodejs.org/)
- [MySQL](https://dev.mysql.com/downloads/mysql/)
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)


### Backend Setup
1. Navigate to the backend directory using terminal:
   ```bash
   cd eventbuzz_backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```

### Frontend Setup
1. Navigate to the frontend directory using terminal:
   ```bash
   cd eventbuzz_frontend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```

### Database Setup
Run the provided SQL dump 

OR 

Run the SQL scripts provided in the eventbuzz_database folder in the following order:
- CreateSchema.sql - This file creates the base tables
- CreateAuditTables.sql - This file creates the log tables
- Indexes.sql - This file creates indexes for the base tables and the log tables for improved performance
- CreateViews.sql - This file creates the views on the base tables and the log tables.
- StoredProcedures.sql - This file creates the Stored Procedures for CRUD operations on all table
- Triggers.sql - This file creates the Triggers for UserLog and ErrorLog tables
- UDFs.sql - This file creates the UDFs used in the project
InsertRecords.sql - This file inserts 10 records each in all the base tables


## Running the Application
1. Start the backend server:
   ```bash
   cd eventbuzz_backend
   npm start
   ```
2. Start the frontend application:
   ```bash
   cd eventbuzz_frontend/src
   npm start
   ```

## EventBuzz demo
Youtube Link: [EventBuzz](https://youtu.be/kWbhKLEkx7o)
   
## Contributing
We welcome contributions to the EventBuzz project. Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

## License
This project is licensed under the [GNU Affero General Public License.](https://www.gnu.org/licenses/agpl-3.0.html).

## Acknowledgements
- Our team: Vandit Gupta, Gargi Umrajkar, Chaitanya Kharche
- All contributors and supporters of the EventBuzz project.

## Contact
For any inquiries or contributions, please contact us at [gupta.vandi@northeastern.edu](mailto:gupta.vandi@northeastern.edu).

## Project Status
This project is currently in active development. For the latest updates, please check our [GitHub repository](https://github.com/VanditGupta/EventBuzz).