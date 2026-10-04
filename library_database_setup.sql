-- Create Database
DROP DATABASE IF EXISTS library_management;
CREATE DATABASE library_management;
USE library_management;

-- Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20),
    category_id INT,
    total_copies INT,
    available_copies INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Book Authors Junction Table
CREATE TABLE Book_Authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Members Table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150),
    membership_status VARCHAR(50)
);

-- Staff Table
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    position VARCHAR(100)
);

-- Loaned Books Table
CREATE TABLE Loaned_Books (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    staff_id INT,
    loan_date DATE,
    due_date DATE,
    return_date DATE,
    fine_amount DECIMAL(5,2),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- Insert Categories
INSERT INTO Categories (category_name) VALUES
('Fiction'),
('Science'),
('Technology'),
('History'),
('Biography');

-- Insert Authors
INSERT INTO Authors (first_name, last_name) VALUES
('George','Orwell'),
('J.K.','Rowling'),
('Stephen','Hawking'),
('Walter','Isaacson'),
('Yuval','Harari');

-- Insert Books
INSERT INTO Books (title, isbn, category_id, total_copies, available_copies) VALUES
('1984','9780451524935',1,10,7),
('Harry Potter and the Sorcerer''s Stone','9780590353427',1,12,9),
('A Brief History of Time','9780553380163',2,8,6),
('Steve Jobs','9781451648539',5,6,5),
('Sapiens: A Brief History of Humankind','9780062316097',4,9,7);

-- Insert Book Authors
INSERT INTO Book_Authors VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

-- Insert Members
INSERT INTO Members (first_name,last_name,email,membership_status) VALUES
('John','Smith','johnsmith@email.com','Active'),
('Emily','Davis','emilyd@email.com','Active'),
('Michael','Brown','mbrown@email.com','Active'),
('Sarah','Johnson','sjohnson@email.com','Inactive'),
('David','Wilson','dwilson@email.com','Active');

-- Insert Staff
INSERT INTO Staff (first_name,last_name,position) VALUES
('Laura','Martinez','Librarian'),
('Kevin','Taylor','Assistant Librarian'),
('Angela','White','Library Technician');

-- Insert Loan Records
INSERT INTO Loaned_Books (book_id,member_id,staff_id,loan_date,due_date,return_date,fine_amount) VALUES
(1,1,1,'2026-04-01','2026-04-15',NULL,0),
(2,2,2,'2026-04-02','2026-04-16',NULL,0),
(3,3,1,'2026-04-03','2026-04-17',NULL,0),
(4,1,3,'2026-04-05','2026-04-19','2026-04-18',0),
(5,5,2,'2026-04-06','2026-04-20',NULL,0);

-- Relationship Verification Test
SELECT b.title, m.first_name, m.last_name, l.loan_date, l.due_date
FROM Loaned_Books l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id;