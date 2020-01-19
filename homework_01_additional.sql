-- delete the whole database(Use with caution as it will delete all created tables and data too)
DROP DATABASE SDA_library_homework;


-- delete specific table from database (delete table structure and data)
DROP TABLE authors;


-- delete all the data inside authors table, but the table itself remains in database
TRUNCATE TABLE authors;


-- delete author with ID = 13
DELETE
FROM authors
WHERE id = 13;


-- select all authors and books that they have written
SELECT a.*, b.*
FROM authors a
JOIN books b ON a.id = b.author_id;


-- select author and count of books he has written
SELECT a.*, count(b.id) as count_of_books
FROM authors a
JOIN books b ON a.id = b.author_id
GROUP BY b.author_id;


-- select author and count of books he has written,
-- but only authors with 2 or more books
SELECT a.*, count(b.id) as count_of_books
FROM authors a
	JOIN books b ON a.id = b.author_id
GROUP BY b.author_id
HAVING count_of_books > 1;


-- Remember we had that task where we had to select author with the longest title of a book?
-- Well this is one option of doing it: by using a sub-query
-- Sub-queries generally are very slow, so it is best to avoid them if possible
SELECT a.name, a.surname, longest_title_book.title
FROM (
	SELECT b.author_id,
		b.title
	FROM books b
	ORDER BY char_length(b.title) DESC
	LIMIT 1) AS longest_title_book
JOIN authors a ON longest_title_book.author_id = a.id;


-- And this is the same task, with same results, but using a regular JOIN clause
-- Which is super-performant and easier to read
-- Guess I was a bit too tired by the end of the lecture so I wasn't able to write it :)
SELECT a.name, a.surname, b.title
FROM books b
	JOIN authors a ON b.author_id = a.id
ORDER BY char_length(b.title) DESC
LIMIT 1;


-- Select average number of books an author has written, including authors without any books
SELECT a.name, a.surname, CASE WHEN AVG(b.id) IS NULL THEN 0 ELSE AVG(b.id) END as average_book_count
FROM authors a
	LEFT JOIN books b on a.id = b.author_id
GROUP BY a.id;


-- Select average number of books an author has written, including authors without any books
-- Same query as above, but using IFNULL function
SELECT a.name, a.surname, IFNULL(AVG(b.id), 0) as average_book_count
FROM authors a
	LEFT JOIN books b on a.id = b.author_id
GROUP BY a.id;
