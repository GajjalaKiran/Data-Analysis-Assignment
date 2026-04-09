-- CLINICS TABLE
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

-- CUSTOMER TABLE
CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

-- CLINIC SALES TABLE
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- EXPENSES TABLE
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(255),
    amount DECIMAL(10,2),
    datetime DATETIME,
    
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


-- Data Insertion
-- CLINICS
INSERT INTO clinics VALUES
('c1', 'HealthCare Clinic', 'Hyderabad', 'Telangana', 'India'),
('c2', 'Wellness Center', 'Hyderabad', 'Telangana', 'India'),
('c3', 'City Clinic', 'Bangalore', 'Karnataka', 'India'),
('c4', 'Metro Clinic', 'Chennai', 'Tamil Nadu', 'India'),
('c5', 'Care Hospital', 'Bangalore', 'Karnataka', 'India');

-- CUSTOMERS
INSERT INTO customer VALUES
('u1', 'John Doe', '9876543210'),
('u2', 'Jane Smith', '9123456780'),
('u3', 'Alice Brown', '9988776655'),
('u4', 'Bob Johnson', '9090909090'),
('u5', 'Charlie Lee', '9012345678');

-- CLINIC SALES (Different months + channels)
INSERT INTO clinic_sales VALUES
('o1', 'u1', 'c1', 2000, '2021-01-10 10:00:00', 'online'),
('o2', 'u2', 'c1', 5000, '2021-01-15 12:00:00', 'offline'),
('o3', 'u3', 'c2', 7000, '2021-02-20 11:00:00', 'partner'),
('o4', 'u1', 'c3', 3000, '2021-02-25 09:30:00', 'online'),
('o5', 'u4', 'c4', 9000, '2021-03-05 14:00:00', 'offline'),
('o6', 'u5', 'c5', 12000, '2021-03-18 16:00:00', 'online'),
('o7', 'u2', 'c2', 4000, '2021-10-10 10:00:00', 'partner'),
('o8', 'u3', 'c3', 8000, '2021-10-12 13:00:00', 'online'),
('o9', 'u1', 'c1', 6000, '2021-10-20 15:00:00', 'offline'),
('o10','u4', 'c4', 11000,'2021-11-05 11:00:00', 'online');

-- EXPENSES
INSERT INTO expenses VALUES
('e1', 'c1', 'Medical Supplies', 1500, '2021-01-12 09:00:00'),
('e2', 'c1', 'Staff Salary', 3000, '2021-01-20 18:00:00'),
('e3', 'c2', 'Equipment', 2000, '2021-02-22 10:00:00'),
('e4', 'c3', 'Maintenance', 1000, '2021-02-26 12:00:00'),
('e5', 'c4', 'Utilities', 2500, '2021-03-06 08:00:00'),
('e6', 'c5', 'Staff Salary', 4000, '2021-03-20 17:00:00'),
('e7', 'c1', 'Rent', 3500, '2021-10-05 09:00:00'),
('e8', 'c2', 'Supplies', 1500, '2021-10-11 10:30:00'),
('e9', 'c3', 'Maintenance', 2000, '2021-10-15 14:00:00'),
('e10','c4', 'Utilities', 3000, '2021-11-06 16:00:00');