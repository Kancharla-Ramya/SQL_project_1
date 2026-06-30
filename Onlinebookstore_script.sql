CREATE DATABASE IF NOT EXISTS OnlineBookStore;
USE OnlineBookStore;

-- ============================================
-- TABLE CREATION
-- ============================================

CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    bio TEXT,
    country VARCHAR(50)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    website VARCHAR(100)
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    category_id INT,
    publisher_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    published_date DATE,
    isbn VARCHAR(20) UNIQUE,
    language VARCHAR(30) DEFAULT 'English',
    pages INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    city VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status ENUM('Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    payment_method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Cash on Delivery'),
    payment_status ENUM('Success', 'Failed', 'Pending') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- ============================================
-- INSERT DATA -- AUTHORS (20 records)
-- ============================================

INSERT INTO Authors (first_name, last_name, bio, country) VALUES
('Chetan', 'Bhagat', 'Popular Indian author known for youth fiction.', 'India'),
('J.K.', 'Rowling', 'Author of the Harry Potter series.', 'UK'),
('George', 'Orwell', 'English novelist and essayist.', 'UK'),
('R.K.', 'Narayan', 'Indian author known for Malgudi Days.', 'India'),
('Amish', 'Tripathi', 'Author of mythological fiction.', 'India'),
('Paulo', 'Coelho', 'Brazilian author of The Alchemist.', 'Brazil'),
('Dan', 'Brown', 'American author known for thriller novels.', 'USA'),
('Arundhati', 'Roy', 'Indian author and activist.', 'India'),
('Ruskin', 'Bond', 'Beloved Indian author of nature stories.', 'India'),
('Stephen', 'King', 'Master of horror and suspense fiction.', 'USA'),
('Agatha', 'Christie', 'Queen of crime fiction.', 'UK'),
('Sudha', 'Murty', 'Indian author and philanthropist.', 'India'),
('Vikram', 'Seth', 'Indian poet and novelist.', 'India'),
('Mark', 'Twain', 'American author and humorist.', 'USA'),
('Leo', 'Tolstoy', 'Russian novelist known for War and Peace.', 'Russia'),
('Rabindranath', 'Tagore', 'Nobel Prize winning Indian author.', 'India'),
('Khaled', 'Hosseini', 'Afghan-American author of The Kite Runner.', 'Afghanistan'),
('Yuval', 'Harari', 'Israeli historian and author of Sapiens.', 'Israel'),
('Malcolm', 'Gladwell', 'Canadian journalist and author.', 'Canada'),
('Devdutt', 'Pattanaik', 'Indian mythologist and author.', 'India');

-- ============================================
-- INSERT DATA -- CATEGORIES (10 records)
-- ============================================

INSERT INTO Categories (category_name, description) VALUES
('Fiction', 'Fictional stories and novels'),
('Self-Help', 'Books for personal development'),
('Science Fiction', 'Futuristic and science-based fiction'),
('Mystery', 'Thriller and mystery novels'),
('Mythology', 'Books based on myths and legends'),
('Biography', 'Life stories of real people'),
('History', 'Historical events and analysis'),
('Romance', 'Love and relationship stories'),
('Horror', 'Scary and suspenseful fiction'),
('Children', 'Books for young readers');

-- ============================================
-- INSERT DATA -- PUBLISHERS (10 records)
-- ============================================

INSERT INTO Publishers (publisher_name, country, website) VALUES
('Penguin Books', 'UK', 'www.penguin.com'),
('Harper Collins', 'USA', 'www.harpercollins.com'),
('Rupa Publications', 'India', 'www.rupapublications.com'),
('Westland Books', 'India', 'www.westlandbooks.in'),
('Bloomsbury', 'UK', 'www.bloomsbury.com'),
('Random House', 'USA', 'www.randomhouse.com'),
('Oxford University Press', 'UK', 'www.oup.com'),
('Simon & Schuster', 'USA', 'www.simonandschuster.com'),
('Hachette India', 'India', 'www.hachetteindia.com'),
('Scholastic', 'USA', 'www.scholastic.com');

-- ============================================
-- INSERT DATA -- BOOKS (30 records)
-- ============================================

INSERT INTO Books (title, author_id, category_id, publisher_id, price, stock_quantity, published_date, isbn, language, pages) VALUES
('Five Point Someone', 1, 1, 3, 199.00, 50, '2004-10-01', '9788129104960', 'English', 248),
('Harry Potter and the Sorcerers Stone', 2, 1, 5, 499.00, 30, '1997-06-26', '9780439708180', 'English', 309),
('1984', 3, 3, 1, 299.00, 40, '1949-06-08', '9780451524935', 'English', 328),
('Malgudi Days', 4, 1, 2, 249.00, 25, '1943-01-01', '9780143065166', 'English', 270),
('The Immortals of Meluha', 5, 5, 4, 350.00, 60, '2010-02-01', '9789380658742', 'English', 412),
('The Alchemist', 6, 2, 6, 299.00, 55, '1988-01-01', '9780062315007', 'English', 208),
('The Da Vinci Code', 7, 4, 8, 399.00, 35, '2003-03-18', '9780385504201', 'English', 454),
('The God of Small Things', 8, 1, 1, 350.00, 20, '1997-04-04', '9780006550686', 'English', 321),
('The Blue Umbrella', 9, 10, 3, 149.00, 45, '1980-01-01', '9780143330912', 'English', 128),
('It', 10, 9, 6, 599.00, 15, '1986-09-15', '9781501156700', 'English', 1138),
('Murder on the Orient Express', 11, 4, 1, 249.00, 30, '1934-01-01', '9780007119318', 'English', 256),
('Wise and Otherwise', 12, 2, 3, 199.00, 50, '2002-01-01', '9780143028765', 'English', 220),
('A Suitable Boy', 13, 8, 1, 799.00, 10, '1993-01-01', '9780060786526', 'English', 1488),
('The Adventures of Tom Sawyer', 14, 10, 6, 179.00, 40, '1876-01-01', '9780486400778', 'English', 274),
('War and Peace', 15, 7, 7, 699.00, 12, '1869-01-01', '9780199232765', 'English', 1225),
('Gitanjali', 16, 1, 9, 199.00, 35, '1910-01-01', '9788172235185', 'English', 120),
('The Kite Runner', 17, 1, 2, 349.00, 28, '2003-05-29', '9781594631931', 'English', 371),
('Sapiens', 18, 7, 2, 499.00, 45, '2011-01-01', '9780062316097', 'English', 443),
('Outliers', 19, 2, 2, 399.00, 38, '2008-11-18', '9780316017923', 'English', 309),
('Jaya', 20, 5, 9, 299.00, 42, '2010-01-01', '9780143104254', 'English', 352),
('2 States', 1, 8, 3, 199.00, 55, '2009-10-01', '9788129115300', 'English', 272),
('Animal Farm', 3, 1, 1, 149.00, 60, '1945-08-17', '9780451526342', 'English', 112),
('Angels and Demons', 7, 4, 8, 350.00, 32, '2000-05-01', '9780671027360', 'English', 736),
('Swami and Friends', 4, 10, 2, 179.00, 48, '1935-01-01', '9780143330974', 'English', 224),
('The Secret of the Nagas', 5, 5, 4, 350.00, 50, '2011-08-01', '9789380658759', 'English', 370),
('Harry Potter and the Chamber of Secrets', 2, 1, 5, 499.00, 25, '1998-07-02', '9780439064873', 'English', 341),
('The Shining', 10, 9, 6, 449.00, 18, '1977-01-28', '9780307743657', 'English', 447),
('How the Mind Works', 19, 2, 8, 549.00, 22, '2008-01-01', '9780393334775', 'English', 660),
('Mythology', 20, 5, 9, 349.00, 33, '2015-01-01', '9788184957426', 'English', 320),
('Dollar Bahu', 12, 8, 3, 199.00, 44, '2000-01-01', '9788172236557', 'English', 196);

-- ============================================
-- INSERT DATA -- CUSTOMERS (30 records)
-- ============================================

