DROP DATABASE IF EXISTS asbedDatabase;
CREATE DATABASE IF NOT EXISTS asbedDatabase;
USE asbedDatabase;


-- Rooms Table
CREATE TABLE IF NOT EXISTS Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    location ENUM('Oteng Korankye II Hall', 'Efua Sutherland', 'Ephraim Amu', 'Walter Sisulu', 'Wangari Maathai', 'Hall 2C', 'Kofi Tawiah','Hall 2D') NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);

-- Roles Table
CREATE TABLE IF NOT EXISTS Roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);


-- Users Table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL unique,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Bookings Table
CREATE TABLE IF NOT EXISTS Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    room_id INT,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Schedule Table
CREATE TABLE IF NOT EXISTS Schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT,
    start_time DATETIME,
    end_time DATETIME,
    is_booked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);


CREATE TABLE Announcements (
    announcement_id INT PRIMARY KEY,
    manager_id INT,
    announcement_text TEXT,
    date_posted DATE,
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id) -- All administrators are managers, but not all managers are administrators --
);

-- Requesting from Students --
CREATE TABLE IF NOT EXISTS Requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    request_text TEXT,
    request_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_resolved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (student_id) REFERENCES Users(user_id)
);

-- Add an Administrator-- 
CREATE TABLE IF NOT EXISTS Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Add a Manager-- 
CREATE TABLE IF NOT EXISTS Manager (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Verifiable ID --
CREATE TABLE IF NOT EXISTS VerifiablePins (
    pin_id INT AUTO_INCREMENT PRIMARY KEY,
    pin VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Inserting sample roles-- 
INSERT INTO Roles (role_name) VALUES ('Admin'), ('Manager'), ('Student');


-- Inserting sample rooms
INSERT INTO Rooms (room_name, capacity, location, is_available) VALUES
    ('Lion Hall', 50, 'Efua Sutherland', TRUE);

    
-- Inserting sample users
INSERT INTO Users (username, password, email, role_id) VALUES
    ('admin123', 'adminpassword', 'admin@example.com', 1),  -- Admin
    ('teacher456', 'teacherpassword', 'teacher@example.com', 2),  -- Teacher
    ('student789', 'studentpassword', 'student@example.com', 3);  -- Student
