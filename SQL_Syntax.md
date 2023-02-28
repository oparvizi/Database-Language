SQL Server Tutorial: 	https://www.sqlservertutorial.net/
SQLite Syntax: 		https://www.sqlitetutorial.net/      
Source: 		https://www.w3schools.com/sql/          
			https://sql-tutorial.de/home/start.php         

-------------------------------------------------------------------------SQL AND, OR and NOT
	
	SELECT column1, column2, ...
	FROM table_name
	WHERE condition1 AND condition2 AND condition3 ...;

	SELECT column1, column2, ...
	FROM table_name
	WHERE condition1 OR condition2 OR condition3 ...;

	SELECT column1, column2, ...
	FROM table_name
	WHERE NOT condition;


-----------------------------------------------------------------------------ORDER BY Syntax

	SELECT column1, column2, ...
	FROM table_name
	ORDER BY column1, column2, ... ASC|DESC;

--------------------------------------------------------------------------INSERT INTO Syntax
	
	INSERT INTO table_name (column1, column2, column3, ...)
	VALUES (value1, value2, value3, ...);

	INSERT INTO table_name
	VALUES (value1, value2, value3, ...);

-----------------------------------------------------------------------------SQL NULL Values

	SELECT column_names
	FROM table_name
	WHERE column_name IS NULL;

	SELECT column_names
	FROM table_name
	WHERE column_name IS NOT NULL;

-------------------------------------------------------------------------------UPDATE Syntax

	UPDATE table_name
	SET column1 = value1, column2 = value2, ...
	WHERE condition;

-------------------------------------------------------------------------------DELETE Syntax
	
	DELETE FROM table_name WHERE condition;

-----------------------------------------------------------------------SQL SELECT TOP Clause
	
	# SQL Server / MS Access Syntax--------------

	SELECT TOP number|percent column_name(s)
	FROM table_name
	WHERE condition;

	# MySQL Syntax--------------------------------

	SELECT column_name(s)
	FROM table_name
	WHERE condition
	LIMIT number;

	# Oracle 12 Syntax----------------------------

	SELECT column_name(s)
	FROM table_name
	ORDER BY column_name(s)
	FETCH FIRST number ROWS ONLY;

	# Older Oracle Syntax-------------------------

	SELECT column_name(s)
	FROM table_name
	WHERE ROWNUM <= number;

	# Older Oracle Syntax (with ORDER BY)---------

	SELECT *
	FROM (SELECT column_name(s) FROM table_name ORDER BY column_name(s))
	WHERE ROWNUM <= number;

----------------------------------------------MIN(), MAX(), COUNT(), AVG() and SUM() Syntax

	SELECT MIN(column_name), MAX(column_name), COUNT(column_name), AVG(column_name), SUM(column_name)
	FROM table_name
	WHERE condition;

--------------------------------------------------------------------------------LIKE Syntax
	
	SELECT column1, column2, ...
	FROM table_name
	WHERE columnN LIKE pattern;

--------------------------------------------------------------------SQL Wildcard Characters
		
	## Wildcard Characters in MS Access------------

	Symbol	Description							Example
	*	Represents zero or more characters				bl* finds bl, black, blue, and blob
	?	Represents a single character					h?t finds hot, hat, and hit
	[]	Represents any single character within the brackets		h[oa]t finds hot and hat, but not hit
	!	Represents any character not in the brackets			h[!oa]t finds hit, but not hot and hat
	-	Represents any single character within the specified range	c[a-b]t finds cat and cbt
	#	Represents any single numeric character				2#5 finds 205, 215, 225, 235, 245, 255, 265, 275, 285, and 295

	## Wildcard Characters in SQL Server-----------

	Symbol	Description							Example
	%	Represents zero or more characters				bl% finds bl, black, blue, and blob
	_	Represents a single character					h_t finds hot, hat, and hit
	[]	Represents any single character within the brackets		h[oa]t finds hot and hat, but not hit
	^	Represents any character not in the brackets			h[^oa]t finds hit, but not hot and hat
	-	Represents any single character within the specified range	c[a-b]t finds cat and cbt

	# All the wildcards can also be used in combinations! -----------

	LIKE Operator				Description
	WHERE CustomerName LIKE 'a%'		Finds any values that starts with "a"
	WHERE CustomerName LIKE '%a'		Finds any values that ends with "a"
	WHERE CustomerName LIKE '%or%'		Finds any values that have "or" in any position
	WHERE CustomerName LIKE '_r%'		Finds any values that have "r" in the second position
	WHERE CustomerName LIKE 'a__%'		Finds any values that starts with "a" and are at least 3 characters in length
	WHERE ContactName LIKE 'a%o'		Finds any values that starts with "a" and ends with "o"