INSERT INTO Customers (first_name, last_name, email, phone, address, city, country) VALUES
('Ravi', 'Kumar', 'ravi.kumar@gmail.com', '9876543210', '12 MG Road', 'Nellore', 'India'),
('Priya', 'Sharma', 'priya.sharma@gmail.com', '9988776655', '45 Banjara Hills', 'Hyderabad', 'India'),
('Arjun', 'Mehta', 'arjun.mehta@gmail.com', '9123456789', '78 Andheri', 'Mumbai', 'India'),
('Sneha', 'Reddy', 'sneha.reddy@gmail.com', '9000011111', '22 Koramangala', 'Bangalore', 'India'),
('Karan', 'Patel', 'karan.patel@gmail.com', '9555522222', '10 Connaught Place', 'Delhi', 'India'),
('Divya', 'Nair', 'divya.nair@gmail.com', '9444433333', '5 Anna Nagar', 'Chennai', 'India'),
('Rahul', 'Gupta', 'rahul.gupta@gmail.com', '9333344444', '88 Salt Lake', 'Kolkata', 'India'),
('Anjali', 'Singh', 'anjali.singh@gmail.com', '9222255555', '33 Civil Lines', 'Jaipur', 'India'),
('Vikram', 'Rao', 'vikram.rao@gmail.com', '9111166666', '77 Aundh', 'Pune', 'India'),
('Pooja', 'Mishra', 'pooja.mishra@gmail.com', '9000077777', '19 Hazratganj', 'Lucknow', 'India'),
('Suresh', 'Babu', 'suresh.babu@gmail.com', '9876512345', '41 Besant Nagar', 'Chennai', 'India'),
('Lakshmi', 'Iyengar', 'lakshmi.iyengar@gmail.com', '9865412378', '14 Jayanagar', 'Bangalore', 'India'),
('Mohit', 'Joshi', 'mohit.joshi@gmail.com', '9754123698', '66 Sector 18', 'Noida', 'India'),
('Neha', 'Verma', 'neha.verma@gmail.com', '9632587410', '29 Alkapuri', 'Vadodara', 'India'),
('Aditya', 'Chauhan', 'aditya.chauhan@gmail.com', '9521478630', '52 Kothrud', 'Pune', 'India'),
('Sunita', 'Pillai', 'sunita.pillai@gmail.com', '9410258630', '8 Vyttila', 'Kochi', 'India'),
('Harish', 'Menon', 'harish.menon@gmail.com', '9300147852', '37 Calicut Road', 'Kozhikode', 'India'),
('Kavya', 'Krishnan', 'kavya.krishnan@gmail.com', '9258741036', '11 Thiruvanmiyur', 'Chennai', 'India'),
('Rohit', 'Saxena', 'rohit.saxena@gmail.com', '9147852036', '64 Gomti Nagar', 'Lucknow', 'India'),
('Meena', 'Agarwal', 'meena.agarwal@gmail.com', '9036985214', '23 Mansarovar', 'Jaipur', 'India'),
('Deepak', 'Tiwari', 'deepak.tiwari@gmail.com', '8965214703', '55 Boring Road', 'Patna', 'India'),
('Ananya', 'Das', 'ananya.das@gmail.com', '8854123697', '72 Lake Town', 'Kolkata', 'India'),
('Sanjay', 'Kulkarni', 'sanjay.kulkarni@gmail.com', '8741236985', '18 Deccan', 'Pune', 'India'),
('Rekha', 'Jain', 'rekha.jain@gmail.com', '8630147852', '43 Lal Darwaja', 'Surat', 'India'),
('Naveen', 'Yadav', 'naveen.yadav@gmail.com', '8521478963', '31 Sitapur Road', 'Lucknow', 'India'),
('Geetha', 'Subramanian', 'geetha.sub@gmail.com', '8410369852', '9 T Nagar', 'Chennai', 'India'),
('Prasad', 'Venkatesh', 'prasad.vk@gmail.com', '8369258741', '26 Dilsukhnagar', 'Hyderabad', 'India'),
('Swathi', 'Naidu', 'swathi.naidu@gmail.com', '8258147036', '47 One Town', 'Nellore', 'India'),
('Manoj', 'Pandey', 'manoj.pandey@gmail.com', '8147036925', '83 Ashok Nagar', 'Bhopal', 'India'),
('Ramya', 'Iyer', 'ramya.iyer@gmail.com', '8036925814', '16 Adyar', 'Chennai', 'India');

-- ============================================
-- INSERT DATA -- ORDERS (30 records)
-- ============================================

INSERT INTO Orders (customer_id, total_amount, status, shipping_address) VALUES
(1, 698.00, 'Delivered', '12 MG Road, Nellore'),
(2, 499.00, 'Shipped', '45 Banjara Hills, Hyderabad'),
(3, 299.00, 'Confirmed', '78 Andheri, Mumbai'),
(4, 599.00, 'Pending', '22 Koramangala, Bangalore'),
(5, 350.00, 'Delivered', '10 Connaught Place, Delhi'),
(6, 448.00, 'Delivered', '5 Anna Nagar, Chennai'),
(7, 799.00, 'Shipped', '88 Salt Lake, Kolkata'),
(8, 249.00, 'Delivered', '33 Civil Lines, Jaipur'),
(9, 499.00, 'Cancelled', '77 Aundh, Pune'),
(10, 349.00, 'Delivered', '19 Hazratganj, Lucknow'),
(11, 199.00, 'Confirmed', '41 Besant Nagar, Chennai'),
(12, 699.00, 'Delivered', '14 Jayanagar, Bangalore'),
(13, 399.00, 'Shipped', '66 Sector 18, Noida'),
(14, 598.00, 'Delivered', '29 Alkapuri, Vadodara'),
(15, 149.00, 'Pending', '52 Kothrud, Pune'),
(16, 499.00, 'Delivered', '8 Vyttila, Kochi'),
(17, 350.00, 'Confirmed', '37 Calicut Road, Kozhikode'),
(18, 299.00, 'Delivered', '11 Thiruvanmiyur, Chennai'),
(19, 549.00, 'Shipped', '64 Gomti Nagar, Lucknow'),
(20, 199.00, 'Delivered', '23 Mansarovar, Jaipur'),
(21, 448.00, 'Cancelled', '55 Boring Road, Patna'),
(22, 350.00, 'Delivered', '72 Lake Town, Kolkata'),
(23, 599.00, 'Shipped', '18 Deccan, Pune'),
(24, 249.00, 'Delivered', '43 Lal Darwaja, Surat'),
(25, 399.00, 'Confirmed', '31 Sitapur Road, Lucknow'),
(26, 179.00, 'Delivered', '9 T Nagar, Chennai'),
(27, 698.00, 'Delivered', '26 Dilsukhnagar, Hyderabad'),
(28, 499.00, 'Shipped', '47 One Town, Nellore'),
(29, 299.00, 'Delivered', '83 Ashok Nagar, Bhopal'),
(30, 349.00, 'Delivered', '16 Adyar, Chennai');

-- ============================================
-- INSERT DATA -- ORDER ITEMS (40 records)
-- ============================================

INSERT INTO Order_Items (order_id, book_id, quantity, unit_price) VALUES
(1, 1, 2, 199.00),
(1, 5, 1, 300.00),
(2, 2, 1, 499.00),
(3, 3, 1, 299.00),
(4, 4, 1, 249.00),
(4, 21, 1, 199.00),
(5, 5, 1, 350.00),
(6, 6, 1, 299.00),
(6, 9, 1, 149.00),
(7, 13, 1, 799.00),
(8, 11, 1, 249.00),
(9, 18, 1, 499.00),
(10, 17, 1, 349.00),
(11, 12, 1, 199.00),
(12, 15, 1, 699.00),
(13, 19, 1, 399.00),
(14, 1, 1, 199.00),
(14, 22, 1, 149.00),
(14, 25, 1, 350.00),
(15, 9, 1, 149.00),
(16, 2, 1, 499.00),
(17, 5, 1, 350.00),
(18, 3, 1, 299.00),
(19, 28, 1, 549.00),
(20, 21, 1, 199.00),
(21, 6, 1, 299.00),
(21, 9, 1, 149.00),
(22, 25, 1, 350.00),
(23, 10, 1, 599.00),
(24, 11, 1, 249.00),
(25, 19, 1, 399.00),
(26, 14, 1, 179.00),
(27, 1, 2, 199.00),
(27, 16, 1, 199.00),
(27, 21, 1, 199.00),
(28, 2, 1, 499.00),
(29, 3, 1, 299.00),
(30, 17, 1, 349.00),
(6, 12, 1, 199.00),
(13, 7, 1, 399.00);

-- ============================================
-- INSERT DATA -- REVIEWS (30 records)
-- ============================================

