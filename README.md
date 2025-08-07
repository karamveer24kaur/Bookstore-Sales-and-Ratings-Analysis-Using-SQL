# 📚 Bookstore Sales and Ratings Analysis Using SQL

This project explores sales and rating data for a collection of books using SQL. 
It demonstrates how to build a relational database from CSV files and run advanced queries to uncover insights about authors, publishers, genres, and reader preferences.

---

## 📁 Files Included

- `books.csv` – Book metadata (title, author, genre, year, etc.)
- `ratings.csv` – Ratings and sales metrics (ratings, revenue, sales, etc.)
- `project3.sql` – SQL script with queries and schema

---

## 🎯 Objective

- Create and normalize a relational database using SQL
- Insert and manage data from two CSV files
- Perform SQL queries using subqueries, CTEs, and window functions
- Generate insights about book sales, author performance, and trends

---

## 🛠️ Tools Used

- MySQL Workbench

---

## 🧱 Database Schema

Two tables were created:

### `books`

| Column          | Type         | Description                |
|-----------------|--------------|----------------------------|
| book_id         | INT          | Primary key                |
| book_name       | VARCHAR(255) | Name of the book           |
| author          | VARCHAR(255) | Author of the book         |
| publisher       | VARCHAR(255) | Publishing house           |
| publishing_year | YEAR         | Year of publication        |
| language_code   | VARCHAR(100) | Language of the book       |
| genre           | VARCHAR(255) | Genre/category             |

### `ratings`

| Column             | Type         | Description                        |
|--------------------|--------------|------------------------------------|
| book_id            | INT          | Foreign key                        |
| author_rating      | VARCHAR(100) | Average rating of the author       |
| book_average_rating| FLOAT        | Average rating of the book         |
| book_ratings_count | INT          | Number of ratings                  |
| gross_sales        | FLOAT        | Total gross sales                  |
| publisher_revenue  | FLOAT        | Revenue earned by publisher        |
| sale_price         | FLOAT        | Price per unit                     |
| units_sold         | INT          | Number of units sold               |

---

## 📊 Key Analyses

- 📈 Top-selling books by gross sales  
- ⭐ Average rating by genre  
- 💰 Publishers with the highest revenue  
- 📚 High-rated books published in 2012  
- 🖋️ Prolific authors with their average ratings  
- 🔍 Low-sale but high-rated books (hidden gems)  
- 📈 Profit margin per book  
- 📢 Most rated English-language books  
- 📅 Total sales by publishing year  
- ⚖️ Authors whose rating exceeds their books’ ratings  


---

