# 🥛 Smart Dairy — Dairy Management System

Smart Dairy is a Java-based web application designed to simplify dairy operations through a centralized management system. It supports user authentication and dairy-related record management, with a dedicated Milk Module for managing sellers, buyers, milk sales, and related records.

The project is developed using Advanced Java technologies as part of a Product-Based Learning (PBL) project.

## 🚀 Application URL

**Local Application:** [http://localhost:8080/SmartDairy/login.jsp](http://localhost:8080/SmartDairy/login.jsp)

> This URL works when the application is running locally on Apache Tomcat.

## ✨ Features

### 🔐 Login and Authentication
- Login page for accessing the application.
- Database support for user email and mobile numbers.
- User account records stored in MySQL.

### 🥛 Milk Management Module
- **Member Management:** Store seller and buyer details in a common members table.
- **Member Codes:** Assign unique codes to members.
- **Mobile Number Records:** Store member contact numbers.
- **Member Types:** Distinguish between `SELLER` and `BUYER`.
- **Animal Types:** Support `COW`, `BUFFALO`, and `BOTH` categories.
- **Status Management:** Track active and inactive members.
- **Rate Chart:** Store milk rates according to animal type, fat, and SNF.
- **Advance Records:** Maintain records of advances given to farmers.
- **Milk Sales:** Record sale date, shift, animal type, quantity, rate, amount, and paid amount.

*Note: The uploaded SQL scripts define the database structure for these features. The availability of each feature in the user interface depends on its implementation in the application code.*

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend development |
| JSP | Dynamic web pages |
| Jakarta Servlets | Request handling |
| JDBC | Database connectivity |
| MySQL | Database management |
| HTML5 and CSS3 | User interface |
| Apache Tomcat 10.1 | Application server |
| Eclipse IDE | Development environment |

## 🗄️ Database Setup

The application uses a MySQL database named `smart_dairy`.

### 1. Create or select the database

```sql
CREATE DATABASE IF NOT EXISTS smart_dairy;
USE smart_dairy;
```

### 2. Configure mobile login

Run the SQL statements from `login_mobile.sql` in MySQL:

```sql
USE smart_dairy;

ALTER TABLE users
ADD COLUMN mobile VARCHAR(15) NULL;

ALTER TABLE users
ADD UNIQUE KEY uq_users_mobile (mobile);

UPDATE users
SET mobile = '9999999999'
WHERE email = 'admin@smartdairy.com';
```

**Important:** Run this script only once on a database where the `mobile` column and `uq_users_mobile` index do not already exist. Replace the example mobile number with the appropriate number before running the update.

### 3. Create Milk Module tables

Run the SQL statements from `milk_module.sql`:

```sql
USE smart_dairy;

CREATE TABLE IF NOT EXISTS members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code INT NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    mobile VARCHAR(15),
    member_type VARCHAR(10) NOT NULL DEFAULT 'SELLER',
    animal_type VARCHAR(10) NOT NULL DEFAULT 'BOTH',
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rate_chart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    animal_type VARCHAR(10) NOT NULL,
    fat DECIMAL(4,1) NOT NULL,
    snf DECIMAL(4,1) NOT NULL,
    rate DECIMAL(8,2) NOT NULL,
    UNIQUE KEY uq_rate (animal_type, fat, snf)
);

CREATE TABLE IF NOT EXISTS advances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_code INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    advance_date DATE NOT NULL,
    note VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS milk_sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_code INT NOT NULL,
    sale_date DATE NOT NULL,
    shift VARCHAR(10),
    animal_type VARCHAR(10),
    quantity DECIMAL(8,2) NOT NULL,
    rate DECIMAL(8,2) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paid DECIMAL(10,2) NOT NULL DEFAULT 0
);
```

For the complete SQL scripts and comments, refer to the included `login_mobile.sql` and `milk_module.sql` files.

## ⚙️ Installation and Setup

### Prerequisites

- Java JDK 21
- Apache Tomcat 10.1
- MySQL Server
- Eclipse IDE for Enterprise Java and Web Developers
- MySQL Connector/J

### 1. Clone the repository

```bash
git clone https://github.com/Gulshan123-ux/SmartDairy.git
```

Open the project in Eclipse.

### 2. Configure database connectivity

Update the database connection settings in `DBConnection.java`:

```java
String url = "jdbc:mysql://localhost:3306/smart_dairy";
String username = "root";
String password = "YOUR_MYSQL_PASSWORD";
```

Replace the placeholder with your local MySQL password. Do not publish real passwords or other secrets in the repository.

### 3. Configure Tomcat

1. Add Apache Tomcat 10.1 to Eclipse.
2. Add the `SmartDairy` project to the server.
3. Ensure MySQL Connector/J is available to the application.
4. Confirm the application context root is `SmartDairy`.
5. Clean and publish the project.

### 4. Run the application

Start Tomcat and open:

[http://localhost:8080/SmartDairy/login.jsp](http://localhost:8080/SmartDairy/login.jsp)

Log in using an active account configured in your database.

## 📁 Project Structure

```text
SmartDairy/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/smartdairy/
│       │       ├── controller/
│       │       ├── dao/
│       │       ├── model/
│       │       └── util/
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── login.jsp
│           ├── dashboard.jsp
│           └── other JSP pages
├── login_mobile.sql
├── milk_module.sql
└── README.md
```

*The structure is illustrative; actual folders and files may vary by project version.*

## 🎯 Project Objectives

- Digitize dairy management operations.
- Centralize seller and buyer records.
- Maintain milk collection and sales information.
- Store milk pricing data based on fat and SNF.
- Track advances and payments.
- Practice Java web development and relational database design.

## 🔮 Future Enhancements

- Complete mobile-number login flow.
- Role-based access for administrators, sellers, and buyers.
- Automatic milk pricing using the rate chart.
- Advance adjustment and payment calculations.
- Daily, weekly, and monthly sales reports.
- Invoice generation and report exports.
- Responsive interface for mobile devices.
- Secure password hashing and account recovery.

## 👨‍💻 Author

**Gulshan**

GitHub: [@Gulshan123-ux](https://github.com/Gulshan123-ux)

Repository: [SmartDairy](https://github.com/Gulshan123-ux/SmartDairy)

## 📄 License

No license has been specified yet. Add a `LICENSE` file if you want to define the terms under which others can use, modify, or distribute this project.

---

⭐ If you find this project useful, consider starring the repository!
# 🥛 Smart Dairy

A dairy management web application built with **Java Servlets, JSP and MySQL**, with **mobile number + OTP login**.

The app is split into two modules:

| Module | Purpose |
|---|---|
| **Milk Module** | For dairy centers that buy milk from farmers and sell it to customers: farmers/customers with code numbers, daily milk collection (morning/evening, cow/buffalo, fat, SNF), rate chart, advances, payments and milk sales. |
| **Business Module** | For managing products of any type: products, inventory, orders, distributors, deliveries, subscriptions, invoices and expenses. |

After login the user chooses which module to open.

> **Status:** work in progress. See the [Roadmap](#roadmap) for what is done and what is planned.

---

## Features

### Login
- Mobile number + 6-digit OTP login (no password)
- OTP valid for 5 minutes, maximum 5 wrong attempts, 30-second resend gap
- OTP is stored hashed in the session, never in plain text
- SMS sending through [Fast2SMS](https://www.fast2sms.com) (API key kept outside the project)
- Testing mode that shows the OTP on screen, so the app can be tried without an SMS account

### Milk Module
- Home screen with today's milk collection (cow / buffalo totals)
- Farmers (sellers) and customers (buyers) list with code number, mobile, active/inactive status and search
- Daily milk collection entry (date, shift, animal type, quantity, fat, SNF, rate, amount)
- Milk collection records and reports
- Database tables ready for: rate chart, advances, milk sales

### Business Module
- Suppliers, customers, products
- Inventory and orders
- Distributors and deliveries
- Subscriptions and invoices
- Payments and expenses
- Daily and expense reports
- Settings page

---

## Tech stack

- Java 21
- Jakarta Servlet 6 / JSP (Apache Tomcat 10.1)
- MySQL 8 with the MySQL Connector/J JDBC driver
- Plain HTML + CSS (no frontend framework)
- Eclipse IDE for Enterprise Java and Web Developers

---

## Project structure

```
SmartDairy/
├── milk_module.sql                  # Milk Module tables
├── login_mobile.sql                 # adds users.mobile for OTP login
└── src/main/
    ├── java/com/smartdairy/
    │   ├── controller/              # Servlets (Login, Member, MilkCollection, Supplier, ...)
    │   ├── dao/                     # Database access (DashboardDAO)
    │   └── util/
    │       ├── DBConnection.java    # MySQL connection
    │       ├── OtpUtil.java         # OTP generate / hash / mobile cleanup
    │       └── SmsSender.java       # Fast2SMS sender + testing mode
    └── webapp/
        ├── login.jsp                # mobile + OTP login
        ├── modules.jsp              # choose Milk / Business module
        ├── dashboard.jsp            # Business Module home
        ├── milk/                    # Milk Module pages
        │   ├── milk_home.jsp
        │   └── members.jsp
        ├── *.jsp                    # other pages (supplier, customer, product, ...)
        └── WEB-INF/
            ├── web.xml              # servlet mappings
            ├── settings.jsp
            └── lib/                 # MySQL JDBC driver
```

---

## Getting started

### 1. Prerequisites

- JDK 21
- Apache Tomcat **10.1** (Tomcat 9 or older will not work, the project uses `jakarta.servlet`)
- MySQL 8
- Eclipse IDE for Enterprise Java and Web Developers

### 2. Clone the repository

```bash
git clone https://github.com/<your-username>/SmartDairy.git
cd SmartDairy
```

### 3. Create the database

```sql
CREATE DATABASE IF NOT EXISTS smart_dairy;
USE smart_dairy;
```

Then create the tables:

1. Business tables (`users`, `suppliers`, `customers`, `products`, `inventory`, `orders`, `order_items`, `distributors`, `deliveries`, `subscriptions`, `invoices`, `payments`, `expenses`, `milk_collection`, `dairy_settings`): see [Database](#database).
2. Milk Module tables:
   ```bash
   mysql -u root -p smart_dairy < milk_module.sql
   ```
3. Mobile login column:
   ```bash
   mysql -u root -p smart_dairy < login_mobile.sql
   ```
   (If it says `Duplicate column name 'mobile'`, the column already exists and you can skip it.)

### 4. Create the first user

Only users who exist in the `users` table with `status = 'ACTIVE'` can log in:

```sql
INSERT INTO users (name, email, mobile, password, role, status)
VALUES ('Admin', 'admin@example.com', '9999999999', 'unused', 'ADMIN', 'ACTIVE');
```

The `password` column is no longer used for login (OTP is used instead).

### 5. Configure the database connection

Open `src/main/java/com/smartdairy/util/DBConnection.java` and set your MySQL user and password.

> **Never commit your real password.** Keep a placeholder in the repository.

### 6. Configure SMS (OTP)

The SMS settings live **outside** the project, in your home folder, so the API key is never committed:

```bash
mkdir -p ~/.smartdairy
```

**Option A: real SMS** (Fast2SMS):

```bash
echo "fast2sms.apikey=YOUR_API_KEY" > ~/.smartdairy/sms.properties
```

**Option B: testing mode** (no SMS is sent; the OTP is printed in the console and shown on the login page):

```bash
echo "dev.mode=true" > ~/.smartdairy/sms.properties
```

> Do **not** use testing mode on a public server. Anyone could read the OTP on the login page.

If neither is set, no OTP is sent and the login page shows "Could not send OTP".

### 7. Run in Eclipse

1. `File → Import → General → Existing Projects into Workspace`, select the project folder.
2. Add a **Tomcat v10.1** server (`Window → Preferences → Server → Runtime Environments`), using JRE 21.
3. Project `Properties → Targeted Runtimes`: tick Tomcat 10.1.
4. `Project → Clean`.
5. Right-click the project, `Run As → Run on Server`.
6. Open **http://localhost:8080/SmartDairy/**

---

## How login works

```
Mobile number  ──►  LoginServlet (action=send)
                      ├─ checks the number exists in `users` and is ACTIVE
                      ├─ generates a 6-digit OTP (SecureRandom)
                      ├─ stores only its hash + expiry in the session
                      └─ SmsSender sends the SMS
OTP            ──►  LoginServlet (action=verify)
                      ├─ checks expiry and attempt count
                      ├─ compares the hash
                      └─ creates a fresh session  ──►  modules.jsp
```

---

## Main pages and servlets

| URL | What it does |
|---|---|
| `/login.jsp` | Mobile + OTP login |
| `/modules.jsp` | Choose Milk or Business module |
| `/milk/milk_home.jsp` | Milk Module home |
| `/MemberServlet` | Farmers / customers (code, search, active/inactive) |
| `/milk_collection.jsp` | Add milk collection |
| `/milk_records.jsp` | Milk collection records |
| `/dashboard.jsp` | Business Module home |
| `/supplier.jsp`, `/customer.jsp`, `/product.jsp` | Master data |
| `/inventory.jsp`, `/order.jsp` | Stock and orders |
| `/distributor.jsp`, `/delivery.jsp` | Distribution |
| `/subscription.jsp`, `/invoice.jsp`, `/payments.jsp`, `/expense.jsp` | Billing and finance |
| `/reports.jsp`, `/daily_report.jsp`, `/expense_report.jsp` | Reports |
| `/LogoutServlet` | Log out |

---

## Database

Milk Module tables are in `milk_module.sql`:

| Table | Purpose |
|---|---|
| `members` | Farmers (SELLER) and customers (BUYER) with a unique code number |
| `rate_chart` | Rate per fat / SNF for cow and buffalo |
| `advances` | Advance money given to farmers |
| `milk_sales` | Milk sold to customers |

The Business Module tables are listed in step 3 above.
`TODO: add schema.sql with the full business-table definitions.`

---

## Security notes

- OTP is hashed, expires in 5 minutes, and is locked after 5 wrong attempts.
- The SMS API key is read from `~/.smartdairy/sms.properties` or the `FAST2SMS_API_KEY` environment variable. It is not part of the repository.
- Keep `DBConnection.java` free of real credentials before pushing.
- Turn off `dev.mode` on any server that other people can reach.
- The app is still in development and has not had a security review.

---

## Roadmap

- [x] Mobile number + OTP login
- [x] Module selection (Milk / Business)
- [x] Milk Module home, farmers/customers list, milk collection
- [x] Business Module (products, inventory, orders, invoices, expenses, ...)
- [ ] Rate chart and automatic rate in milk collection
- [ ] Advances and farmer payment settlement (bhugtan)
- [ ] Milk sales and customer bills
- [ ] Link milk collection to farmer code
- [ ] Role-based access (admin / staff)
- [ ] `schema.sql` for the whole database
- [ ] Move database settings to a config file

---

## Contributing

1. Fork the repository
2. Create a branch: `git checkout -b feature/my-change`
3. Commit and push your changes
4. Open a pull request

---

## License

Add a license of your choice (for example MIT) as a `LICENSE` file.