INSERT INTO Reviews (book_id, customer_id, rating, review_text) VALUES
(1, 1, 5, 'Amazing book! Loved the college life story.'),
(2, 2, 5, 'A magical experience. Must read!'),
(3, 3, 4, 'A thought-provoking classic.'),
(4, 4, 4, 'Simple yet beautiful storytelling.'),
(5, 5, 5, 'Brilliant mythological fiction!'),
(6, 6, 5, 'Life changing book. Highly recommended.'),
(7, 7, 4, 'Gripping thriller from start to finish.'),
(8, 8, 5, 'Beautifully written. Emotional and deep.'),
(9, 9, 4, 'Sweet and charming children story.'),
(10, 10, 3, 'Very scary but well written.'),
(11, 11, 5, 'Classic mystery. Agatha Christie at her best!'),
(12, 12, 4, 'Warm and inspiring stories.'),
(13, 13, 5, 'A masterpiece of Indian literature.'),
(14, 14, 4, 'Timeless adventure for all ages.'),
(15, 15, 5, 'Epic in every sense of the word.'),
(16, 16, 5, 'Poetic and spiritual. Deeply moving.'),
(17, 17, 5, 'Heart wrenching and beautiful.'),
(18, 18, 5, 'Changed my perspective on humanity.'),
(19, 19, 4, 'Eye opening read about success.'),
(20, 20, 4, 'Great retelling of the Mahabharata.'),
(21, 21, 4, 'Funny and relatable love story.'),
(22, 22, 4, 'Short but powerful. Great political satire.'),
(23, 23, 4, 'Fast paced and entertaining thriller.'),
(24, 24, 5, 'A nostalgic and delightful read.'),
(25, 25, 5, 'Even better than the first book!'),
(26, 26, 5, 'Just as magical as the first one.'),
(27, 27, 3, 'Scary but a bit slow at times.'),
(28, 28, 4, 'Fascinating insights into human behavior.'),
(29, 29, 4, 'Great introduction to Indian mythology.'),
(30, 30, 4, 'Simple and touching love story.');

-- ============================================
-- INSERT DATA -- PAYMENTS (30 records)
-- ============================================

INSERT INTO Payments (order_id, amount, payment_method, payment_status) VALUES
(1, 698.00, 'UPI', 'Success'),
(2, 499.00, 'Credit Card', 'Success'),
(3, 299.00, 'Net Banking', 'Success'),
(4, 599.00, 'Cash on Delivery', 'Pending'),
(5, 350.00, 'Debit Card', 'Success'),
(6, 448.00, 'UPI', 'Success'),
(7, 799.00, 'Credit Card', 'Success'),
(8, 249.00, 'UPI', 'Success'),
(9, 499.00, 'Debit Card', 'Failed'),
(10, 349.00, 'Net Banking', 'Success'),
(11, 199.00, 'UPI', 'Success'),
(12, 699.00, 'Credit Card', 'Success'),
(13, 399.00, 'Net Banking', 'Success'),
(14, 598.00, 'UPI', 'Success'),
(15, 149.00, 'Cash on Delivery', 'Pending'),
(16, 499.00, 'Credit Card', 'Success'),
(17, 350.00, 'UPI', 'Success'),
(18, 299.00, 'Debit Card', 'Success'),
(19, 549.00, 'Net Banking', 'Success'),
(20, 199.00, 'UPI', 'Success'),
(21, 448.00, 'Credit Card', 'Failed'),
(22, 350.00, 'UPI', 'Success'),
(23, 599.00, 'Debit Card', 'Success'),
(24, 249.00, 'Net Banking', 'Success'),
(25, 399.00, 'Cash on Delivery', 'Pending'),
(26, 179.00, 'UPI', 'Success'),
(27, 698.00, 'Credit Card', 'Success'),
(28, 499.00, 'Net Banking', 'Success'),
(29, 299.00, 'UPI', 'Success'),
(30, 349.00, 'Debit Card', 'Success');

use onlinebookstore;
show databases;
show tables;
select * from authors;
select * from books;
select * from customers;
select * from payments;
select * from reviews;
select * from publishers;
select * from orders;
select * from order_items;
select * from categories;
-- ============================================
-- ONLINE BOOKSTORE - BASIC DQL QUERIES
-- ============================================

USE OnlineBookStore;

-- 1. SELECT Q1: Display all books

SELECT * FROM Books;

-- Q2: Display book title and price only
SELECT title, price FROM Books;

-- ============================================
-- 2. WHERE CLAUSE
-- ============================================
-- Q3: Display all customers' names and emails from India
SELECT first_name, last_name, email,country FROM Customers
WHERE country='India';  

-- Q4: Find books with price greater than 300 and language is English, logical operator "AND" is used
SELECT * FROM Books
WHERE price > 300 AND language= "English";

-- Q5: Find customers from 'Nellore' , 'hyderabad'
SELECT * FROM Customers
WHERE city = 'Nellore' OR city = "Hyderabad";

-- Q6: Find orders with status 'Delivered'
SELECT * FROM Orders
WHERE status = 'Delivered';


-- ============================================
-- 3. LIKE OPERATOR
-- ============================================

-- Q7: Find books whose title starts with 'The'
SELECT * FROM Books
WHERE title LIKE 'The%';

-- Q8: Find authors whose first name contains 'an'
SELECT * FROM Authors
WHERE first_name LIKE '%an%';

-- Q9: Find customers whose email ends with 'gmail.com'
SELECT * FROM Customers
WHERE email LIKE '%gmail.com';


-- ============================================
-- 4. LIST OPERATOR (IN)
-- ============================================

-- Q10: Find books in categories 1, 2, and 3
SELECT * FROM Books
WHERE category_id IN (1, 2, 3);

-- Q11: Find orders with status either 'Pending' or 'Cancelled'
SELECT * FROM Orders
WHERE status IN ('Pending', 'Cancelled');

-- Q12: Find customers from Chennai or Bangalore
SELECT * FROM Customers
WHERE city IN ('Chennai', 'Bangalore');


-- ============================================
-- 5. NULLABLE OPERATOR
-- ============================================

-- Q13: Find books where publisher is not assigned
SELECT * FROM Books
WHERE publisher_id IS NULL;

-- Q14: Find customers with phone number available
SELECT * FROM Customers
WHERE phone IS NOT NULL;

-- Q15: Find reviews where review text is missing
SELECT * FROM Reviews
WHERE review_text IS NULL;


-- ============================================
-- 6. STRING FUNCTIONS
-- ============================================

-- Q16: Display full name of customers
SELECT CONCAT(first_name, ' ', last_name) AS Full_name, city
FROM Customers;

-- Q17: Convert book titles to uppercase
SELECT UPPER(title) FROM Books;

-- Q18: Find length of each book title
SELECT title, LENGTH(title) AS title_length
FROM Books;

-- Q19: Display first 5 characters of book title
SELECT first_name,last_name,
SUBSTR(country, 1, 2) as Country_code FROM authors;


-- ============================================
-- 7. DATE FUNCTIONS
-- ============================================

-- Q20: Display current date
SELECT CURRENT_DATE();

-- Q21: Find orders placed today
SELECT * FROM Orders
WHERE DATE(order_date) = CURRENT_DATE();

-- Q22: Find customers registered in the current year
SELECT * FROM Customers
WHERE month(registration_date) = month(CURRENT_DATE());

-- Q23: Extract year from book published date
SELECT title, YEAR(published_date) AS published_year
FROM Books;

-- Q24: Find books published after 2000
SELECT * FROM Books
WHERE YEAR(published_date) > 2000;








-- ============================================
-- ONLINE BOOK STORE - JOIN QUERIES FILE
-- ============================================

-- ============================================
-- 1. INNER JOIN (2 TABLES)
-- ============================================

-- Q1: Get all books with their author names
SELECT b.title as Title, a.first_name, a.last_name
FROM books b
INNER JOIN Authors a ON b.author_id = a.author_id;

-- Q2: Show customers and their orders
SELECT c.first_name, c.last_name, o.order_id, o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- Q3: Display books with category name
SELECT b.title, c.category_name
FROM Books b
JOIN Categories c ON b.category_id = c.category_id;

-- ============================================
-- 2. INNER JOIN (3+ TABLES)
-- ============================================

-- Q4: Show order details (customer name, book title, quantity)
SELECT c.first_name, b.title, oi.quantity
FROM Customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_Items oi ON o.order_id = oi.order_id
INNER JOIN books b ON oi.book_id = b.book_id;

-- Q5: Complete order summary with payment status
SELECT o.order_id, concat(c.first_name,c.last_name) as full_name,
 o.total_amount, p.payment_status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN payments p ON o.order_id = p.order_id;

-- Q6: Show book details (author, category, publisher)
SELECT b.title, a.first_name, c.category_name, p.publisher_name
FROM Books b
INNER JOIN Authors a ON b.author_id = a.author_id
INNER JOIN Categories c ON b.category_id = c.category_id
INNER JOIN Publishers p ON b.publisher_id = p.publisher_id;

-- ============================================
-- 3. BRIDGE TABLE (Order_Items)
-- ============================================

-- Q7: Find all books in order_id = 1
SELECT o.order_id, b.title, oi.quantity
FROM Orders o
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Books b ON oi.book_id = b.book_id
WHERE o.order_id = 1;


-- ============================================
-- 4. LEFT JOIN
-- ============================================

-- Q8: Show all customers with or without orders
SELECT c.first_name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- Q9: Show all books with reviews (including no reviews)
SELECT b.title, r.rating
FROM Books b
LEFT JOIN Reviews r ON b.book_id = r.book_id;


