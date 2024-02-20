DROP DATABASE IF EXISTS asbedDatabase;
CREATE DATABASE IF NOT EXISTS asbedDatabase;
USE asbedDatabase;


-- Rooms Table
CREATE TABLE IF NOT EXISTS Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    location ENUM('Odeefoo Oteng Korankye Hall', 'Efua Sutherland', 'Efram Amu', 'Walter Sisulu', 'Hall 2C', 'Kofi Tawiah','Hall K') NOT NULL,
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

CREATE TABLE Requests (
    request_id INT PRIMARY KEY,
    student_id INT,
    request_type VARCHAR(100),
    details TEXT,
    status VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

CREATE TABLE Announcements (
    announcement_id INT PRIMARY KEY,
    admin_id INT,
    announcement_text TEXT,
    date_posted DATE,
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
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

-- Announcement from the Managers -- 
CREATE TABLE IF NOT EXISTS Announcements (
    announcement_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    announcement_text TEXT,
    announcement_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id),
    CONSTRAINT Check_Sender_Role CHECK (
        (SELECT role_name FROM Roles WHERE role_id = (SELECT role_id FROM Users WHERE user_id = sender_id)) IN ('Admin', 'Manager')
    ),
    CONSTRAINT Check_Receiver_Role CHECK (
        (SELECT role_name FROM Roles WHERE role_id = (SELECT role_id FROM Users WHERE user_id = receiver_id)) = 'Student'
    )
);

-- Inserting sample roles
INSERT INTO Roles (role_name) VALUES ('Admin'), ('Manager'), ('Student');


-- Inserting sample rooms
INSERT INTO Rooms (room_name, capacity, location, is_available) VALUES
    ('Lion Hall', 50, 'Main Building', TRUE),
    ('Elephant Hall', 40, 'East Wing', TRUE),
    ('Zebra Hall', 30, 'West Wing', TRUE),
    ('Giraffe Hall', 60, 'North Wing', TRUE),
    ('Rhino Hall', 70, 'South Wing', TRUE);
    
-- Inserting sample users
INSERT INTO Users (username, password, email, role_id) VALUES
    ('admin123', 'adminpassword', 'admin@example.com', 1),  -- Admin
    ('teacher456', 'teacherpassword', 'teacher@example.com', 2),  -- Teacher
    ('student789', 'studentpassword', 'student@example.com', 3);  -- Student
