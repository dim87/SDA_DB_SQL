# Homework 01
## Continue with library database development

### Some things to consider, while doing homework
- create a new database `CREATE DATABASE SDA_library_homework;`
- start your work with doing a ```USE SDA_library_homework;``` query to select active database
- you can re-use tables `books` and `authors` that were created during the lecture (SQL provided below)
- don't forget to add foreign keys when creating tables
- think if a field is mandatory or optional (not null) 
- insert some data into tables so you can test select queries later on 
- save all your queries into separate file
- if you have any questions- don't be shy, write me a message in Slack, I will be happy to help :)
- send me the resulting sql file with all queries that you have used to create tables and select data via slack
- Pleeeeeease don't send me this file on Saturday at 03:00 in the morning as I won't have time to review it

### Just so we could start on the same page
You can copy-paste this code into new SQL editor tab and run it to create all tables with data. Remember to run insert queries only once so you won't have some duplicate data in tables.

[Books & Authors SQL](homework_01.sql)

### Create new tables
- copies (individual books that are in stock of library)
    - book_id
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
- commenting each query, so it would be easier to understand what it does
- correct ON DELETE CASCADE(to delete all related records by foreign key) and ON DELETE RESTRICT(to prevent delete if related records exist) options for foreign keys
- creating unique indexes for fields that must be unique (i.e.: isbn number is unique for a book), you can Google this topic, as we will cover it next week :)
- interesting selects