-- ============================================
-- 5. RIGHT JOIN
-- ============================================

-- Q10: Show all payments with their orders
SELECT o.order_id, p.payment_status
FROM Orders o
RIGHT JOIN Payments p ON o.order_id = p.order_id;

-- Q11: Show all books and order items (include books not ordered)
SELECT b.title, oi.quantity
FROM Order_Items oi
RIGHT JOIN Books b ON oi.book_id = b.book_id;

-- ============================================
-- 6. ORDER BY
-- ============================================

-- Q12: Get books sorted by price (ascending)
SELECT title, price
FROM Books
ORDER BY price ASC;

-- Q13: Get customers sorted by name (descending)
SELECT first_name, last_name
FROM Customers
ORDER BY first_name DESC;

-- ============================================
-- 7. LIMIT
-- ============================================

-- Q14: Get top 5 most expensive books
SELECT title, price
FROM Books
ORDER BY price DESC
LIMIT 5;

-- Q15: Get first 3 customers
SELECT *
FROM Customers
LIMIT 3;

-- ============================================
-- 8. JOIN + ORDER BY
-- ============================================

-- Q16: Show orders sorted by total amount
SELECT c.first_name, o.order_id, o.total_amount
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY o.total_amount DESC
limit 5;

-- Q17: Show books with authors sorted by book title
SELECT b.title, a.first_name
FROM Books b
INNER JOIN Authors a ON b.author_id = a.author_id
ORDER BY b.title;


-- Q23: Find customers who never placed an order
SELECT c.first_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q18: Find books that were never ordered
-- In joins we are using where clause
SELECT b.title
FROM Books b
LEFT JOIN Order_Items oi ON b.book_id = oi.book_id
WHERE oi.book_id IS NULL;

-- Q19: Find orders with failed payments
SELECT o.order_id, p.payment_status
FROM Orders o
INNER JOIN Payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Failed';


-- =====================================================
-- ONLINE BOOK STORE - DATA ANALYTICS QUERIES
-- =====================================================

-- =====================================================
-- 1. REVENUE INSIGHTS
-- =====================================================

-- Q1: Total revenue generated from all orders
SELECT SUM(total_amount) AS total_revenue
FROM Orders;

-- Q2: Total revenue from successful payments
SELECT SUM(amount) AS successful_revenue
FROM Payments
WHERE payment_status = 'Success';

-- Q3: Total number of payments done
SELECT COUNT(*) AS total_payments
FROM Payments;

-- Q4: Number of successful, failed, and pending payments
SELECT payment_status, COUNT(*) AS count_status
FROM Payments
GROUP BY payment_status;

-- Q5: Total revenue loss due to failed payments
SELECT SUM(amount) AS failed_revenue
FROM Payments
WHERE payment_status = 'Failed';

-- Q6: Average order value
SELECT AVG(total_amount) AS avg_order_value
FROM Orders;

-- =====================================================
-- 2. CUSTOMER & BUYING BEHAVIOR
-- =====================================================

-- Q7: Total money spent by each customer
SELECT c.customer_id, c.first_name,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- Q8: Number of orders per customer
SELECT c.customer_id, c.first_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC;

-- Q9: Customers who placed more than 2 orders
SELECT c.first_name, COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING order_count > 2;

-- Q10: Top 5 customers based on spending
SELECT c.first_name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- =====================================================
-- 3. BOOK SALES INSIGHTS
-- =====================================================

-- Q11: Total quantity sold per book
SELECT b.title, SUM(oi.quantity) AS total_sold
FROM Books b
JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY b.book_id
ORDER BY total_sold DESC;

-- Q12: Book with highest sales
SELECT b.title, SUM(oi.quantity) AS total_sold
FROM Books b
JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY b.book_id
ORDER BY total_sold DESC
LIMIT 1;

-- Q13: Total revenue generated per book
SELECT b.title, SUM(oi.quantity * oi.unit_price) AS revenue
FROM Books b
JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY b.book_id
ORDER BY revenue DESC;

-- Q14: Highest and lowest priced books
SELECT MAX(price) AS highest_price,
       MIN(price) AS lowest_price
FROM Books;

-- =====================================================
-- 4. AUTHOR REVENUE & SALES ANALYSIS
-- =====================================================

-- Q15: Total revenue generated by each author
SELECT a.author_id, a.first_name,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Authors a
JOIN Books b ON a.author_id = b.author_id
JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY a.author_id
ORDER BY total_revenue DESC;

-- Q16: Authors with least revenue
SELECT a.first_name,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Authors a
JOIN Books b ON a.author_id = b.author_id
JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY a.author_id
ORDER BY total_revenue ASC
LIMIT 5;

-- Q17: Authors with high quantity sales but low revenue (low price books)
SELECT a.first_name,
       SUM(oi.quantity) AS total_quantity,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Authors a
JOIN Books b ON a.author_id = b.author_id
JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY a.author_id
HAVING total_quantity > 5 AND total_revenue < 1000;

-- =====================================================
-- 5. AUTHOR ORDERS + CATEGORY ANALYSIS
-- =====================================================

-- Q18: Authors who have more than 5 orders
SELECT a.first_name,
       COUNT(DISTINCT o.order_id) AS total_orders
FROM Authors a
JOIN Books b ON a.author_id = b.author_id
JOIN Order_Items oi ON b.book_id = oi.book_id
JOIN Orders o ON oi.order_id = o.order_id
GROUP BY a.author_id
HAVING total_orders > 5;

-- Q19: Authors with more than 5 orders including book category
SELECT a.first_name, c.category_name,
       COUNT(DISTINCT o.order_id) AS total_orders
FROM Authors a
JOIN Books b ON a.author_id = b.author_id
JOIN Categories c ON b.category_id = c.category_id
JOIN Order_Items oi ON b.book_id = oi.book_id
JOIN Orders o ON oi.order_id = o.order_id
GROUP BY a.author_id, c.category_id
HAVING total_orders > 5;

-- =====================================================
-- 6. COMPREHENSIVE ANALYTICS (MIXED)
-- =====================================================

-- Q20: Total payments, pending payments, and successful revenue
SELECT 
    COUNT(*) AS total_payments,
    SUM(CASE WHEN payment_status = 'Pending' THEN 1 ELSE 0 END) AS pending_payments,
    SUM(CASE WHEN payment_status = 'Success' THEN amount ELSE 0 END) AS total_revenue
FROM Payments;

-- Q21: Category-wise revenue
SELECT c.category_name,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM Categories c
JOIN Books b ON c.category_id = b.category_id
JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY c.category_id
ORDER BY revenue DESC;

-- Q22: Monthly revenue
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(total_amount) AS revenue
FROM Orders
GROUP BY month
ORDER BY month;

-- Q23: Average number of books per order
SELECT AVG(total_books) AS avg_books_per_order
FROM (
    SELECT order_id, SUM(quantity) AS total_books
    FROM Order_Items
    GROUP BY order_id
) AS subquery;

-- =====================================================
-- END OF FILE
-- =====================================================

-- =====================================================
-- 1. SCALAR SUBQUERIES (Single Value)
-- =====================================================

-- Q1: Find books that cost more than average book price
SELECT title, price
FROM Books
WHERE price > (SELECT AVG(price) FROM Books);

-- -----------------------------------------------------

-- Q2: Find books that cost less than average price
SELECT title, price
FROM Books
WHERE price < (SELECT AVG(price) FROM Books);

-- -----------------------------------------------------

-- Q3: Find the most expensive book details
SELECT *
FROM Books
WHERE price = (SELECT MAX(price) FROM Books);

-- -----------------------------------------------------

-- Q4: Find the cheapest book details
SELECT *
FROM Books
WHERE price = (SELECT MIN(price) FROM Books);

-- -----------------------------------------------------

-- Q5: Find orders with amount greater than average order value
SELECT *
FROM Orders
WHERE total_amount > (SELECT AVG(total_amount) FROM Orders);

-- -----------------------------------------------------

-- Q6: Find customers who spent more than average spending
SELECT c.first_name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING total_spent > (
    SELECT AVG(total_amount) FROM Orders
);

-- =====================================================
-- 2. TABULAR SUBQUERIES (Multiple Rows)
-- =====================================================

-- Q7: Find books that belong to 'Fiction' category
SELECT title
FROM Books
WHERE category_id IN (
    SELECT category_id
    FROM Categories
    WHERE category_name = 'Fiction'
);

-- -----------------------------------------------------

-- Q8: Find customers who placed orders
SELECT first_name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id FROM Orders
);

-- -----------------------------------------------------

-- Q9: Find books that were ordered
SELECT title
FROM Books
WHERE book_id IN (
    SELECT book_id FROM Order_Items
);

-- -----------------------------------------------------

