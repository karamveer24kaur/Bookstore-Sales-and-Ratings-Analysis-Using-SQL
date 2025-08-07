USE bookstore;

CREATE TABLE books(
`book_id` INT PRIMARY KEY,	
`book_name` VARCHAR(255),
`author` VARCHAR(255),
`publisher` VARCHAR(255),	
`publishing_year` YEAR,	
`language_code` VARCHAR(100),		
`genre` VARCHAR(255)	
);

CREATE TABLE ratings(
`book_id` INT,	
`author_rating` VARCHAR(100),	
`book_average_rating` FLOAT,	
`book_ratings_count` INT,	
`gross_sales` FLOAT,	
`publisher_revenue` FLOAT,
`sale_price` FLOAT,	
`units_sold` INT
);

-- Top-Selling Books by Gross Sales "Using a Subquery"
SELECT book_name, author, gross_sales
FROM (
SELECT b.book_name, b.author, r.gross_sales
FROM books b
JOIN ratings r ON b.book_id = r.book_id
) AS sales_data
ORDER BY gross_sales DESC
LIMIT 10;

--  Average Book Rating by Genre "Using a CTE"
WITH genre_ratings AS (
SELECT b.genre, r.book_average_rating
FROM books b
JOIN ratings r ON b.book_id = r.book_id
)
SELECT genre, AVG(book_average_rating) AS average_rating
FROM genre_ratings
GROUP BY genre
ORDER BY average_rating DESC;

-- Publishers with Highest Total Revenue "Using a Window Function"
SELECT publisher, total_publisher_revenue
FROM (
SELECT b.publisher, SUM(r.publisher_revenue) AS total_publisher_revenue,
RANK() OVER (ORDER BY SUM(r.publisher_revenue) DESC) AS revenue_rank
FROM books b
JOIN ratings r ON b.book_id = r.book_id
GROUP BY b.publisher
) AS ranked_publishers
WHERE revenue_rank <= 5;

-- Books Published in a Specific Year with High Ratings "Using a Subquery"
SELECT book_name, author, publishing_year, book_average_rating
FROM (
SELECT b.book_name, b.author, b.publishing_year, r.book_average_rating
FROM books b
JOIN ratings r ON b.book_id = r.book_id
WHERE b.publishing_year = 2012
) AS filtered_books
WHERE book_average_rating > 4.0
ORDER BY book_average_rating DESC;

-- Authors with Multiple Books and Their Average Author Rating "Using a CTE"
WITH author_stats AS (
SELECT b.author, COUNT(b.book_id) AS number_of_books, AVG(r.author_rating) AS average_author_rating
FROM books b
JOIN ratings r ON b.book_id = r.book_id
GROUP BY b.author
)
SELECT author, number_of_books, average_author_rating
FROM author_stats
WHERE number_of_books > 1
ORDER BY number_of_books DESC, average_author_rating DESC;

-- Books with Low Sales but High Average Rating "Using a Subquery"
SELECT book_name, author, book_average_rating, units_sold
FROM (
SELECT b.book_name, b.author, r.book_average_rating, r.units_sold
FROM books b
JOIN ratings r ON b.book_id = r.book_id
) AS high_rated_books
WHERE book_average_rating >= 4.5 AND units_sold < 1000
ORDER BY units_sold DESC, book_average_rating DESC;

-- Calculate Profit Margin for Each Book "Using a CTE"
WITH profit_data AS (
SELECT b.book_name, b.author, r.gross_sales, r.publisher_revenue
FROM books b
JOIN ratings r ON b.book_id = r.book_id
)
SELECT book_name, author, gross_sales, publisher_revenue, (gross_sales - publisher_revenue) AS profit_margin
FROM profit_data
ORDER BY profit_margin DESC;

-- Books with the Highest book_ratings_count in English "Using a Subquery"
SELECT book_name, author, book_ratings_count
FROM (
SELECT b.book_name, b.author, r.book_ratings_count
FROM books b
JOIN ratings r ON b.book_id = r.book_id
WHERE b.language_code = 'en'
) AS english_books
ORDER BY book_ratings_count DESC
LIMIT 5;

-- Total Units Sold and Gross Sales by Publishing Year "Using a CTE"
WITH sales_data AS (
SELECT b.publishing_year, r.units_sold, r.gross_sales
FROM books b
JOIN ratings r ON b.book_id = r.book_id
)
SELECT publishing_year, SUM(units_sold) AS total_units_sold, SUM(gross_sales) AS total_gross_sales
FROM sales_data
GROUP BY publishing_year
ORDER BY publishing_year ASC;

-- Books with Author Rating Higher Than Book Average Rating "Using a Window Function"
SELECT book_name, author, author_rating, book_average_rating
FROM (
SELECT b.book_name, b.author, r.author_rating, r.book_average_rating, (r.author_rating - r.book_average_rating) AS rating_difference
FROM books b
JOIN ratings r ON b.book_id = r.book_id
) AS rating_comparison
WHERE author_rating > book_average_rating
ORDER BY rating_difference DESC;