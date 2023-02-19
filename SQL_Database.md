Source: https://www.w3schools.com/sql/sql_create_db.asp

SQL Database-------------------------
  
    CREATE DATABASE databasename;             # to create a new SQL database.                 
  
    DROP DATABASE databasename;               # o drop an existing SQL database.        
  
     BACKUP DATABASE databasename             # to create a full back up of an existing SQL database.       
     TO DISK = 'filepath'; 
SQL Table---------------------------

     CREATE TABLE table_name (               . 
      column1 datatype,
      column2 datatype,
      column3 datatype,
     ....
     );
     
     DROP TABLE table_name;
     
     TRUNCATE TABLE table_name;               # to delete the data inside a table, but not the table itself.
     
     ALTER TABLE table_name                   # to add, delete, or modify columns in an existing table.
     ADD column_name datatype;                
     
     ALTER TABLE table_name                   # to add and drop various constraints on an existing table.
     DROP COLUMN column_name;
     
     ALTER TABLE table_name                   # To rename a column in a table
     RENAME COLUMN old_name to new_name;

To change the data type of a column in a table

    SQL Server / MS Access:
        ALTER TABLE table_name
        ALTER COLUMN column_name datatype;
    
    My SQL / Oracle (prior version 10G):
        ALTER TABLE table_name
        MODIFY COLUMN column_name datatype;
    
    Oracle 10G and later:
        ALTER TABLE table_name
        MODIFY column_name datatype;

SQL constraints

    CREATE TABLE table_name (
        column1 datatype constraint,
        column2 datatype constraint,
        column3 datatype constraint,
        ....
    );
    
    The following constraints are commonly used in SQL:
    NOT NULL      - Ensures that a column cannot have a NULL value
    UNIQUE        - Ensures that all values in a column are different
    PRIMARY KEY   - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
    FOREIGN KEY   - Prevents actions that would destroy links between tables
    CHECK         - Ensures that the values in a column satisfies a specific condition
    DEFAULT       - Sets a default value for a column if no value is specified
    CREATE INDEX  - Used to create and retrieve data from the database very quickly

SQL Date Data Types
MySQL comes with the following data types for storing a date or a date/time value in the database:

    DATE - format YYYY-MM-DD
    DATETIME - format: YYYY-MM-DD HH:MI:SS
    TIMESTAMP - format: YYYY-MM-DD HH:MI:SS
    YEAR - format YYYY or YY
SQL Server comes with the following data types for storing a date or a date/time value in the database:

    DATE - format YYYY-MM-DD
    DATETIME - format: YYYY-MM-DD HH:MI:SS
    SMALLDATETIME - format: YYYY-MM-DD HH:MI:SS
    TIMESTAMP - format: a unique number

CREATE VIEW Syntax: a virtual table based on the result-set of an SQL statement.

    CREATE VIEW view_name AS
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition;

SQL Injection: https://www.w3schools.com/sql/sql_injection.asp

    SQL injection is a code injection technique that might destroy your database.
    SQL injection is one of the most common web hacking techniques.
    SQL injection is the placement of malicious code in SQL statements, via web page input.

    SQL in Web Pages:
        txtUserId = getRequestString("UserId");
        txtSQL = "SELECT * FROM Users WHERE UserId = " + txtUserId
    SQL Injection Based on 1=1 is Always True:
        SELECT * FROM Users WHERE UserId = 105 OR 1=1;
    
        SELECT UserId, Name, Password FROM Users WHERE UserId = 105 or 1=1;
    
    SQL Injection Based on ""="" is Always True
    Example
        uName = getRequestString("username");
        uPass = getRequestString("userpassword");

        sql = 'SELECT * FROM Users WHERE Name ="' + uName + '" AND Pass ="' + uPass + '"'
    Result
        SELECT * FROM Users WHERE Name ="John Doe" AND Pass ="myPass"
    
    SQL Injection Based on Batched SQL Statements 
    Use SQL Parameters for Protection
    
 
