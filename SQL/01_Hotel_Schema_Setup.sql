
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address VARCHAR(255)
);


CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);


CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);



-- Data Insertion 

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('u1', 'John Doe', '9876543210', 'john.doe@example.com', 'Street 1, City A'),
('u2', 'Jane Smith', '9123456780', 'jane.smith@example.com', 'Street 2, City B'),
('u3', 'Alice Brown', '9988776655', 'alice.brown@example.com', 'Street 3, City C'),
('u4', 'Bob Johnson', '9090909090', 'bob.johnson@example.com', 'Street 4, City D');

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('b1', '2021-10-05 10:00:00', '101', 'u1'),
('b2', '2021-10-15 12:30:00', '102', 'u2'),
('b3', '2021-11-10 09:45:00', '103', 'u1'),
('b4', '2021-11-20 14:20:00', '104', 'u3'),
('b5', '2021-12-01 18:00:00', '105', 'u4');

INSERT INTO items (item_id, item_name, item_rate) VALUES
('i1', 'Tawa Paratha', 18),
('i2', 'Mix Veg', 89),
('i3', 'Paneer Butter Masala', 150),
('i4', 'Rice', 60),
('i5', 'Dal Fry', 80);




INSERT INTO booking_commercials 
(id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES

-- October bills
('bc1', 'b1', 'bill1', '2021-10-05 11:00:00', 'i1', 5),
('bc2', 'b1', 'bill1', '2021-10-05 11:00:00', 'i2', 2),
('bc3', 'b2', 'bill2', '2021-10-15 13:00:00', 'i3', 4),
('bc4', 'b2', 'bill2', '2021-10-15 13:00:00', 'i4', 3),

-- November bills
('bc5', 'b3', 'bill3', '2021-11-10 10:30:00', 'i1', 10),
('bc6', 'b3', 'bill3', '2021-11-10 10:30:00', 'i5', 2),
('bc7', 'b4', 'bill4', '2021-11-20 15:00:00', 'i2', 6),
('bc8', 'b4', 'bill4', '2021-11-20 15:00:00', 'i3', 1),

-- December bills
('bc9', 'b5', 'bill5', '2021-12-01 19:00:00', 'i4', 5),
('bc10', 'b5', 'bill5', '2021-12-01 19:00:00', 'i5', 3);