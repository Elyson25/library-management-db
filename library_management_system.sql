-- Library Management System SQL Script
-- Author: [Eliud Ndiege] --
-- Description: SQL script to create a relational database for a Library Management System --

-- Database: library_management --
CREATE DATABASE IF NOT EXISTS library_management;
USE library_management;

-- Table: members --
-- Description: Stores information about library members --
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15)
);

-- Table for authors --
-- Description: Stores information about book authors --
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
);

-- Table for books --
-- Description: Stores book details --
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publisher VARCHAR(100),
    publication_year INT,
    total_copies INT NOT NULL,
    available_copies INT NOT NULL
);

-- Juntion Table: book_authors (M-M relationship between books and authors) --
-- Description: Associates books with authors --
CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY(book_id, author_id),
    FOREIGN KEY(book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY(author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Table for borrowals --
-- Description: Tracks book borrowings by members --
CREATE TABLE borrowals (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY(member_id) REFERENCES members(member_id),
    FOREIGN KEY(book_id) REFERENCES books(book_id)
);

-- Table for staff --
-- Description: Staff users managing the library system --
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'librarian') DEFAULT 'librarian'
);
