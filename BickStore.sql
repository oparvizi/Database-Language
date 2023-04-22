select @@VERSION
-- Section 1. Querying data & Section 2. Sorting data---------
SELECT * FROM sales.customers;
SELECT first_name, last_name, email FROM sales.customers;
SELECT * FROM sales.customers WHERE state = 'NY';
SELECT * FROM sales.customers WHERE email = 'theo.reese@gmail.com'; 
SELECT * FROM sales.customers WHERE state = 'CA' ORDER BY first_name; 
SELECT city, COUNT(*) FROM sales.customers WHERE state = 'CA' GROUP BY city  ORDER BY city;
SELECT city, COUNT(*) FROM sales.customers WHERE state = 'CA'  GROUP BY city HAVING COUNT(*)>10  ORDER BY city;
SELECT city, first_name FROM sales.customers ORDER BY city DESC, first_name ASC;

SELECT product_name, list_price FROM production.products ORDER BY list_price DESC, product_name OFFSET 0 ROWS FETCH FIRST 20 ROWS ONLY;
SELECT product_name, list_price FROM production.products ORDER BY list_price DESC, product_name OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- Section 3. Limiting rows-----------------------------------
SELECT TOP 1 PERCENT product_name, list_price FROM production.products ORDER BY list_price DESC;
SELECT TOP 3 WITH TIES product_name, list_price FROM production.products ORDER BY list_price DESC;

-- Section 4. Filtering data----------------------------------
SELECT city, state, zip_code FROM sales.customers GROUP BY city, state, zip_code ORDER BY city, state, zip_code;
SELECT DISTINCT city, state, zip_code FROM sales.customers;
SELECT product_id, product_name, category_id, model_year, list_price FROM production.products WHERE category_id = 1 AND model_year = 2018 ORDER BY list_price DESC;
SELECT product_id, product_name, category_id, model_year, list_price FROM production.products WHERE list_price > 3000 OR model_year = 2018 ORDER BY list_price DESC;
SELECT product_id, product_name, category_id, model_year, list_price FROM production.products WHERE list_price BETWEEN 1899.00 AND 1999.99 ORDER BY list_price DESC;
SELECT product_id, product_name, category_id, model_year, list_price FROM production.products WHERE list_price IN (299.99, 369.99, 489.99) ORDER BY list_price DESC;
SELECT product_id, product_name, category_id, model_year, list_price FROM production.products WHERE product_name LIKE '%Cruiser%' ORDER BY list_price DESC;
SELECT first_name + ' ' + last_name AS full_name FROM sales.customers ORDER BY first_name;
SELECT first_name + ' ' + last_name AS 'Full Name' FROM sales.customers ORDER BY first_name;

-- Section 5. Joining tables----------------------------------
SELECT sales.customers.customer_id, first_name, last_name, order_id FROM sales.customers INNER JOIN sales.orders ON sales.orders.customer_id = sales.customers.customer_id;
SELECT c.customer_id, first_name, last_name, order_id FROM sales.customers c 
	INNER JOIN sales.orders o ON o.customer_id = c.customer_id;
SELECT product_name, category_name, brand_name, list_price FROM production.products p 
	INNER JOIN production.categories c ON c.category_id = p.category_id 
	INNER JOIN production.brands b ON b.brand_id = p.brand_id ORDER BY product_name DESC;

SELECT p.product_name, o.order_id, i.item_id, o.order_date FROM production.products p 
	LEFT JOIN sales.order_items i ON i.product_id = p.product_id 
	LEFT JOIN sales.orders o ON o.order_id = i.order_id ORDER BY order_id;
SELECT p.product_id, product_name, order_id FROM production.products p 
	LEFT JOIN sales.order_items o ON o.product_id = p.product_id AND o.order_id = 100 ORDER BY order_id DESC;

SELECT product_name, order_id FROM sales.order_items o 
	RIGHT JOIN production.products p ON o.product_id = p.product_id ORDER BY order_id;
SELECT product_name, order_id FROM sales.order_items o 
	RIGHT JOIN production.products p ON o.product_id = p.product_id WHERE order_id IS NULL ORDER BY product_name;

SELECT product_id, product_name, store_id, 0 AS quantity FROM production.products 
	CROSS JOIN sales.stores ORDER BY product_name, store_id;
--------------------------------------------------------------
SELECT
    s.store_id,
    p.product_id,
    ISNULL(sales, 0) sales