------------------------------------------------------------------------------------IN Syntax
	
	SELECT column_name(s)
	FROM table_name
	WHERE column_name IN (value1, value2, ...);

	SELECT column_name(s)
	FROM table_name
	WHERE column_name IN (SELECT STATEMENT);

-------------------------------------------------------------------------------BETWEEN Syntax

	SELECT column_name(s)
	FROM table_name
	WHERE column_name BETWEEN value1 AND value2;

----------------------------------------------------------------------------------SQL Aliases
	
	# Alias Column Syntax-----------------

	SELECT column_name AS alias_name
	FROM table_name;

	# Alias Table Syntax------------------

	SELECT column_name(s)
	FROM table_name AS alias_name;

----------------------------------------------------------------------------INNER JOIN Syntax         
<img width="152" alt="image" src="https://user-images.githubusercontent.com/105786517/219944525-51f9332a-3018-4114-a966-2cfef6e31e38.png">          
	
	SELECT column_name(s)
	FROM table1
	INNER JOIN table2
	ON table1.column_name = table2.column_name;

-----------------------------------------------------------------------------LEFT JOIN Syntax       
<img width="162" alt="image" src="https://user-images.githubusercontent.com/105786517/219944550-25077b9f-5caa-4bfe-b5a1-6b2ece91ec95.png">       

	SELECT column_name(s)
	FROM table1
	LEFT JOIN table2
	ON table1.column_name = table2.column_name;

----------------------------------------------------------------------------RIGHT JOIN Syntax     
<img width="152" alt="image" src="https://user-images.githubusercontent.com/105786517/219944570-8b7a7ff7-b3c3-421b-944a-942b4efdf011.png">         

	SELECT column_name(s)
	FROM table1
	RIGHT JOIN table2
	ON table1.column_name = table2.column_name;

------------------------------------------------------------------------FULL OUTER JOIN Syntax     
<img width="160" alt="image" src="https://user-images.githubusercontent.com/105786517/219944617-f7760f6f-d391-41fb-a405-bfdb5d375aa6.png">        

	SELECT column_name(s)
	FROM table1
	FULL OUTER JOIN table2
	ON table1.column_name = table2.column_name
	WHERE condition;

---------------------------------------------------------------------------------SQL Self Join         

	SELECT column_name(s)
	FROM table1 T1, table1 T2
	WHERE condition;

-----------------------------------------------------------------------UNION, UNION ALL Syntax

	SELECT column_name(s) FROM table1
	UNION
	SELECT column_name(s) FROM table2;

	SELECT column_name(s) FROM table1
	UNION ALL
	SELECT column_name(s) FROM table2;

-------------------------------------------------------------------------------GROUP BY Syntax

	SELECT column_name(s)
	FROM table_name
	WHERE condition
	GROUP BY column_name(s)
	ORDER BY column_name(s);

---------------------------------------------------------------------------------HAVING Syntax

	SELECT column_name(s)
	FROM table_name
	WHERE condition
	GROUP BY column_name(s)
	HAVING condition
	ORDER BY column_name(s);

---------------------------------------------------------------------------------EXISTS Syntax

	SELECT column_name(s)
	FROM table_name
	WHERE EXISTS
	(SELECT column_name FROM table_name WHERE condition);

----------------------------------------------ANY, ALL, ALL Syntax With WHERE or HAVING Syntax

	SELECT column_name(s)
	FROM table_name
	WHERE column_name operator ANY
	  (SELECT column_name
	  FROM table_name
	  WHERE condition);

	SELECT ALL column_name(s)
	FROM table_name
	WHERE condition;

	SELECT column_name(s)
	FROM table_name
	WHERE column_name operator ALL
	  (SELECT column_name
	  FROM table_name
	  WHERE condition);

