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
    
 SQL Data Types
 
    SQL Server Data Types
      String  Data Types
        Data type	      Description	                        Max size	                      Storage
        char(n)	        Fixed width character string	      8,000 characters	              Defined width
        varchar(n)	    Variable width character string	    8,000 characters	              2 bytes + number of chars
        varchar(max)	  Variable width character string	    1,073,741,824 characters	      2 bytes + number of chars
        text	          Variable width character string	    2GB of text data	              4 bytes + number of chars
        nchar	          Fixed width Unicode string	        4,000 characters	              Defined width x 2
        nvarchar	      Variable width Unicode string	      4,000 characters	 
        nvarchar(max)	  Variable width Unicode string	      536,870,912 characters	 
        ntext	          Variable width Unicode string	      2GB of text data	 
        binary(n)	      Fixed width binary string	          8,000 bytes	 
        varbinary	      Variable width binary string	      8,000 bytes	 
        varbinary(max)	Variable width binary string	      2GB	 
        image	          Variable width binary string	      2GB	 

     Numeric Data Types
        Data type	      Description	                                                         Storage
        bit	            Integer that can be 0, 1, or NULL	 
        tinyint	        Allows whole numbers from 0 to 255	1 byte
        smallint	      Allows whole numbers between -32,768 and 32,767	2 bytes
        int	            Allows whole numbers between -2,147,483,648 and 2,147,483,647	4 bytes
        bigint	        Allows whole numbers between -9,223,372,036,854,775,808 and 9,223,372,036,854,775,807	8 bytes
        decimal(p,s)	  Fixed precision and scale numbers.
        Allows numbers from -10^38 +1 to 10^38 –1.

        The p parameter indicates the maximum total number of digits that can be stored (both to the left and to the right of the decimal point). p must be a value from 1 to 38. Default is 18.

        The s parameter indicates the maximum number of digits stored to the right of the decimal point. s must be a value from 0 to p. Default value is 0

        5-17 bytes
        numeric(p,s)	Fixed precision and scale numbers.
        Allows numbers from -10^38 +1 to 10^38 –1.

        The p parameter indicates the maximum total number of digits that can be stored (both to the left and to the right of the decimal point). p must be a value from 1 to 38. Default is 18.

        The s parameter indicates the maximum number of digits stored to the right of the decimal point. s must be a value from 0 to p. Default value is 0

        5-17 bytes
        smallmoney	Monetary data from -214,748.3648 to 214,748.3647	4 bytes
        money	Monetary data from -922,337,203,685,477.5808 to 922,337,203,685,477.5807	8 bytes
        float(n)	Floating precision number data from -1.79E + 308 to 1.79E + 308.
        The n parameter indicates whether the field should hold 4 or 8 bytes. float(24) holds a 4-byte field and float(53) holds an 8-byte field. Default value of n is 53.

        4 or 8 bytes
        real	Floating precision number data from -3.40E + 38 to 3.40E + 38	4 bytes
    
    Date and Time Data Types
      Data type	        Description	                                                                          Storage
      datetime	        From January 1, 1753 to December 31, 9999 with an accuracy of 3.33 milliseconds	      8 bytes
      datetime2	        From January 1, 0001 to December 31, 9999 with an accuracy of 100 nanoseconds	        6-8 bytes
      smalldatetime	    From January 1, 1900 to June 6, 2079 with an accuracy of 1 minute	                    4 bytes
      date	            Store a date only. From January 1, 0001 to December 31, 9999	                        3 bytes
      time	            Store a time only to an accuracy of 100 nanoseconds	                                  3-5 bytes
      datetimeoffset	  The same as datetime2 with the addition of a time zone offset	                        8-10 bytes
      timestamp	        Stores a unique number that gets updated every time a row gets created or modified. The timestamp value is based upon an internal clock and does not correspond to real time. Each table may have only one timestamp variable	 
    
    Other Data Types
      Data type	        Description
      sql_variant	      Stores up to 8,000 bytes of data of various data types, except text, ntext, and timestamp
      uniqueidentifier	Stores a globally unique identifier (GUID)
      xml	              Stores XML formatted data. Maximum 2GB
      cursor	          Stores a reference to a cursor used for database operations
      table	            Stores a result-set for later processing
 
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