-- Q10: Find books that were never ordered
SELECT title
FROM Books
WHERE book_id NOT IN (
    SELECT book_id FROM Order_Items
);

-- -----------------------------------------------------

-- Q11: Find authors who have written books in 'Mythology'
SELECT first_name
FROM Authors
WHERE author_id IN (
    SELECT author_id
    FROM Books
    WHERE category_id IN (
        SELECT category_id
        FROM Categories
        WHERE category_name = 'Mythology'
    )
);

-- =====================================================
-- 3. CORRELATED SUBQUERIES
-- =====================================================

-- Q12: Find books that have price greater than average price in their category
SELECT b.title, b.price
FROM Books b
WHERE b.price > (
    SELECT AVG(price)
    FROM Books
    WHERE category_id = b.category_id
);

-- -----------------------------------------------------

-- Q13: Find customers who made more orders than average orders per customer
SELECT c.first_name
FROM Customers c
WHERE (
    SELECT COUNT(*)
    FROM Orders o
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM Orders
        GROUP BY customer_id
    ) AS temp
);

-- -----------------------------------------------------

-- Q14: Find books that sold more than average quantity
SELECT b.title
FROM Books b
WHERE (
    SELECT SUM(oi.quantity)
    FROM Order_Items oi
    WHERE oi.book_id = b.book_id
) > (
    SELECT AVG(quantity) FROM Order_Items
);

-- -----------------------------------------------------

-- Q15: Find authors whose books generated more revenue than average author revenue
SELECT a.first_name
FROM Authors a
WHERE (
    SELECT SUM(oi.quantity * oi.unit_price)
    FROM Books b
    JOIN Order_Items oi ON b.book_id = oi.book_id
    WHERE b.author_id = a.author_id
) > (
    SELECT AVG(author_revenue)
    FROM (
        SELECT SUM(oi.quantity * oi.unit_price) AS author_revenue
        FROM Books b
        JOIN Order_Items oi ON b.book_id = oi.book_id
        GROUP BY b.author_id
    ) AS temp
);

-- =====================================================
-- 4. ADVANCED SUBQUERY + AGGREGATE QUESTIONS
-- =====================================================

-- Q16: Count of customers for each author (who bought their books)
SELECT a.first_name,
       COUNT(DISTINCT o.customer_id) AS total_customers
FROM Authors a
JOIN Books b ON a.author_id = b.author_id
JOIN Order_Items oi ON b.book_id = oi.book_id
JOIN Orders o ON oi.order_id = o.order_id
GROUP BY a.author_id;

-- -----------------------------------------------------

-- Q17: Find authors whose books are purchased by more than 3 customers
SELECT a.first_name
FROM Authors a
WHERE a.author_id IN (
    SELECT b.author_id
    FROM Books b
    JOIN Order_Items oi ON b.book_id = oi.book_id
    JOIN Orders o ON oi.order_id = o.order_id
    GROUP BY b.author_id
    HAVING COUNT(DISTINCT o.customer_id) > 3
);

-- -----------------------------------------------------

-- Q18: Find books whose revenue is greater than average revenue of all books
SELECT b.title
FROM Books b
WHERE (
    SELECT SUM(oi.quantity * oi.unit_price)
    FROM Order_Items oi
    WHERE oi.book_id = b.book_id
) > (
    SELECT AVG(book_revenue)
    FROM (
        SELECT SUM(quantity * unit_price) AS book_revenue
        FROM Order_Items
        GROUP BY book_id
    ) AS temp
);

-- -----------------------------------------------------

-- Q19: Find customers who spent more than average of all customers
SELECT c.first_name
FROM Customers c
WHERE (
    SELECT SUM(o.total_amount)
    FROM Orders o
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(total_amount) AS customer_total
        FROM Orders
        GROUP BY customer_id
    ) AS temp
);

-- -----------------------------------------------------

-- Q20: Find authors who have books priced above overall average price
SELECT first_name
FROM Authors
WHERE author_id IN (
    SELECT author_id
    FROM Books
    WHERE price > (SELECT AVG(price) FROM Books)
);

-- =====================================================
-- END OF FILE
-- =====================================================

-- =====================================================
-- 1. INSERT QUERIES
-- =====================================================

-- Q1: Insert a new author
INSERT INTO Authors (first_name, last_name, bio, country)
VALUES ('Praveen', 'Kumar', 'Emerging Indian writer', 'India');

-- -----------------------------------------------------

-- Q2: Insert a new category
INSERT INTO Categories (category_name, description)
VALUES ('Technology', 'Books related to tech and programming');

-- -----------------------------------------------------

-- Q3: Insert a new publisher
INSERT INTO Publishers (publisher_name, country, website)
VALUES ('TechBooks Publishing', 'India', 'www.techbooks.in');

-- -----------------------------------------------------

-- Q4: Insert a new book
INSERT INTO Books (title, author_id, category_id, publisher_id, price, stock_quantity, published_date, isbn, language, pages)
VALUES ('Learning SQL Basics', 21, 11, 11, 399.00, 25, '2023-01-01', '9781234567890', 'English', 320);

-- -----------------------------------------------------

-- Q5: Insert a new customer
INSERT INTO Customers (first_name, last_name, email, phone, address, city, country)
VALUES ('Anil', 'Reddy', 'anil.reddy@gmail.com', '9876501234', '12 Main Road', 'Nellore', 'India');

-- -----------------------------------------------------

-- Q6: Insert a new order
INSERT INTO Orders (customer_id, total_amount, status, shipping_address)
VALUES (31, 399.00, 'Pending', '12 Main Road, Nellore');

-- -----------------------------------------------------

-- Q7: Insert order items (bridge table)
INSERT INTO Order_Items (order_id, book_id, quantity, unit_price)
VALUES (31, 31, 1, 399.00);

-- -----------------------------------------------------

-- Q8: Insert a payment record
INSERT INTO Payments (order_id, amount, payment_method, payment_status)
VALUES (31, 399.00, 'UPI', 'Pending');

-- =====================================================
-- 2. UPDATE QUERIES
-- =====================================================

-- Q9: Update book price
UPDATE Books
SET price = 450.00
WHERE book_id = 31;

-- -----------------------------------------------------

-- Q10: Increase stock of a book by 10
UPDATE Books
SET stock_quantity = stock_quantity + 10
WHERE book_id = 31;

-- -----------------------------------------------------

-- Q11: Update customer city
UPDATE Customers
SET city = 'Hyderabad'
WHERE customer_id = 31;

-- -----------------------------------------------------

-- Q12: Change order status from Pending to Confirmed
UPDATE Orders
SET status = 'Confirmed'
WHERE order_id = 31;

-- -----------------------------------------------------

-- Q13: Update payment status to Success
UPDATE Payments
SET payment_status = 'Success'
WHERE order_id = 31;

-- -----------------------------------------------------

-- Q14: Give 10% discount to books above 500
UPDATE Books
SET price = price * 0.9
WHERE price > 500;

-- =====================================================
-- 3. DELETE QUERIES
-- =====================================================

-- Q15: Delete a review with rating less than 3
DELETE FROM Reviews
WHERE rating < 3;

-- -----------------------------------------------------

-- Q16: Delete a specific customer
DELETE FROM Customers
WHERE customer_id = 31;

-- -----------------------------------------------------

-- Q17: Delete orders that are cancelled
DELETE FROM Orders
WHERE status = 'Cancelled';

-- -----------------------------------------------------

-- Q18: Delete books with zero stock
DELETE FROM Books
WHERE stock_quantity = 0;

-- =====================================================
-- 4. MIXED / REAL-WORLD DML QUERIES
-- =====================================================

-- Q19: Insert a new order and immediately update its status
INSERT INTO Orders (customer_id, total_amount, status, shipping_address)
VALUES (1, 500.00, 'Pending', 'Nellore');

UPDATE Orders
SET status = 'Confirmed'
WHERE order_id = LAST_INSERT_ID();

-- -----------------------------------------------------

-- Q20: Reduce stock after a book is purchased
UPDATE Books
SET stock_quantity = stock_quantity - 1
WHERE book_id = 1;

-- -----------------------------------------------------

-- Q21: Delete payments that failed
DELETE FROM Payments
WHERE payment_status = 'Failed';

-- -----------------------------------------------------

-- Q22: Update multiple columns of a book
UPDATE Books
SET price = 300.00,
    stock_quantity = 40
WHERE book_id = 2;

-- -----------------------------------------------------

-- Q23: Insert multiple customers at once
INSERT INTO Customers (first_name, last_name, email, phone, address, city, country)
VALUES 
('Kiran', 'Naidu', 'kiran.naidu@gmail.com', '9876540000', 'Street 1', 'Vizag', 'India'),
('Megha', 'Sharma', 'megha.sharma@gmail.com', '9876541111', 'Street 2', 'Delhi', 'India');