----------------------------------------------------------------------------SELECT INTO Syntax

	SELECT *
	INTO newtable [IN externaldb]
	FROM oldtable
	WHERE condition;

	SELECT column1, column2, column3, ...
	INTO newtable [IN externaldb]
	FROM oldtable
	WHERE condition;

---------------------------------------------------------------------INSERT INTO SELECT Syntax

	INSERT INTO table2
	SELECT * FROM table1
	WHERE condition;

	INSERT INTO table2 (column1, column2, column3, ...)
	SELECT column1, column2, column3, ...
	FROM table1
	WHERE condition;

-----------------------------------------------------------------------------------CASE Syntax

	CASE
	    WHEN condition1 THEN result1
	    WHEN condition2 THEN result2
	    WHEN conditionN THEN resultN
	    ELSE result
	END;

---------------------------------------SQL IFNULL(), ISNULL(), COALESCE(), and NVL() Functions     
<img width="554" alt="image" src="https://user-images.githubusercontent.com/105786517/219945326-66130f08-0398-48e9-92a0-792d3b680cf9.png">        

	# IFNULL(), COALESCE()--------------------MySQL
	SELECT ProductName, UnitPrice * (UnitsInStock + IFNULL(UnitsOnOrder, 0))
	FROM Products;

	SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
	FROM Products;

	# ISNULL(), COALESCE()-------------- SQL Server
	SELECT ProductName, UnitPrice * (UnitsInStock + ISNULL(UnitsOnOrder, 0))
	FROM Products;

	SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
	FROM Products;

	# IsNull()----------------------------MS Access
	SELECT ProductName, UnitPrice * (UnitsInStock + IIF(IsNull(UnitsOnOrder), 0, UnitsOnOrder))
	FROM Products;

	# NVL(), COALESCE()--------------------- Oracle
	SELECT ProductName, UnitPrice * (UnitsInStock + NVL(UnitsOnOrder, 0))
	FROM Products;

	SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
	FROM Products;

------------------------------------------------------------------------Stored Procedure Syntax

	CREATE PROCEDURE procedure_name
	AS
	sql_statement
	GO;

---------------------------------------------------------------------Execute a Stored Procedure
	
	EXEC procedure_name;

---------------------------------------------------------------------------Single Line Comments
	
	Single line comments start with --.

	SELECT * FROM Customers -- WHERE City='Berlin';

	--Select all:
	SELECT * FROM Customers;

----------------------------------------------------------------------------------SQL Operators

	# Arithmetic--------------------
	Operator  	Description	
	+	 	Add	
	-	  	Subtract	
	*	  	Multiply	
	/	 	Divide	
	%	  	Modulo
	# Comparison -------------------
	Operator	Description	
	=		Equal to	
	>		Greater than	
	<		Less than	
	>=		Greater than or equal to	
	<=		Less than or equal to	
	<>		Not equal to




## SQLite * JOIN--------------------------
INNER JOIN:
Suppose you have two tables: A and B.
A has a1, a2, and f columns. B has b1, b2, and f column. The A table links to the B table using a foreign key column named f.
The following illustrates the syntax of the inner join clause:

    SELECT a1, a2, b1, b2
    FROM A
    INNER JOIN B on B.f = A.f;
LEFT JOIN:
Suppose we have two tables: A and B.
A has m and f columns.
B has n and f columns.
To perform join between A and B using LEFT JOIN clause, you use the following statement:

    SELECT
        a,
        b
    FROM
        A
    LEFT JOIN B ON A.f = B.f
    WHERE search_condition;
CROSS JOIN:
Suppose, the A table has N rows and B table has M rows, the CROSS JOIN of these two tables will produce a result set that contains NxM rows.

    SELECT *
    FROM A JOIN B;
   
    SELECT *
    FROM A
    INNER JOIN B;
    
    SELECT *
    FROM A
    CROSS JOIN B;
    
    SELECT * 
    FROM A, B;
