-- Create new database for homework
CREATE DATABASE SDA_library_homework;

-- Make created datbase as active
USE SDA_library_homework;

-- Create authors table
CREATE TABLE authors
(
	id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name       VARCHAR(32) NOT NULL,
	surname    VARCHAR(32) NOT NULL,
	birth_date DATE        NOT NULL
);

-- Insert some data into authors table
INSERT INTO authors (name, surname, birth_date)
VALUES ("Jack", "London", DATE("1876-01-12")),
	   ("Ernest", "Hemingway", DATE("1899-07-21")),
	   ("Mark", "Twain", DATE("1835-11-30")),
	   ("Oscar", "Wilde", DATE("1854-10-16")),
	   ("Charles", "Dickens", DATE("1812-02-07")),
	   ("William", "Shakespeare", DATE("1564-04-01")),
	   ("Lord", "Byron", DATE("1788-01-22")),
	   ("William", "Wordsworth", DATE("1770-04-07")),
	   ("William", "Blake", DATE("1757-11-28")),
	   ("John", "Keats", DATE("1795-10-31")),
	   ("Dan", "Brown", DATE("1964-06-22")),
	   ("Joanne", "Rowling", DATE("1965-07-31")),
	   ("George R. R.", "Martin", DATE("1948-09-20"));

-- Create books table
CREATE TABLE books
(
	id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	isbn           VARCHAR(32)   NOT NULL,
	title          VARCHAR(64)   NOT NULL,
	date_published DATE          NOT NULL,
	price          DECIMAL(6, 2) NOT NULL,
	total_pages    INT UNSIGNED NOT NULL,
	rating         DECIMAL(6, 2),
	author_id      INT UNSIGNED NOT NULL,

	FOREIGN KEY (author_id)
		REFERENCES authors (id)
		ON DELETE RESTRICT
);

-- Insert some books
INSERT INTO books (isbn, title, date_published, price, total_pages, rating, author_id)
VALUES ("ISBN122223", "Martin Eden", DATE("1909-01-01"), 5.50, 100, null, 1),
	   ("ISBN122224", "The Old Man and the Sea", DATE("1952-01-01"), 7.50, 200, null, 2),
	   ("ISBN122225", "A Farewell to Arms", DATE("1929-01-01"), 3.60, 300, null, 2),
	   ("ISBN122226", "For Whom the Bells Tolls", DATE("1940-01-01"), 4.8, 250, null, 2),
	   ("ISBN122227", "The Adventures of Tom Sawyer", DATE("1876-01-01"), 3.25, 350, 4.3, 3),
	   ("ISBN122228", "The Adventures of Huckleberry Finn", DATE("1884-01-01"), 3.20, 200, 3.20, 3);

-- Double check that everything is correct
SELECT count(*) AS book_count
FROM books;
-- Should return 6

SELECT count(*) AS author_count
FROM authors;
-- Should return 13
