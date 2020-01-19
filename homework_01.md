# Homework 01
##Continue with library database development

### Some things to consider, while doing homework
- create a new database `CREATE DATABASE SDA_library_homework;`
- start your work with doing a ```USE SDA_library_homework;``` query to select active database
- you can re-use tables `books` and `authors` that were created during the lecture (SQl provided below)
- don't forget to add foreign keys when creating tables
- think if a field is mandatory or optional (not null) 
- insert some data into tables so you can test select queries later on 
- save all your queries into separate file
- if you have any questions- don't be shy, write me a message in Slack, I will be happy to help :)
- send me the resulting sql file with all queries that you have used to create tables and select data via slack
- Pleeeeeease don't send me this file on Saturday at 03:00 in the morning as I won't have time to review it

### Just so we could start on the same page
You can copy-paste this code into new SQL editor tab and run it to create all tables with data. Remember to run insert queries only once so you won't have some duplicate data in tables.
```
-- Create new database for homework
CREATE DATABASE SDA_library_homework;

-- Make created datbase as active
USE SDA_library_homework;

-- Create authors table
CREATE TABLE authors (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    surname VARCHAR(32) NOT NULL,
    birth_date DATE NOT NULL
);

-- Insert some data into authors table
INSERT INTO authors (name, surname, birth_date) 
VALUES 
    ("Jack", "London", DATE("1876-01-12")),
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
CREATE TABLE books (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(32) NOT NULL,
    title VARCHAR(64) NOT NULL,
    date_published DATE NOT NULL,
    price DECIMAL(6, 2) NOT NULL,
    total_pages INT UNSIGNED NOT NULL,
    rating DECIMAL(6, 2),
    author_id INT UNSIGNED NOT NULL,
    
    FOREIGN KEY (author_id) 
    REFERENCES authors(id) 
		ON DELETE RESTRICT
);

-- Insert some books
INSERT INTO books (isbn, title, date_published, price, total_pages, rating, author_id)
VALUES
    ("ISBN122223", "Martin Eden", DATE("1909-01-01"), 5.50, 100, null, 1),
    ("ISBN122224", "The Old Man and the Sea", DATE("1952-01-01"), 7.50, 200, null, 2),
    ("ISBN122225", "A Farewell to Arms", DATE("1929-01-01"), 3.60, 300, null, 2),
    ("ISBN122226", "For Whom the Bells Tolls", DATE("1940-01-01"), 250, 4.8, null, 2),
    ("ISBN122227", "The Adventures of Tom Sawyer", DATE("1876-01-01"), 3.25, 350, 4.3, 3),
    ("ISBN122228", "The Adventures of Huckleberry Finn", DATE("1884-01-01"), 3.20, 200, 3.20, 3);

-- Double check that everything is correct
SELECT count(*) AS book_count FROM books;
-- Should return 6

SELECT count(*) AS author_count FROM authors; 
-- Should return 13
```


### Create new tables
- copies (individual books that are in stock of library)
    - date_received (date when this copy was added to the library)

- readers (readers of the library)
    - name
    - surname
    - birthday

- reader_copies (reader has taken a copy of a book)
    - reader_id
    - copy_id
    - issue_date (date when copy of a book was given to reader)
    - return_date (date when this copy of book must be returned)

- reader_book_rating (reader rates a book)
    - reader_id
    - book_id
    - rating
    
- reader_returns (copies that were returned back to library)
    - reader_id
    - copy_id
    - date_returned

### Write some SQL queries
- select total count of copies in library
- select reader(name and surname) who has done the most book ratings
- select average ratings per book from `reader_book_rating` table, result should have two columns (book_id, average_rating)
- select all readers that have at least one non-returned copy of a book
- select count of copies per book(result should have `book_id`, `book_title`, `count_of_copies` columns)
- select readers and books that they have taken (result should have `reader_name`, `reader_surname`, `book_title`)
- select readers who have been issued books after 1st Of January 2019 (result should have `reader_name`, `reader_surname`)
- have some fun with `select`- create your own queries!

#### Bonus points for
- for commenting each query, so it would be easier to understand what it does
- correct ON DELETE CASCADE(to delete all related records by foreign key) and ON DELETE RESTRICT(to prevent delete if related records exist) options for foreign keys
- creating unique indexes for fields that must be unique (i.e.: isbn number is unique for a book), you can Google this topic, as we will cover it next week :)
- interesting selects