Self-Join:
The self-join is a special kind of joins that allow you to join a table to itself using either LEFT JOIN or INNER JOIN clause. You use self-join to create a result set that joins the rows with the other rows within the same table.
Because you cannot refer to the same table more than one in a query, you need to use a table alias to assign the table a different name when you use self-join.
The self-join compares values of the same or different columns in the same table. Only one table is involved in the self-join.
You often use self-join to query parents/child relationship stored in a table or to obtain running totals.

    SELECT m.firstname || ' ' || m.lastname AS 'Manager',
       e.firstname || ' ' || e.lastname AS 'Direct report' 
    FROM employees e
    INNER JOIN employees m ON m.employeeid = e.reportsto
    ORDER BY manager;

    SELECT DISTINCT
        e1.city,
        e1.firstName || ' ' || e1.lastname AS fullname
    FROM
        employees e1
    INNER JOIN employees e2 ON e2.city = e1.city 
       AND (e1.firstname <> e2.firstname AND e1.lastname <> e2.lastname)
    ORDER BY
        e1.city;
FULL OUTER JOIN:
ULL OUTER JOIN is a combination of  a LEFT JOIN and a RIGHT JOIN. The result set of the full outer join has NULL values for every column of the table that does not have a matching row in the other table. For the matching rows, the FULL OUTER JOIN produces a single row with values from columns of the rows in both tables.

    -- create and insert data into the dogs table
    CREATE TABLE dogs (
        type       TEXT,
        color TEXT
    );
    INSERT INTO dogs(type, color) 
    VALUES('Hunting','Black'), ('Guard','Brown');
    -- create and insert data into the cats table
    CREATE TABLE cats (
        type       TEXT,
        color TEXT
    );
    INSERT INTO cats(type,color) 
    VALUES('Indoor','White'), 
          ('Outdoor','Black');

    SELECT * FROM dogs FULL OUTER JOIN cats ON dogs.color = cats.color; 

## Grouping data 
   Group By – combine a set of rows into groups based on specified criteria. The GROUP BY clause helps you summarize data for reporting purposes.
   Aggregate_function: MIN, MAX, SUM, COUNT, round or AVG
    
    SELECT 
        column_1,
        aggregate_function(column_2) 
    FROM 
        table
    GROUP BY 
        column_1,
        column_2;
   
   Having   – specify the conditions to filter the groups summarized by the GROUP BY clause.  
   
    SELECT
        column_1, 
            column_2,
        aggregate_function (column_3)
    FROM
        table
    GROUP BY
        column_1,
            column_2
    HAVING
        search_condition; 

## Set operators
   Union – combine result sets of multiple queries into a single result set. We also discuss the differences between UNION and UNION ALL clauses.
   
    query_1
    UNION [ALL]
    query_2
    UNION [ALL]
    query_3
    ...;
    
   Except – compare the result sets of two queries and returns distinct rows from the left query that are not output by the right query.
   
    SELECT select_list1
    FROM table1
    EXCEPT
    SELECT select_list2
    FROM table2

   Intersect – compare the result sets of two queries and returns distinct rows that are output by both queries.
    
    SELECT select_list1
    FROM table1
    INTERSECT
    SELECT select_list2
    FROM table2
   
## Subquery
   Subquery – introduce you to the SQLite subquery and correlated subquery.
   A subquery is a SELECT statement nested in another statement. See the following statement.

    SELECT column_1
    FROM table_1
    WHERE column_1 = (
       SELECT column_1 
       FROM table_2
    );
   The following query is the outer query:

    SELECT column_1
      FROM table_1
     WHERE colum_1 =
   And the following query is the subquery.

    (SELECT column_1
      FROM table_2)
   
   
   Exists operator – test for the existence of rows returned by a subquery.
    
    EXISTS(subquery)
    NOT EXISTS (subquery)
   Case – add conditional logic to the query.
   The CASE expression is similar to the IF-THEN-ELSE statement in other programming languages.
   
    CASE case_expression
         WHEN when_expression_1 THEN result_1
         WHEN when_expression_2 THEN result_2
         ...
         [ ELSE result_else ] 
    END
## Changing data
   Insert – insert rows into a table
   
    INSERT INTO table (column1,column2 ,..)
    VALUES( value1,	value2 ,...);
   Update – update existing rows in a table.
   
    UPDATE table
    SET column_1 = new_value_1,
        column_2 = new_value_2
    WHERE
        search_condition 
    ORDER column_or_expression
    LIMIT row_count OFFSET offset;
   Delete – delete rows from a table.
   
    DELETE FROM table
    WHERE search_condition
    ORDER BY criteria
    LIMIT row_count OFFSET offset;
   Replace – insert a new row or replace the existing row in a table.
   
    INSERT OR REPLACE INTO table(column_list)
    VALUES(value_list);
    
    REPLACE INTO table(column_list)
    VALUES(value_list);
    
    CREATE TABLE IF NOT EXISTS positions (
	id INTEGER PRIMARY KEY,
	title TEXT NOT NULL,
	min_salary NUMERIC
    );