-- -----------------------------------------------------

-- Q24: Update all pending payments to failed (example condition)
UPDATE Payments
SET payment_status = 'Failed'
WHERE payment_status = 'Pending';

-- -----------------------------------------------------

-- Q25: Delete all reviews of a specific book
DELETE FROM Reviews
WHERE book_id = 1;

SET SQL_SAFE_UPDATES = 0;

-- Create an index on Book title 
CREATE INDEX idx_book_title ON Books(title);

-- Create an index on Customer email 
CREATE INDEX idx_customer_email ON Customers(email);

CREATE INDEX idx_order_date ON Orders(order_date);
-- Drop an index 
DROP INDEX idx_book_title ON Books;


-- NEW TABLE: wishlist (brand new addition)
--    USING OF DDL CREATE command
-- ============================================

CREATE TABLE Wishlist (
    wishlist_id   INT PRIMARY KEY AUTO_INCREMENT,
    customer_id   INT          NOT NULL,
    book_id       INT          NOT NULL,
    added_date    DATE         DEFAULT (CURRENT_DATE),
    priority      ENUM('High','Medium','Low') DEFAULT 'Medium',
    notes         VARCHAR(255),
    CONSTRAINT fk_wish_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_wish_book     FOREIGN KEY (book_id)     REFERENCES Books(book_id)         ON DELETE CASCADE,
    CONSTRAINT uq_wish UNIQUE (customer_id, book_id)   -- a customer can't wishlist same book twice
);

-- ============================================
--  ALTER TABLE - DDL MODIFICATION EXAMPLES
-- ============================================

-- Add a new column to Books
ALTER TABLE Books ADD COLUMN discount_percent DECIMAL(5,2) DEFAULT 0.00 CHECK (discount_percent BETWEEN 0 AND 100);

-- Add a column to Customers
ALTER TABLE Customers ADD COLUMN loyalty_points INT DEFAULT 0 CHECK (loyalty_points >= 0);

-- Rename a column (MySQL 8+)
ALTER TABLE Payments RENAME COLUMN payment_status TO txn_status;

-- Rename it back
ALTER TABLE Payments RENAME COLUMN txn_status TO payment_status;

-- Modify a column datatype
ALTER TABLE Authors MODIFY COLUMN country VARCHAR(100);

-- ============================================
-- INSERT DATA INTO WISHLIST TABLE
-- ============================================

INSERT INTO Wishlist (customer_id, book_id, priority, notes) VALUES
(1,  3,  'High',   'Waiting for discount'),
(1,  7,  'Medium', 'Recommended by friend'),
(2,  5,  'High',   'Part of favourite series'),
(2,  10, 'Low',    'Just curious'),
(3,  1,  'Medium', 'Popular book'),
(3,  18, 'High',   'For research purpose'),
(4,  6,  'Medium', 'Life changing book'),
(4,  15, 'Low',    'Long read, saving for later'),
(5,  2,  'High',   'Harry Potter fan'),
(5,  26, 'High',   'Continuing the series'),
(6,  11, 'Medium', 'Love mystery novels'),
(6,  23, 'Medium', 'Dan Brown fan'),
(7,  13, 'High',   'Indian literature'),
(7,  17, 'High',   'Kite Runner is amazing'),
(8,  4,  'Low',    'Classic read'),
(8,  20, 'Medium', 'Mythology interest'),
(9,  8,  'High',   'Booker Prize winner'),
(9,  19, 'Medium', 'Self help book'),
(10, 25, 'High',   'Loved first book'),
(10, 29, 'Low',    'Mythology collection');

-- ============================================
--  DCL - ROLES AND PERMISSIONS
-- ============================================

-- Create a data analyst role
CREATE ROLE 'data_analyst'@'localhost';

-- Grant only SELECT permission to data_analyst role
GRANT SELECT ON OnlineBookStore.* TO 'data_analyst';

-- Create the analyst_user
CREATE USER 'analyst_user'@'localhost' IDENTIFIED BY 'Analyst@2024';

-- Assign the data_analyst role to analyst_user
GRANT 'data_analyst' TO 'analyst_user'@'localhost';

-- Activate role by default when user logs in
SET DEFAULT ROLE 'data_analyst' TO 'analyst_user'@'localhost';

-- Create an admin user for full access
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'Admin@2024';
GRANT ALL PRIVILEGES ON OnlineBookStore.* TO 'admin_user'@'localhost';

-- ============================================
-- 6. REVOKE - Remove DELETE permission
-- ============================================

-- Revoke DELETE from analyst_user directly
REVOKE DELETE ON OnlineBookStore.* FROM 'analyst_user'@'localhost';

-- Apply all privilege changes
FLUSH PRIVILEGES;

-- ============================================
-- 7. VERIFY ROLES AND PERMISSIONS
-- ============================================

-- Check what privileges analyst_user has
SHOW GRANTS FOR 'analyst_user'@'localhost';

-- Check all users in database
SELECT user, host FROM mysql.user;

-- ADD CONSTRAINTS
-- Make email UNIQUE
ALTER TABLE Customers
ADD CONSTRAINT uq_customer_email UNIQUE (email);

ALTER TABLE Books
ADD CONSTRAINT uq_book_isbn UNIQUE (isbn);

-- Price must not be negative
ALTER TABLE Books
ADD CONSTRAINT chk_price CHECK (price >= 0);


-- Check all constraints on all tables
SELECT 
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'OnlineBookStore'
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;

-- ============================================
-- DROP TABLE EXAMPLE (DDL)
-- ============================================

-- To drop a table (only run if needed)
-- DROP TABLE IF EXISTS Wishlist;

-- To drop and recreate database (only run if needed)
-- DROP DATABASE IF EXISTS OnlineBookStore;

-- ============================================
-- TCL QUERIES - ONLINE BOOKSTORE PROJECT
-- ============================================

USE OnlineBookStore;

-- ============================================
-- TASK 1: START TRANSACTION + INSERT ORDER
-- ============================================

START TRANSACTION;

INSERT INTO Orders (
    order_id,
    customer_id,
    order_date,
    total_amount,
    status,
    shipping_address
)
VALUES (
    101,
    (SELECT customer_id FROM Customers WHERE first_name = 'Ravi'),
    NOW(),
    698.00,
    'Pending',
    '12 MG Road, Nellore'
);

-- ============================================
-- TASK 2: CREATE SAVEPOINT
-- ============================================

SAVEPOINT order_created;

-- ============================================
-- TASK 3: UPDATE ORDER STATUS
-- ============================================

UPDATE Orders
SET
    status = 'Confirmed',
    total_amount = 750.00
WHERE order_id = 101;

-- ============================================
-- TASK 4: COMMIT OR ROLLBACK
-- ============================================

-- If Ravi CONFIRMS the order
COMMIT;

-- If Ravi CANCELS the order (run instead of COMMIT)
-- ROLLBACK TO order_created;

-- If something goes wrong entirely
-- ROLLBACK;

-- ============================================
-- CONCURRENT TRANSACTIONS
-- (Two customers trying to buy last copy)
-- ============================================

-- TRANSACTION 1 (Customer 1 - Ravi)
-- ============================================

START TRANSACTION;

-- Step 1: Lock the book row so no one else can grab it
SELECT *
FROM Books
WHERE book_id = 1
FOR UPDATE;

-- Step 2: Insert order for Ravi (book is available)
INSERT INTO Orders (
    customer_id,
    total_amount,
    status,
    shipping_address
)
VALUES (
    1,
    199.00,
    'Confirmed',
    '12 MG Road, Nellore'
);

-- Step 3: Reduce stock by 1
UPDATE Books
SET stock_quantity = stock_quantity - 1
WHERE book_id = 1;

-- Step 4: Commit (releases the lock)
COMMIT;

-- ============================================
-- TRANSACTION 2 (Customer 2 - Priya)
-- Runs at same time as Transaction 1
-- ============================================

START TRANSACTION;

-- This will WAIT until Transaction 1 completes
-- because book_id = 1 is locked
SELECT *
FROM Books
WHERE book_id = 1
FOR UPDATE;

-- Try to place order for same book
INSERT INTO Orders (
    customer_id,
    total_amount,
    status,
    shipping_address
)
VALUES (
    2,
    199.00,
    'Pending',
    '45 Banjara Hills, Hyderabad'
);

-- Stock check - if out of stock, cancel Priya order
ROLLBACK;

-- ============================================
-- TASK 5: SAVEPOINT DETAILED EXAMPLE
-- ============================================

START TRANSACTION;

-- Insert first order item
INSERT INTO Order_Items (order_id, book_id, quantity, unit_price)
VALUES (1, 1, 2, 199.00);

SAVEPOINT item1_added;

-- Insert second order item
INSERT INTO Order_Items (order_id, book_id, quantity, unit_price)
VALUES (1, 5, 1, 350.00);

