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

    
    
    
    
    
    
    

Source: https://www.sqlitetutorial.net/