## Transactions
   Transaction – show you how to handle transactions in SQLite.
   Open a transaction
   
    BEGIN TRANSACTION;
   Select or update data in the database. Note that the change is only visible to the current session (or client).
    COMMIT; 
    COMMIT TRANSACTION;
   If you do not want to save the changes, you can roll back using the ROLLBACK or ROLLBACK TRANSACTION statement:
   
    ROLLBACK;
    ROLLBACK TRANSACTION
   EXAMPLE1:
   
    CREATE TABLE accounts ( 
	account_no INTEGER NOT NULL, 
	balance DECIMAL NOT NULL DEFAULT 0,
	PRIMARY KEY(account_no),
        CHECK(balance >= 0)
    );

    CREATE TABLE account_changes (
        change_no INT NOT NULL PRIMARY KEY,
        account_no INTEGER NOT NULL, 
        flag TEXT NOT NULL, 
        amount DECIMAL NOT NULL, 
        changed_at TEXT NOT NULL 
    );
    INSERT INTO accounts (account_no,balance)
    VALUES (100,20100);
    INSERT INTO accounts (account_no,balance)
    VALUES (200,10100);
    SELECT * FROM accounts;
    
    BEGIN TRANSACTION;
    UPDATE accounts
       SET balance = balance - 1000
     WHERE account_no = 100;
    UPDATE accounts
       SET balance = balance + 1000
     WHERE account_no = 200;
    INSERT INTO account_changes(account_no,flag,amount,changed_at) 
    VALUES(100,'-',1000,datetime('now'));
    INSERT INTO account_changes(account_no,flag,amount,changed_at) 
    VALUES(200,'+',1000,datetime('now'));
    COMMIT;
    
    SELECT * FROM accounts;
    SELECT * FROM account_changes;
   EXAMPLE2:  
     
    BEGIN TRANSACTION;
    UPDATE accounts
       SET balance = balance - 20000
    WHERE account_no = 100;
    INSERT INTO account_changes(account_no,flag,amount,changed_at) 
    VALUES(100,'-',20000,datetime('now'));  
    [SQLITE_CONSTRAINT]  Abort due to constraint violation (CHECK constraint failed: accounts)
    SELECT * FROM account_changes;
    ROLLBACK;
    SELECT * FROM account_changes;
       
## Data definition
   SQLite Data Types – introduce you to the SQLite dynamic type system and its important concepts: storage classes, manifest typing, and type affinity.
   
    SELECT
	typeof(100),
	typeof(10.0),
	typeof('100'),
	typeof(x'1000'),
	typeof(NULL);
   Create Table – show you how to create a new table in the database.
   
    CREATE TABLE [IF NOT EXISTS] [schema_name].table_name (
	column_1 data_type PRIMARY KEY,
   	column_2 data_type NOT NULL,
	column_3 data_type DEFAULT 0,
	table_constraints
	) [WITHOUT ROWID];
   
   Alter Table – show you how to use modify the structure of an existing table.
   * https://www.sqlitetutorial.net/sqlite-alter-table/
   
    ALTER TABLE existing_table
    RENAME TO new_table;

   Rename column – learn step by step how to rename a column of a table.
    
    ALTER TABLE table_name
    RENAME COLUMN current_name TO new_name;
   
   Drop Table – guide you on how to remove a table from the database.
   
    DROP TABLE [IF EXISTS] [schema_name.]table_name;
   VACUUM – show you how to optimize database files.
   
    VACUUM;
    PRAGMA auto_vacuum = FULL;
    PRAGMA auto_vacuum = INCREMENTAL;
    PRAGMA auto_vacuum = NONE;
    VACUUM schema-name INTO filename;

    VACUUM main INTO 'c:\sqlite\db\chinook_backup.db';