SAVEPOINT item2_added;

-- Insert third order item (mistake - wrong book)
INSERT INTO Order_Items (order_id, book_id, quantity, unit_price)
VALUES (1, 99, 1, 999.00);

-- Oops! Wrong book added, rollback only the third insert
ROLLBACK TO item2_added;

-- First two items are safe, commit them
COMMIT;

-- ============================================
-- TEMPORARY TABLE
-- ============================================

-- Create temporary table for book sales summary
-- (only exists for current session)
CREATE TEMPORARY TABLE temp_book_summary AS
SELECT
    b.book_id,
    b.title,
    CONCAT(a.first_name,' ',a.last_name) AS Author,
    COUNT(oi.order_item_id)              AS Total_Orders,
    SUM(oi.quantity)                     AS Units_Sold,
    SUM(oi.quantity * oi.unit_price)     AS Total_Revenue
FROM Books b
LEFT JOIN Authors a      ON b.author_id  = a.author_id
LEFT JOIN Order_Items oi ON b.book_id    = oi.book_id
GROUP BY b.book_id, b.title, a.first_name, a.last_name;

-- Query the temporary table
SELECT * FROM temp_book_summary
ORDER BY Total_Revenue DESC;

-- Top earning books from temp table
SELECT title, Units_Sold, Total_Revenue
FROM temp_book_summary
WHERE Units_Sold > 1
ORDER BY Total_Revenue DESC;

-- ============================================
-- VIEW
-- ============================================

-- Create a permanent view for book performance
CREATE VIEW book_performance AS
SELECT
    b.book_id,
    b.title,
    CONCAT(a.first_name,' ',a.last_name) AS Author,
    c.category_name                       AS Category,
    COUNT(oi.order_item_id)               AS Total_Orders,
    SUM(oi.quantity)                      AS Units_Sold,
    SUM(oi.quantity * oi.unit_price)      AS Total_Revenue,
    ROUND(AVG(r.rating), 2)               AS Avg_Rating
FROM Books b
LEFT JOIN Authors      a  ON b.author_id   = a.author_id
LEFT JOIN Categories   c  ON b.category_id = c.category_id
LEFT JOIN Order_Items  oi ON b.book_id     = oi.book_id
LEFT JOIN Reviews      r  ON b.book_id     = r.book_id
GROUP BY b.book_id, b.title, a.first_name, a.last_name, c.category_name;

-- Query the view
SELECT * FROM book_performance;

-- Best performing books from view
SELECT title, Units_Sold, Total_Revenue, Avg_Rating
FROM book_performance
WHERE Units_Sold IS NOT NULL
ORDER BY Total_Revenue DESC;

-- Category wise performance from view
SELECT Category,
       SUM(Units_Sold)    AS Total_Units,
       SUM(Total_Revenue) AS Category_Revenue
FROM book_performance
GROUP BY Category
ORDER BY Category_Revenue DESC;

-- ============================================
-- ONLINE BOOKSTORE
-- STORED PROCEDURES + TRIGGERS + EVENTS
-- ============================================

USE OnlineBookStore;

-- ============================================
-- EXERCISE 1: STORED PROCEDURES
-- ============================================

DELIMITER $$

-- ============================================
-- Procedure 1: Revenue and Order Insights
-- (Pass book_id + date range, get revenue)
-- ============================================

CREATE PROCEDURE GetRevenueAndOrders(
    IN p_book_id   INT,
    IN p_start_date DATE,
    IN p_end_date   DATE
)
BEGIN
    DECLARE total_rev   DECIMAL(10,2);
    DECLARE total_orders INT;

    -- Validate book exists
    IF NOT EXISTS (SELECT 1 FROM Books WHERE book_id = p_book_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid Book ID. Book does not exist.';
    END IF;

    -- Get total revenue and order count for that book
    SELECT
        IFNULL(SUM(oi.quantity * oi.unit_price), 0),
        COUNT(DISTINCT oi.order_id)
    INTO total_rev, total_orders
    FROM Order_Items oi
    JOIN Orders o ON oi.order_id = o.order_id
    WHERE oi.book_id = p_book_id
    AND DATE(o.order_date) BETWEEN p_start_date AND p_end_date;

    SELECT
        total_rev    AS Total_Revenue,
        total_orders AS Total_Orders;
END$$


-- ============================================
-- Procedure 2: Customer Order History
-- (Pass customer_id, get all orders)
-- ============================================

CREATE PROCEDURE GetCustomerOrderHistory(
    IN p_customer_id INT
)
BEGIN
    -- Validate customer exists
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = p_customer_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid Customer ID. Customer does not exist.';
    END IF;

    SELECT
        o.order_id,
        b.title          AS Book_Title,
        a.first_name     AS Author,
        oi.quantity,
        oi.unit_price,
        o.order_date,
        o.status,
        o.shipping_address
    FROM Orders o
    JOIN Order_Items oi ON o.order_id  = oi.order_id
    JOIN Books b        ON oi.book_id  = b.book_id
    JOIN Authors a      ON b.author_id = a.author_id
    WHERE o.customer_id = p_customer_id
    ORDER BY o.order_date DESC;
END$$


-- ============================================
-- Procedure 3: Top Rated Books
-- (Pass category + min rating, get results)
-- ============================================

CREATE PROCEDURE GetTopRatedBooks(
    IN p_category   VARCHAR(100),
    IN p_min_rating DECIMAL(2,1)
)
BEGIN
    SELECT
        b.book_id,
        b.title,
        CONCAT(a.first_name,' ',a.last_name) AS Author,
        c.category_name                       AS Category,
        ROUND(AVG(r.rating), 2)               AS Avg_Rating,
        COUNT(r.review_id)                    AS Total_Reviews
    FROM Books b
    JOIN Authors    a ON b.author_id   = a.author_id
    JOIN Categories c ON b.category_id = c.category_id
    JOIN Reviews    r ON b.book_id     = r.book_id
    WHERE (p_category IS NULL OR c.category_name = p_category)
    GROUP BY b.book_id, b.title, a.first_name, a.last_name, c.category_name
    HAVING AVG(r.rating) >= p_min_rating
    ORDER BY Avg_Rating DESC;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No books found matching the criteria.';
    END IF;
END$$

DELIMITER ;

-- ============================================
-- CALL THE PROCEDURES
-- ============================================

-- Get revenue for book_id=1 in year 2024
CALL GetRevenueAndOrders(1, '2024-01-01', '2024-12-31');

-- Get full order history of customer_id=2
CALL GetCustomerOrderHistory(2);

-- Get top rated Fiction books with rating >= 4.0
CALL GetTopRatedBooks('Fiction', 4.0);


-- ============================================
-- EXERCISE 2: TRIGGERS
-- ============================================

DELIMITER $$

-- ============================================
-- Trigger 1: Prevent ordering out of stock books
-- (BEFORE INSERT on Order_Items)
-- ============================================

CREATE TRIGGER prevent_out_of_stock
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;

    SELECT stock_quantity INTO available_stock
    FROM Books
    WHERE book_id = NEW.book_id;

    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot place order. Insufficient stock available.';
    END IF;
END$$


-- ============================================
-- Trigger 2: Auto reduce stock after order
-- (AFTER INSERT on Order_Items)
-- ============================================

CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Books
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE book_id = NEW.book_id;
END$$

DELIMITER ;

-- ============================================
-- Price Log Table for Trigger 3
-- ============================================

CREATE TABLE Price_Log (
    log_id      INT AUTO_INCREMENT PRIMARY KEY,
    book_id     INT,
    old_price   DECIMAL(10,2),
    new_price   DECIMAL(10,2),
    changed_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

DELIMITER $$

-- ============================================
-- Trigger 3: Log book price changes
-- (BEFORE UPDATE on Books)
-- ============================================

CREATE TRIGGER log_book_price_change
BEFORE UPDATE ON Books
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO Price_Log (book_id, old_price, new_price)
        VALUES (OLD.book_id, OLD.price, NEW.price);
    END IF;
END$$

DELIMITER ;

-- ============================================
-- TEST TRIGGERS
-- ============================================

-- Test Trigger 1 and 2: Place an order
INSERT INTO Order_Items (order_id, book_id, quantity, unit_price)
VALUES (1, 2, 1, 499.00);

-- Test Trigger 3: Update book price
UPDATE Books
SET price = 550.00
WHERE book_id = 1;

-- Verify price log
SELECT * FROM Price_Log;

-- Verify stock reduced
SELECT book_id, title, stock_quantity FROM Books WHERE book_id = 2;


-- ============================================
-- EXERCISE 3: EVENTS
-- ============================================

-- Enable event scheduler
SET GLOBAL event_scheduler = ON;

-- ============================================
-- Daily Sales Summary Table
-- ============================================

CREATE TABLE Daily_Sales_Summary (
    report_id          INT AUTO_INCREMENT PRIMARY KEY,
    report_date        DATE,
    total_orders       INT,
    total_revenue      DECIMAL(10,2),
    unique_books_sold  INT,
    unique_customers   INT
);

DELIMITER $$

-- ============================================
-- Event 1: Daily Sales Report
-- (runs every day automatically)
-- ============================================

CREATE EVENT daily_sales_report_event
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    INSERT INTO Daily_Sales_Summary (
        report_date,
        total_orders,
        total_revenue,
        unique_books_sold,
        unique_customers
    )
    SELECT
        CURDATE(),
        COUNT(DISTINCT o.order_id),
        IFNULL(SUM(oi.quantity * oi.unit_price), 0),
        COUNT(DISTINCT oi.book_id),
        COUNT(DISTINCT o.customer_id)
    FROM Orders o
    JOIN Order_Items oi ON o.order_id = oi.order_id
    WHERE DATE(o.order_date) = CURDATE();
END$$


-- ============================================
-- Event 2: Mark books as low stock
-- (runs every day, flags books below 10 qty)
-- ============================================

CREATE TABLE Low_Stock_Alerts (
    alert_id    INT AUTO_INCREMENT PRIMARY KEY,
    book_id     INT,
    title       VARCHAR(200),
    stock_left  INT,
    alerted_on  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE EVENT low_stock_alert_event
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    INSERT INTO Low_Stock_Alerts (book_id, title, stock_left)
    SELECT book_id, title, stock_quantity
    FROM Books
    WHERE stock_quantity < 10
    AND book_id NOT IN (
        SELECT book_id FROM Low_Stock_Alerts
        WHERE DATE(alerted_on) = CURDATE()
    );
END$$

DELIMITER ;

-- ============================================
-- CHECK RESULTS
-- ============================================

-- View daily sales summary
SELECT * FROM Daily_Sales_Summary;

-- View low stock alerts
SELECT * FROM Low_Stock_Alerts;

-- View price change log
SELECT
    pl.log_id,
    b.title,
    pl.old_price,
    pl.new_price,
    pl.changed_at
FROM Price_Log pl
JOIN Books b ON pl.book_id = b.book_id
ORDER BY pl.changed_at DESC;

-- View current stock of all books
SELECT book_id, title, stock_quantity
FROM Books
ORDER BY stock_quantity ASC;


-- ============================================
-- ONLINE BOOKSTORE
-- EXERCISE 1: JSON COLUMN + GROUP BY + HAVING
-- ============================================

USE OnlineBookStore;

-- ============================================
-- ALTER TABLE: Add JSON column to Books
-- (same as adding property_details to property)
-- ============================================

ALTER TABLE Books
ADD COLUMN book_details JSON;

-- ============================================
-- INSERT JSON DATA INTO BOOKS
-- ============================================

UPDATE Books SET book_details = '{
    "format": "Paperback",
    "edition": "1st",
    "language": "English",
    "tags": ["engineering", "friendship", "college"],
    "awards": ["Best Debut Novel"]
}' WHERE book_id = 1;

UPDATE Books SET book_details = '{
    "format": "Hardcover",
    "edition": "1st",
    "language": "English",
    "tags": ["magic", "fantasy", "adventure"],
    "awards": ["Hugo Award", "Nebula Award"]
}' WHERE book_id = 2;

UPDATE Books SET book_details = '{
    "format": "Paperback",
    "edition": "Classic",
    "language": "English",
    "tags": ["dystopia", "politics", "classic"],
    "awards": ["Prometheus Award"]
}' WHERE book_id = 3;