FROM
    sales.stores s
CROSS JOIN production.products p
LEFT JOIN (
    SELECT
        s.store_id,
        p.product_id,
        SUM (quantity * i.list_price) sales
    FROM
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.stores s ON s.store_id = o.store_id
    INNER JOIN production.products p ON p.product_id = i.product_id
    GROUP BY
        s.store_id,
        p.product_id
) c ON c.store_id = s.store_id
AND c.product_id = p.product_id
WHERE
    sales IS NULL
ORDER BY
    product_id,
    store_id;
-- self join
SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id > c2.customer_id
AND c1.city = c2.city
WHERE c1.city = 'Albany'
ORDER BY
    c1.city,
    customer_1,
    customer_2;
-- self join
SELECT
    c1.city,
	c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id <> c2.customer_id
AND c1.city = c2.city
WHERE c1.city = 'Albany'
ORDER BY
	c1.city,
    customer_1,
    customer_2;

-- Section 6. Grouping data-----------------------------------
SELECT customer_id, YEAR (order_date) order_year FROM sales.orders WHERE customer_id IN (1, 2) ORDER BY customer_id;
SELECT customer_id, YEAR (order_date) order_year FROM sales.orders WHERE customer_id IN (1, 2) GROUP BY customer_id, YEAR (order_date) ORDER BY customer_id;
SELECT DISTINCT customer_id, YEAR (order_date) order_year FROM sales.orders WHERE customer_id IN (1, 2) ORDER BY customer_id;
SELECT customer_id, YEAR (order_date) order_year, COUNT (order_id) order_placed FROM sales.orders WHERE customer_id IN (1, 2) GROUP BY customer_id, YEAR (order_date) ORDER BY customer_id;
SELECT city, COUNT (customer_id) customer_count FROM sales.customers GROUP BY city ORDER BY city;
SELECT city, state, COUNT (customer_id) customer_count FROM sales.customers GROUP BY state, city ORDER BY city, state;
SELECT brand_name, MIN (list_price) min_price, MAX (list_price) max_price FROM production.products p INNER JOIN production.brands b ON b.brand_id = p.brand_id WHERE model_year = 2018 GROUP BY brand_name ORDER BY brand_name;
SELECT brand_name, AVG (list_price) avg_price FROM production.products p INNER JOIN production.brands b ON b.brand_id = p.brand_id WHERE model_year = 2018 GROUP BY brand_name ORDER BY brand_name;

SELECT customer_id, YEAR (order_date), COUNT (order_id) order_count FROM sales.orders GROUP BY customer_id, YEAR (order_date) HAVING COUNT (order_id) >= 2 ORDER BY customer_id;
SELECT order_id, SUM ( quantity * list_price * (1 - discount) ) net_value FROM sales.order_items GROUP BY order_id HAVING SUM ( quantity * list_price * (1 - discount) ) > 20000 ORDER BY net_value;
SELECT category_id, MAX (list_price) max_list_price, MIN (list_price) min_list_price FROM production.products GROUP BY category_id HAVING MAX (list_price) > 4000 OR MIN (list_price) < 500;
SELECT category_id, AVG (list_price) avg_list_price FROM production.products GROUP BY category_id HAVING AVG (list_price) BETWEEN 500 AND 1000;

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;

SELECT * FROM sales.sales_summary ORDER BY brand, category, model_year;
SELECT SUM (sales) sales FROM sales.sales_summary;
-- GROUPING SETS
SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    category
UNION ALL
SELECT
    brand,
    NULL,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand
UNION ALL
SELECT
    NULL,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    category
UNION ALL
SELECT
    NULL,
    NULL,
    SUM (sales)
FROM
    sales.sales_summary
ORDER BY brand, category;
-- -----------------------
SELECT
    GROUPING(brand) grouping_brand,
    GROUPING(category) grouping_category,
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    GROUPING SETS (
        (brand, category),
        (brand),
        (category),
        ()
    )
ORDER BY
    brand,
    category;
-- CUBE 
SELECT brand, category, SUM (sales) sales FROM sales.sales_summary GROUP BY CUBE(brand, category);
SELECT brand, category, SUM (sales) sales FROM sales.sales_summary GROUP BY brand, CUBE(category);
-- ROLLUP 
SELECT brand, category, SUM (sales) sales FROM sales.sales_summary GROUP BY ROLLUP(brand, category);
SELECT brand, category, SUM (sales) sales FROM sales.sales_summary GROUP BY brand, ROLLUP (category);

