CREATE DATABASE SDA_library_er;
USE SDA_library_er;


-- *****TABLE CREATION QUERIES*****
-----------------------------------------------
CREATE TABLE authors
(
	id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name       VARCHAR(32) NOT NULL,
	surname    VARCHAR(32) NOT NULL,
	birth_date DATE        NOT NULL
);
CREATE TABLE books
(
	id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	isbn           VARCHAR(32)   NOT NULL,
	title          VARCHAR(64)   NOT NULL,
	date_published DATE          NOT NULL,
	price          DECIMAL(6, 2) NOT NULL,
	total_pages    INT UNSIGNED  NOT NULL,
	rating         DECIMAL(6, 2),
	author_id      INT UNSIGNED  NOT NULL,

	FOREIGN KEY (author_id)
		REFERENCES authors (id)
		ON DELETE RESTRICT
);
CREATE TABLE copies
( -- Individual books in stock of library
	id            INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	book_id       INT UNSIGNED NOT NULL,
	date_received DATE         NOT NULL,

	FOREIGN KEY (book_id)
		REFERENCES books (id)
		ON DELETE RESTRICT
);
CREATE TABLE readers
( -- Readers of library
	id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name     VARCHAR(64) NOT NULL,
	surname  VARCHAR(64) NOT NULL,
	birthday DATE        NOT NULL
);
CREATE TABLE reader_copies
(                                      -- Data on books taken out by readers
	reader_id   INT UNSIGNED NOT NULL,
	copy_id     INT UNSIGNED NOT NULL,
	issue_date  DATE         NOT NULL,
	return_date DATE         NOT NULL, -- Date when copy of book has to be returned

	FOREIGN KEY (reader_id)
		REFERENCES readers (id)
		ON DELETE CASCADE,

	FOREIGN KEY (copy_id)
		REFERENCES copies (id)
		ON DELETE CASCADE
);
CREATE TABLE reader_book_ratings
( -- data on book ratings by readers
	reader_id INT UNSIGNED NOT NULL,
	book_id   INT UNSIGNED NOT NULL,
	rating    DECIMAL(2, 1) UNSIGNED,

	FOREIGN KEY (reader_id)
		REFERENCES readers (id)
		ON DELETE CASCADE,

	FOREIGN KEY (book_id)
		REFERENCES books (id)
		ON DELETE CASCADE
);
CREATE TABLE reader_returns
( -- copies that were returned to library
	reader_id     INT UNSIGNED NOT NULL,
	copy_id       INT UNSIGNED NOT NULL,
	date_returned DATE         NOT NULL,

	FOREIGN KEY (reader_id)
		REFERENCES readers (id)
		ON DELETE CASCADE,

	FOREIGN KEY (copy_id)
		REFERENCES copies (id)
		ON DELETE CASCADE
);