UPDATE Books SET book_details = '{
    "format": "Paperback",
    "edition": "Revised",
    "language": "English",
    "tags": ["mythology", "india", "regional"],
    "awards": []
}' WHERE book_id = 4;

UPDATE Books SET book_details = '{
    "format": "Hardcover",
    "edition": "1st",
    "language": "English",
    "tags": ["mythology", "shiva", "historical fiction"],
    "awards": ["Crossword Award"]
}' WHERE book_id = 5;

UPDATE Books SET book_details = '{
    "format": "Paperback",
    "edition": "25th Anniversary",
    "language": "English",
    "tags": ["self-help", "spiritual", "inspiration"],
    "awards": ["Best Seller"]
}' WHERE book_id = 6;

UPDATE Books SET book_details = '{
    "format": "Hardcover",
    "edition": "1st",
    "language": "English",
    "tags": ["thriller", "mystery", "conspiracy"],
    "awards": ["Anthony Award"]
}' WHERE book_id = 7;

UPDATE Books SET book_details = '{
    "format": "Paperback",
    "edition": "1st",
    "language": "English",
    "tags": ["literary fiction", "india", "family"],
    "awards": ["Booker Prize"]
}' WHERE book_id = 8;


-- ============================================
-- TASK 1: Retrieve all books with JSON details
-- (same as find() all records)
-- ============================================

SELECT
    book_id,
    title,
    price,
    book_details
FROM Books
WHERE book_details IS NOT NULL;

-- ============================================
-- TASK 2: Retrieve books that are Paperback
-- (same as find tickets with status = Open)
-- ============================================

SELECT
    book_id,
    title,
    book_details->>'$.format'   AS format,
    book_details->>'$.edition'  AS edition
FROM Books
WHERE book_details->>'$.format' = 'Paperback';

-- ============================================
-- TASK 3: Sort Paperback books by edition
-- (same as sort open tickets by created_at ASC)
-- ============================================

SELECT
    book_id,
    title,
    book_details->>'$.format'   AS format,
    book_details->>'$.edition'  AS edition
FROM Books
WHERE book_details->>'$.format' = 'Paperback'
ORDER BY
    book_details->>'$.edition' ASC;

-- ============================================
-- TASK 4: Retrieve books by specific author_id
-- (same as find tickets by customer_id = 101)
-- ============================================

SELECT
    b.book_id,
    b.title,
    CONCAT(a.first_name,' ',a.last_name) AS author_name,
    b.book_details->>'$.format'          AS format,
    b.book_details->>'$.tags'            AS tags
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
WHERE b.author_id = 1;

-- ============================================
-- TASK 5: Retrieve books tagged as mythology
-- (same as find tickets with issue_type = Refund)
-- ============================================

SELECT
    book_id,
    title,
    book_details->>'$.tags'    AS tags,
    book_details->>'$.awards'  AS awards
FROM Books
WHERE JSON_SEARCH(
    book_details,
    'one',
    'mythology',
    NULL,
    '$.tags'
) IS NOT NULL;

-- ============================================
-- TASK 6: Retrieve books published between
-- 2000 and 2010
-- (same as tickets resolved between two dates)
-- ============================================

SELECT
    book_id,
    title,
    published_date,
    book_details->>'$.format'   AS format,
    book_details->>'$.edition'  AS edition
FROM Books
WHERE published_date >= '2000-01-01'
AND   published_date <= '2010-12-31'
ORDER BY published_date ASC;

-- ============================================
-- TASK 7: Last 2 books published after 2005
-- sorted by title descending
-- (same as last 2 records for year 2025
--  sorted by customer_name DESC)
-- ============================================

SELECT
    book_id,
    title,
    published_date,
    book_details->>'$.format'   AS format,
    book_details->>'$.tags'     AS tags
FROM Books
WHERE YEAR(published_date) >= 2005
ORDER BY
    title DESC,
    published_date DESC
LIMIT 2;

-- ============================================
-- EXTRA: Additional JSON Analytical Queries
-- ============================================

-- Books grouped by format
SELECT
    book_details->>'$.format'  AS format,
    COUNT(*)                   AS total_books,
    ROUND(AVG(price), 2)       AS avg_price
FROM Books
WHERE book_details IS NOT NULL
GROUP BY book_details->>'$.format';

-- Books that have won at least one award
SELECT
    book_id,
    title,
    price,
    book_details->>'$.awards'  AS awards
FROM Books
WHERE JSON_LENGTH(
    book_details->>'$.awards'
) > 0;

-- Books with hardcover format and price above 400
SELECT
    book_id,
    title,
    price,
    book_details->>'$.format'   AS format,
    book_details->>'$.edition'  AS edition
FROM Books
WHERE book_details->>'$.format' = 'Hardcover'
AND   price > 400;

-- Most common tags across all books
SELECT
    book_details->>'$.tags'   AS tags,
    COUNT(*)                  AS tag_count
FROM Books
WHERE book_details IS NOT NULL
GROUP BY book_details->>'$.tags'
ORDER BY tag_count DESC;

-- ============================================
-- VERIFY
-- ============================================

-- Check JSON column exists
DESCRIBE Books;

-- View all JSON data
SELECT book_id, title, book_details FROM Books;