-- Section 7. Subquery----------------------------------------
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > (
        SELECT
            AVG (list_price)
        FROM
            production.products
        WHERE
            brand_id IN (
                SELECT
                    brand_id
                FROM
                    production.brands
                WHERE
                    brand_name = 'Strider'
                OR brand_name = 'Trek'
            )
    )
ORDER BY
    list_price;

SELECT brand_id FROM production.brands WHERE brand_name = 'Strider' OR brand_name = 'Trek';
SELECT AVG (list_price) FROM production.products WHERE brand_id IN (6,9);
SELECT order_id, order_date, ( SELECT MAX (list_price) FROM sales.order_items i WHERE i.order_id = o.order_id ) AS max_list_price FROM sales.orders o order by order_date desc;

SELECT
    product_id,
    product_name
FROM
    production.products
WHERE
    category_id IN (
        SELECT
            category_id
        FROM
            production.categories
        WHERE
            category_name = 'Mountain Bikes'
        OR category_name = 'Road Bikes'
    );
-- Correlated subquery
SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products p1
WHERE
    list_price IN (
        SELECT
            MAX (p2.list_price)
        FROM
            production.products p2
        WHERE
            p2.category_id = p1.category_id
        GROUP BY
            p2.category_id
    )
ORDER BY
    category_id,
    product_name;
-- EXISTS 
SELECT * FROM sales.orders WHERE customer_id IN ( SELECT customer_id FROM sales.customers WHERE city = 'San Jose' ) ORDER BY customer_id, order_date;
SELECT * FROM sales.orders o WHERE EXISTS ( SELECT customer_id FROM sales.customers c WHERE o.customer_id = c.customer_id AND city = 'San Jose' ) ORDER BY o.customer_id, order_date;
-- ANY & ALL
SELECT product_name, list_price FROM production.products WHERE product_id = ANY ( SELECT product_id FROM sales.order_items WHERE quantity >= 2 ) ORDER BY product_name;
SELECT product_name, list_price FROM production.products WHERE list_price < ALL ( SELECT AVG (list_price) avg_list_price FROM production.products GROUP BY brand_id ) ORDER BY list_price DESC;

-- Section 8. Set Operators-----------------------------------
-- UNION
SELECT first_name, last_name FROM sales.staffs UNION SELECT first_name, last_name FROM sales.customers;
SELECT first_name, last_name FROM sales.staffs UNION ALL SELECT first_name, last_name FROM sales.customers ORDER BY first_name, last_name;
-- INTERSECT
SELECT city FROM sales.customers INTERSECT SELECT city FROM sales.stores ORDER BY city;
-- EXCEPT 
SELECT product_id FROM production.products EXCEPT SELECT product_id FROM sales.order_items ORDER BY product_id;

-- Section 9. Common Table Expression (CTE)-------------------
WITH cte_org AS (
    SELECT       
        staff_id, 
        first_name,
        manager_id
        
    FROM       
        sales.staffs
    WHERE manager_id IS NULL
    UNION ALL
    SELECT 
        e.staff_id, 
        e.first_name,
        e.manager_id
    FROM 
        sales.staffs e
        INNER JOIN cte_org o 
            ON o.staff_id = e.manager_id
)
SELECT * FROM cte_org;

-- Section 10. Pivot------------------------------------------
SELECT * FROM   
(
    SELECT 
        category_name, 
        product_id,
		model_year
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
) t 
PIVOT(
    COUNT(product_id) 
    FOR category_name IN (
        [Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes])
) AS pivot_table;
-- Generating column values------------
DECLARE 
    @columns NVARCHAR(MAX) = '';

SELECT 
    @columns += QUOTENAME(category_name) + ','
FROM 
    production.categories
ORDER BY 
    category_name;

SET @columns = LEFT(@columns, LEN(@columns) - 1);

PRINT @columns;
-- Dynamic pivot tables----------------
DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

-- select the category names
SELECT 
    @columns+=QUOTENAME(category_name) + ','
FROM 
    production.categories
ORDER BY 
    category_name;

-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);

-- construct dynamic SQL
SET @sql ='
SELECT * FROM   
(
    SELECT 
        category_name, 
        model_year,
        product_id 
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
) t 
PIVOT(
    COUNT(product_id) 
    FOR category_name IN ('+ @columns +')
) AS pivot_table;';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;

