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
            [Summons Number] int,
            [Plate ID] varchar(10),
            [Registration State] varchar(4),
            [Plate Type] varchar(5),
            [Issue Date] varchar(20),
            [Violation Code Number] int,
            [Vehicle Body Type] varchar(256),
            [Vehicle Make] varchar(256),
            [Issuing Agency] varchar(256),
            [Street Code1] int,
            [Street Code2] int,
            [Street Code3] int,
            [Vehicle Expiration Date] int,
            [Violation Location] varchar(256),
            [Violation Precinct] int,
            [Issuer Precinct] int,
            [Issuer Code] int,
            [Issuer Command] varchar(256),
            [Issuer Squad] varchar(256),
            [Violation Time] varchar(256),
            [Time First Observed] varchar(256),
            [Violation County] varchar(256),
            [Violation In Front Of Or Opposite] varchar(256),
            [House Number] varchar(256),
            [Street Name] varchar(256),
            [Intersecting Street] varchar(256),
            [Date First Observed] int,
            [Law Section] int,
            [Sub Division] varchar(256),
            [Violation Legal Code] varchar(256),
            [Days Parking In Effect]  varchar(256),
            [From Hours In Effect] varchar(256),
            [To Hours In Effec]t varchar(256),
            [Vehicle Color] varchar(256),
            [Unregistered Vehicle?] varchar(256),
            [Vehicle Year] int,
            [Meter] int,
            [Feet From Curb] int,
            [Violation Post Code] varchar(256),
            [Violation Description] varchar(256),
            [No Standing or Stopping Violation] varchar(256),
            [Hydrant Violation] varchar(256),
            [Double Parking Violation] varchar(256)
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

Source: https://www.sqlitetutorial.net/


