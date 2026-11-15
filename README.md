# TrackNest — Centralized Multi-Platform Order Tracking System

## 1. Project Overview

TrackNest is a centralized order tracking system that allows customers to view and monitor orders from multiple e-commerce platforms through one dashboard.

Instead of checking different websites and courier services separately, customers can view their order information, shipment status, courier details, and tracking history in one place.

**TrackNest is a tracking system, not an online shopping store.** It does not sell products or process payments.

## 2. Main Features

- Customer registration and login.
- Secure password hashing using BCrypt.
- Session-based authentication.
- Centralized order dashboard.
- Order history and order details.
- Shipment tracking information.
- Chronological shipment tracking timeline.
- Support for multiple courier adapters.
- Normalization of courier shipment statuses.
- Dashboard order search.
- SQL Server database integration.

## 3. Technologies Used

| Technology | Purpose |
|---|---|
| Java | Application logic |
| JSP | User interface |
| Servlets | Request handling |
| JDBC | Database connectivity |
| Microsoft SQL Server | Data storage |
| Maven | Dependency and build management |
| Apache Tomcat 10.1 | Application server |
| JUnit 5 | Unit testing |
| HTML, CSS, JavaScript | Frontend |

## 4. Architecture

TrackNest follows Layered Architecture.

1. **Presentation Layer:** JSP pages and Servlets handle user interaction and HTTP requests.
2. **Service Layer:** Contains business logic and application operations.
3. **Data Access Layer:** DAO classes communicate with the database using JDBC.
4. **Database Layer:** SQL Server stores customers, orders, shipments, and tracking events.

## 5. Design Pattern — Adapter Pattern

The Adapter Pattern is used to support different courier tracking providers through a common interface.

Implemented components include:

- `TrackingProvider` — common tracking interface.
- `TCSAdapter` — adapts TCS tracking information.
- `LeopardAdapter` — adapts Leopard tracking information.
- `TrackingInfo` — common tracking data representation.
- `TrackingStatusNormalizer` — converts different status descriptions into standardized statuses.
- `TrackingService` — coordinates courier tracking operations.

This approach allows the application to handle different courier formats through a consistent tracking interface.

**Note:** The current courier adapters use database-backed demonstration tracking records. They do not connect to live courier APIs.

## 6. Database

Database name: `TrackNestDB`

The database contains the following tables:

- Customers
- Orders
- Shipments
- TrackingEvents

Database scripts are available in the `database` directory:

- `01_CreateDatabaseAndTables.sql`
- `02_SeedSampleData.sql`

Execute the database creation script first, followed by the sample-data script, when setting up a fresh development database.

## 7. Project Setup

### Prerequisites

- JDK 24
- Apache Maven
- Apache Tomcat 10.1
- Microsoft SQL Server
- IntelliJ IDEA or another Java IDE

### Database Configuration

Configure these environment variables before starting Tomcat:

- `TRACKNEST_DB_URL`
- `TRACKNEST_DB_USER`
- `TRACKNEST_DB_PASSWORD`

Example database URL:

`jdbc:sqlserver://localhost:1433;databaseName=TrackNestDB;encrypt=true;trustServerCertificate=true`

Do not commit actual database passwords or credentials to GitHub.

### Build the Project

Run the following command from the project directory:

`mvn clean package`

### Run Unit Tests

Execute:

`mvn test`

The JUnit 5 test class tests the tracking status normalization logic, including valid statuses, null input, and blank input.

### Deploy

Deploy the generated `target/tracknest.war` file to the Apache Tomcat `webapps` directory.

Start Tomcat and open:

`http://localhost:8080/TrackNest/`

## 8. Project Structure

```text
Tracknest/
│
├── database/
│   ├── 01_CreateDatabaseAndTables.sql
│   └── 02_SeedSampleData.sql
│
├── src/
│   ├── main/
│   │   ├── java/com/tracknest/
│   │   │   ├── controller/
│   │   │   ├── dao/
│   │   │   ├── model/
│   │   │   ├── service/
│   │   │   ├── adapter/
│   │   │   └── util/
│   │   │
│   │   └── webapp/
│   │       ├── css/
│   │       ├── js/
│   │       ├── index.jsp
│   │       ├── login.jsp
│   │       ├── register.jsp
│   │       ├── dashboard.jsp
│   │       └── tracking.jsp
│   │
│   └── test/
│       └── java/com/tracknest/service/
│           └── TrackingStatusNormalizerTest.java
│
├── pom.xml
└── README.md
```

## 9. Testing

JUnit 5 is used to test the `TrackingStatusNormalizer` functionality.

The tests cover:

- Out for Delivery
- Delivered
- In Transit
- Picked Up
- Null status
- Blank status

## 10. Project Objective

The main objective of TrackNest is to simplify shipment monitoring by providing customers with one centralized interface for viewing orders and tracking information from multiple platforms and courier partners.

**Developed as a Software Construction and Development semester project.**