-- Section 11. Modifying data---------------------------------
--INSERT INTO table_name (column_list) VALUES (value_list);
--INSERT INTO table_name (column_list) VALUES (value_list_1), (value_list_2),...(value_list_n);
--INSERT  [ TOP ( expression ) [ PERCENT ] ] INTO target_table (column_list) query
--UPDATE table_name SET c1 = v1, c2 = v2, ... cn = vn [WHERE condition]
--UPDATE t1 SET t1.c1 = t2.c2, t1.c2 = expression, ... FROM t1 [INNER | LEFT] JOIN t2 ON join_predicate WHERE where_predicate;
--DELETE [ TOP ( expression ) [ PERCENT ] ] FROM table_name [WHERE search_condition];
--MERGE target_table USING source_table ON merge_condition WHEN MATCHED THEN update_statement WHEN NOT MATCHED THEN insert_statement WHEN NOT MATCHED BY SOURCE THEN DELETE;

-- Section 12. Data definition--------------------------------
--CREATE DATABASE			– show you how to create a new database in a SQL Server instance using the CREATE DATABASE statement and SQL Server Management Studio.
--DROP DATABASE				– learn how to delete existing databases.
--CREATE SCHEMA				– describe how to create a new schema in a database.
--ALTER SCHEMA				– show how to transfer a securable from a schema to another within the same database.
--DROP SCHEMA				– learn how to delete a schema from a database.
--CREATE TABLE				– walk you through the steps of creating a new table in a specific schema of a  database.
--Identity column			– learn how to use the IDENTITY property to create the identity column for a table.
--Sequence					– describe how to generate a sequence of numeric values based on a specification.
--ALTER TABLE ADD column	– show you how to add one or more columns to an existing table
--ALTER TABLE ALTER COLUMN	– show you how to change the definition of existing columns in a table.
--ALTER TABLE DROP COLUMN	– learn how to drop one or more columns from a table.
--Computed columns			– how to use the computed columns to resue the calculation logic in multiple queries.
--DROP TABLE				– show you how to delete tables from the database.
--TRUNCATE TABLE			– delete all data from a table faster and more efficiently.
--SELECT INTO				– learn how to create a table and insert data from a query into it.
--Rename a table			–  walk you through the process of renaming a table to a new one.
--Temporary tables			– introduce you to the temporary tables for storing temporarily immediate data in stored procedures or database session.
--Synonym					– explain you the synonym and show you how to create synonyms for database objects.

-- Section 13. SQL Server Data Types-------------------------
--BIT				– store bit data i.e., 0, 1, or NULL in the database with the BIT data type.
--INT				– learn about various integer types in SQL server including BIGINT, INT, SMALLINT, and TINYINT.
--DECIMAL			– show you how to store exact numeric values in the database by using DECIMAL or NUMERIC data type.
--CHAR				– learn how to store fixed-length, non-Unicode character string in the database.
--NCHAR				– show you how to store fixed-length, Unicode character strings and explain the differences between CHAR and NCHAR data types
--VARCHAR			– store variable-length, non-Unicode string data in the database.
--NVARCHAR			– learn how to store variable-length, Unicode string data in a table and understand the main differences between VARCHAR and NVARCHAR.
--DATETIME2			– illustrate how to store both date and time data in a database.
--DATE				– discuss the date data type and how to store the dates in the table.
--TIME				– show you how to store time data in the database by using the TIME data type.
--DATETIMEOFFSET	– show you how to manipulate datetime with the time zone.
--GUID				– learn about the GUID and how to use the NEWID() function to generate GUID values.

-- Section 14. Constraints------------------------------------
--Primary key			– explain you to the primary key concept and show you how to use the primary key constraint to manage a primary key of a table.
--Foreign key			– introduce you to the foreign key concept and show you use the FOREIGN KEY constraint to enforce the link of data in two tables.
--NOT NULL constraint	– show you how to ensure a column not to accept NULL.
--UNIQUE constraint		– ensure that data contained in a column, or a group of columns, is unique among rows in a table.
--CHECK constraint		– walk you through the process of adding logic for checking data before storing them in tables.

