# 🚗 Vehicle Rental System - Database Design & SQL Queries

## 📌 Overview  
This project implements a simplified **Vehicle Rental System** database using **PostgreSQL**.  
The system manages **Users (Admins & Customers)**, **Vehicles**, and **Bookings**.

---

## 🗄️ Database Schema

## 1️⃣ Users Table
Stores user information with role-based access control.
```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(200) UNIQUE,
    phone DECIMAL(11,0),
    role VARCHAR(50) CHECK (role IN ('Admin', 'Customer'))
);
```
## 2️⃣ Vehicles Table
Stores vehicle details including availability and unique registration number.

```sql
Copy code
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    type VARCHAR(50) CHECK (type IN ('car', 'bike', 'truck')),
    model INT,
    registration_number VARCHAR(100) UNIQUE,
    rental_price INT,
    status VARCHAR(60) CHECK (status IN ('available', 'rented', 'maintenance'))
);
```
## 3️⃣ Bookings Table
Records rental bookings by linking users and vehicles.

```sql
Copy code
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    vehicle_id INT REFERENCES vehicles(vehicle_id),
    start_date DATE,
    end_date DATE,
    status VARCHAR(60) CHECK (
        status IN ('pending', 'confirmed', 'completed', 'cancelled')
    ),
    total_cost INT
);
```
## 🔗 Relationships
One User → Many Bookings

One Vehicle → Many Bookings

Each Booking belongs to exactly one User and one Vehicle

## 📊 SQL Queries
### 🔹 Query 1: Booking details with user & vehicle names
```sql
Copy code
SELECT 
  booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  start_date,
  end_date,
  b.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
```
### 🔹 Query 2: Vehicles that have never been booked
```sql
Copy code
SELECT *
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
);
```
### 🔹 Query 3: Available cars only
```sql
Copy code
SELECT *
FROM vehicles
WHERE status = 'available'
  AND type = 'car';
  ```
###  🔹 Query 4: Vehicles with at least 2 bookings
```sql
Copy code
SELECT 
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN vehicles v ON b.vehicle_id = v.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) >= 2;
```
## ✅ Features & Constraints
Unique email & registration number

Role validation (Admin / Customer)

Vehicle type restriction

Booking & vehicle status validation

Foreign key relationships

🧩 ER Diagram
🔗 https://lucid.app/lucidspark/7a18b7bd-4edd-4076-90d6-93be86b17e37/view


