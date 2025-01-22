# BankMate: Cash Delivery Service

BankMate is an innovative cash delivery service designed to assist elderly and physically challenged customers by providing doorstep access to ATM transactions. Using mobile ATM devices, customers can securely perform cash withdrawals with the help of service providers.

---

## Features
- **Customer Management:** Manage customer details, including personal and contact information.
- **Transaction Tracking:** Securely log transactions with details such as withdrawal amount, payment mode, and timestamps.
- **Employee Assignment:** Assign service providers to customer requests efficiently.
- **Secure Authentication:** Ensure secure login and data handling for all users.

---

## Technology Stack
- **Backend:** Java (JSP, Servlets)
- **Frontend:** HTML, CSS, JavaScript
- **Database:** PostgreSQL
- **IDE:**  Eclipse
- **Server:** Apache Tomcat

---

## Database Schema
1. **dbuser**: Stores customer information.
2. **serviceprovider**: Manages service provider details.
3. **request**: Tracks cash withdrawal requests and assignments.

---

**How to Install and Run BankMate on Localhost**
Prerequisites
Software Required:

Java Development Kit (JDK)
PostgreSQL with pgAdmin
Apache Tomcat
Eclipse IDE
Git
**Database Setup:**

Install PostgreSQL and create a database named BankMate.
Import the provided SQL scripts to set up tables (dbuser, serviceprovider, request).
Steps to Install and Run
**Clone the Repository:**

bash
Copy
Edit
git clone https://github.com/YourUsername/BankMate.git
cd BankMate
**Import Project in Eclipse:**

Open Eclipse and select File > Import > Existing Projects into Workspace.
Select the cloned BankMate project folder.
**Configure the Database Connection:**

Open the Mylib utility class.
Ensure the database URL, username, and password match your local PostgreSQL setup:
java
Copy
Edit
DriverManager.getConnection("jdbc:postgresql://localhost:5432/BankMate", "postgres", "postgres");
**Deploy on Apache Tomcat:**

Add Apache Tomcat in Eclipse (Servers > New > Server).
Right-click the project > Run As > Run on Server.
Access the Application:

**Open your browser and navigate to:**
http://localhost:8080/BankMate
