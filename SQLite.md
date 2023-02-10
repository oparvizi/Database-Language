POSIT: Best Practices in Working with Databases:   https://solutions.posit.co/connections/db/

##  R packages: dplyr, DBI, odbc, keyring and pool
    Using an ODBC driver:                       https://solutions.posit.co/connections/db/r-packages/odbc/
    Using DBI:                                  https://solutions.posit.co/connections/db/r-packages/dbi/
    Using dplyr with databases:                 https://solutions.posit.co/connections/db/r-packages/dplyr/
    Pooling database connections in R:          https://solutions.posit.co/connections/db/r-packages/pool/

## Best practices: 
    Creating Visualizations: 
    Enterprise-ready dashboards:
    Making scripts portable:
    Run Queries Safely:
    Schema selection
    Securing Credentials
    Securing Deployed Content
    Selecting a database interface
    Setting up ODBC Drivers
    SQL translation:  https://solutions.posit.co/connections/db/advanced/translation/


## Databases                    https://solutions.posit.co/connections/db/databases/
    Name	                      *Connect via R package     *Posit Pro Driver	*dplyr support
    Amazon Redshift	              	                        
    Apache Hive	                
    Apache Impala	        
    Athena	                
    Cassandra	           	
    Google BigQuery	              bigrquery
    Microsoft SQL Server	 
    MonetDB                       MonetDBLite
    MongoDB	                 		
    MySQL	                      RMariaDB
    Netezza	                 		
    Oracle	                 	                	
    PostgreSQL	                  RPostgres
    SQLite		                  RSQLite
    Salesforce	         		    
    Snowflake	         	                  	
    Teradata	         	                  	
  


# Creating a SQLite database for use with R
source: https://data.library.virginia.edu/creating-a-sqlite-database-for-use-with-r/

NYC OpenDatabase: https://data.cityofnewyork.us/City-Government/Parking-Violations-Issued-Fiscal-Year-2017/2bnn-yakx


- Installing SQLite: https://sqlite.org/download.html
- Start: Open SQLite, double-click on sqlite3.exe
## Creating a database: 
   - change our working directory  
       Don’t type sqlite>. That’s the prompt. Type what’s after the prompt. Obviously your path will be specific to your computer.    
       
            sqlite> .cd 'C:\Users\...path...\data'  
        
       create a new empty database 
       
            .open pvi.db
   
   - create a table 
   
            sqlite> create table pvi (
            [Summons_Number] int,
            [Plate_ID] varchar(10),
            [Registration_State] varchar(4),
            [Plate_Type] varchar(5),
            [Issue_Date] varchar(20),
            [Violation_Code_Number] int,
            [Vehicle_Body_Type] varchar(256),
            [Vehicle_Make] varchar(256),
            [Issuing_Agency] varchar(256),
            [Street_Code1] int,
            [Street_Code2] int,
            [Street_Code3] int,
            [Vehicle_Expiration_Date] int,
            [Violation_Location] varchar(256),
            [Violation_Precinct] int,
            [Issuer_Precinct] int,
            [Issuer_Code] int,
            [Issuer_Command] varchar(256),
            [Issuer_Squad] varchar(256),
            [Violation_Time] varchar(256),
            [Time_First_Observed] varchar(256),
            [Violation_County] varchar(256),
            [Violation_In_Front_OfOr_Opposite] varchar(256),
            [House_Number] varchar(256),
            [Street_Name] varchar(256),
            [Intersecting_Street] varchar(256),
            [Date_First_Observed] int,
            [Law_Section] int,
            [Sub_Division] varchar(256),
            [Violation_Legal_Code] varchar(256),
            [Days_Parking_In_Effect]  varchar(256),
            [From_Hours_In_Effect] varchar(256),
            [To_Hours_In_Effect] varchar(256),
            [Vehicle_Color] varchar(256),
            [Unregistered_Vehicle?] varchar(256),
            [Vehicle_Year] int,
            [Meter] int,
            [Feet_From_Curb] int,
            [Violation_Post_Code] varchar(256),
            [Violation_Description] varchar(256),
            [No_Standing_or_Stopping_Violation] varchar(256),
            [Hydrant_Violation] varchar(256),
            [Double_Parking_Violation] varchar(256)
            );
    
   - import the csv file
        
            sqlite> .mode csv
            sqlite> .import pvi_2017.csv pvi

        The only catch is, since the table was already created, the .import command will import the entire CSV file including the header.
        That means we need to do a little minor clean up once the import finishes to remove the extra record with the column names. 
        One way we can do that is as follows:
       
            sqlite> delete from pvi where typeof([Violation Code Number]) == "text";  # 
            
        Find the row where the data type in the Violation Code Number cell is text, and delete it.
        
## Adding an index to the database
   - add an index, or several indices: https://www.sqlite.org/queryplanner.html
   
            sqlite> create index [Registration State] on pvi([Registration State]);   # 
            
        The general guideline is to create indices for columns of interest, particularly those that you will use to subset or filter the data.
       
   - exit the sqlite program  
    
            sqlite> .exit
        
## Connect to the database in R

    install.packages(c("DBI", "dplyr", "dbplyr", "RSQLite"))
    library(DBI)
    library(dplyr)
    setwd("C:/path/to db directory")
    con <- dbConnect(RSQLite::SQLite(), "pvi.db")
    pvi <- tbl(con, "pvi")

## Get Column Names in SQLite Database

    PRAGMA table_info(table_name);
    SELECT name FROM PRAGMA_TABLE_INFO("table_name");
    
## Submit queries to the database
    
    NJ <- pvi %>% 
        filter(`Registration State` == "NJ") %>% 
        select(`Plate ID`, `Vehicle Make`, `Violation Description`) %>% 
        collect()

    dbDisconnect(con)  # finished working with the database

## Going further 
    dbplyr vignette:  https://cran.r-project.org/web/packages/dbplyr/vignettes/dbplyr.html
    Building precursors to data science: https://nhorton.people.amherst.edu/precursors/
    View the entire collection: https://data.library.virginia.edu/category/statlab-articles/
    
## SQLite Syntax: https://www.sqlitetutorial.net/
## SQLite * JOIN
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

## Section 13. Views
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





Source: https://www.sqlitetutorial.net/