-- Section 15. Expressions------------------------------------
--CASE – add if-else logic to SQL queries by using simple and searched CASE expressions.
-- CASE input WHEN e1 THEN r1 WHEN e2 THEN r2 ... WHEN en THEN rn [ ELSE re ] END
SELECT order_status, COUNT(order_id) order_count FROM sales.orders WHERE YEAR(order_date) = 2018 GROUP BY order_status;
SELECT CASE order_status WHEN 1 THEN 'Pending' WHEN 2 THEN 'Processing' WHEN 3 THEN 'Rejected' WHEN 4 THEN 'Completed' END 
		AS order_status, COUNT(order_id) order_count FROM sales.orders WHERE YEAR(order_date) = 2018 GROUP BY order_status;

SELECT SUM(CASE WHEN order_status = 1 THEN 1 ELSE 0 END) AS 'Pending', SUM(CASE WHEN order_status = 2 THEN 1 ELSE 0 END) 
		AS 'Processing', SUM(CASE WHEN order_status = 3 THEN 1 ELSE 0 END) AS 'Rejected', SUM(CASE WHEN order_status = 4 THEN 1 ELSE 0 END) 
		AS 'Completed', COUNT(*) AS Total FROM sales.orders WHERE YEAR(order_date) = 2018;

		SELECT    
    o.order_id, 
    SUM(quantity * list_price) order_value,
    CASE
        WHEN SUM(quantity * list_price) <= 500 
            THEN 'Very Low'
        WHEN SUM(quantity * list_price) > 500 AND 
            SUM(quantity * list_price) <= 1000 
            THEN 'Low'
        WHEN SUM(quantity * list_price) > 1000 AND 
            SUM(quantity * list_price) <= 5000 
            THEN 'Medium'
        WHEN SUM(quantity * list_price) > 5000 AND 
            SUM(quantity * list_price) <= 10000 
            THEN 'High'
        WHEN SUM(quantity * list_price) > 10000 
            THEN 'Very High'
    END order_priority
FROM    
    sales.orders o
INNER JOIN sales.order_items i ON i.order_id = o.order_id
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    o.order_id;

--COALESCE – handle NULL values effectively using the COALESCE expression.
--COALESCE(e1,[e2,...,en])
SELECT COALESCE(NULL, 'Hi', 'Hello', NULL) result;
--to substitute NULL by new values
SELECT first_name, last_name, phone, email FROM sales.customers ORDER BY first_name, last_name;
SELECT first_name, last_name, COALESCE(phone,'N/A') phone, email FROM sales.customers ORDER BY first_name, last_name;
--to use the available data
CREATE TABLE salaries ( staff_id INT PRIMARY KEY, hourly_rate decimal, weekly_rate decimal, monthly_rate decimal, CHECK( hourly_rate IS NOT NULL OR weekly_rate IS NOT NULL OR monthly_rate IS NOT NULL) );
INSERT INTO salaries( staff_id, hourly_rate, weekly_rate, monthly_rate ) VALUES (1,20, NULL,NULL), (2,30, NULL,NULL), (3,NULL, 1000,NULL), (4,NULL, NULL,6000); (5,NULL, NULL,6500);
SELECT staff_id, hourly_rate, weekly_rate, monthly_rate FROM salaries ORDER BY staff_id;
SELECT staff_id, COALESCE( hourly_rate*22*8, weekly_rate*4, monthly_rate ) monthly_salary FROM salaries;

--NULLIF – return NULL if the two arguments are equal; otherwise, return the first argument.
--NULLIF(expression1, expression2)
CREATE TABLE sales.leads ( lead_id    INT	PRIMARY KEY IDENTITY, first_name VARCHAR(100) NOT NULL, last_name  VARCHAR(100) NOT NULL, phone      VARCHAR(20), email      VARCHAR(255) NOT NULL );
INSERT INTO sales.leads ( first_name, last_name, phone, email ) VALUES ( 'John', 'Doe', '(408)-987-2345', 'john.doe@example.com' ), ( 'Jane', 'Doe', '', 'jane.doe@example.com' ), ( 'David', 'Doe', NULL, 'david.doe@example.com' );
SELECT lead_id, first_name, last_name, phone, email FROM sales.leads ORDER BY lead_id;
SELECT lead_id, first_name, last_name, phone, email FROM sales.leads WHERE phone IS NULL;
SELECT lead_id, first_name, last_name, phone, email FROM sales.leads WHERE NULLIF(phone,'') IS NULL;


-- Section 16. Useful Tips------------------------------------
--Find duplicates – show you how to find duplicate values in one or more columns of a table.
--Delete duplicates – describe how to remove duplicate rows from a table.