## Constraints
   Primary Key – show you how to define the primary key for a table.
   
    CREATE TABLE table_name(
    column_1 INTEGER NOT NULL PRIMARY KEY,
    ...
    );
    
    CREATE TABLE table_name(
    column_1 INTEGER NOT NULL,
    column_2 INTEGER NOT NULL,
    ...
    PRIMARY KEY(column_1,column_2,...)
    );
   
    CREATE TABLE table(
    pk INTEGER PRIMARY KEY DESC,
    ...
    );
   NOT NULL constraint – learn how to enforce values of columns that are not NULL.
   
    CREATE TABLE table_name (
    ...,
    column_name type_name NOT NULL,
    ...
    );
   UNIQUE constraint – ensure values in a column or a group of columns are unique.
   for a column at the column level:
   
    CREATE TABLE table_name(
    ...,
    column_name type UNIQUE,
    ...
    );
  Or at the table level:
  
    CREATE TABLE table_name(
    ...,
    UNIQUE(column_name)
    );
  constraint for multiple columns:
  
    CREATE TABLE table_name(
    ...,
    UNIQUE(column_name1,column_name2,...)
    );
   
   CHECK constraint – ensure the values in a column meet a specified condition defined by an expression.
   
    CREATE TABLE table_name(
    ...,
    column_name data_type CHECK(expression),
    ...
    );
   
    CREATE TABLE table_name(
    ...,
    CHECK(expression)
    );   
   AUTOINCREMENT – explain how the AUTOINCREMENT column attribute works and why you should avoid using it.

## Views
   Create View – introduce you to the view concept and show you how to create a new view in the database.
   
    CREATE [TEMP] VIEW [IF NOT EXISTS] view_name[(column-name-list)]
    AS 
      select-statement;
   Drop View – show you how to drop a view from its database schema.
   
    DROP VIEW [IF EXISTS] [schema_name.]view_name;
## Indexes
   Index – teach you about the index and how to utilize indexes to speed up your queries.
  
    CREATE [UNIQUE] INDEX index_name 
    ON table_name(column_list);
   Index for Expressions – show you how to use the expression-based index.

## Triggers
   Trigger – manage triggers in the SQLite database.
   
    CREATE TRIGGER [IF NOT EXISTS] trigger_name 
    	[BEFORE|AFTER|INSTEAD OF] [INSERT|UPDATE|DELETE] 
    	ON table_name
    	[WHEN condition]
    BEGIN
    	statements;
    END;
   Create INSTEAD OF triggers – learn about INSTEAD OF triggers and how to create an INSTEAD OF trigger to update data via a view.
   
    CREATE TRIGGER [IF NOT EXISTS] schema_ame.trigger_name
    	INSTEAD OF [DELETE | INSERT | UPDATE OF column_name]
    	ON table_name
    BEGIN
    	-- insert code here
    END;
## Full-text search
   Full-text search – get started with the full-text search in SQLite.
   
    CREATE VIRTUAL TABLE table_name 
    USING FTS5(column1,column2...);
## SQLite tools
   SQLite Commands – show you the most commonly used command in the sqlite3 program.
   
    .table '%es'
    .schema albums
    .fullschema
    .indexes albums
    .indexes %es
    .output albums.txt
    
    .mode column
    .header on
    .read c:/sqlite/commands.txt 
   SQLite Show Tables – list all tables in a database.
   create a new temporary table named temp_table1:
   
    CREATE TEMPORARY TABLE temp_table1( name TEXT );
    .tables pattern
    .table 'a%'
   SQLite Describe Table – show the structure of a table.
   
    .schema table_name
    .header on
    .mode column
    pragma table_info('albums');
   SQLite Dump – how to use the .dump command to back up and restore a database.
   Dump the entire database
   
    sqlite> .output c:/sqlite/chinook.sql
    sqlite> .dump
    sqlite> .exit
   Dump a specific table 
   
    sqlite> .output c:/sqlite/albums.sql
    sqlite> .dump albums
    sqlite> .quit
   SQLite Import CSV – import CSV files into a table.
   
    sqlite> .mode csv
    sqlite> .import c:/sqlite/city_no_header.csv cities
   SQLite Export CSV – export an SQLite database to CSV files.

    >sqlite3 c:/sqlite/chinook.db
    sqlite> .headers on
    sqlite> .mode csv
    sqlite> .output data.csv
    sqlite> SELECT customerid,
    ...>        firstname,
    ...>        lastname,
    ...>        company
    ...>   FROM customers;
    sqlite> .quit
