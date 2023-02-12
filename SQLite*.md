## Selecting a random row in SQL
 Select a random row with MySQL:
 
    SELECT column FROM table
    ORDER BY RAND()
    LIMIT 1
 Select a random row with PostgreSQL:
     
    SELECT column FROM table
    ORDER BY RANDOM()
    LIMIT 1
 Select a random row with Microsoft SQL Server:
    
    SELECT TOP 1 column FROM table
    ORDER BY NEWID()
 Select a random row with IBM DB2
	
    SELECT column, RAND() as IDX 
    FROM table 
    ORDER BY IDX FETCH FIRST 1 ROWS ONLY
 Select a random record with Oracle:
	
    SELECT column FROM
    ( SELECT column FROM table
     ORDER BY dbms_random.value )
    WHERE rownum = 1
 Select a random row with sqlite:
	
    SELECT column FROM table 
    ORDER BY RANDOM() LIMIT 1

source: https://www.airweb.org/article/2020/12/15/combining-data-from-multiple-sources-using-r
## Combining Data from Multiple Sources Using R
  
    library(DBI)     # for connecting to databases
    library(readxl)  # for reading Excel files
    library(writexl) # for creating new Excel files
    library(haven)   # for reading files from SPSS, SAS, and Stata
    library(dplyr)   # for combining the data sets
Establish a connection to our SQLite database

    con <- dbConnect(RSQLite::SQLite(), "./oxford/pvi_2019.db")
Write our query using SQL syntax

    query <- "SELECT Students.stuid, Majors.majorname
          FROM Students INNER JOIN Majors
               ON Students.majorid = Majors.majorid"
Execute the query, fetch the results, and store them in a data frame

    students <- dbFetch(dbSendQuery(con, query))
Combining the Data

    intramurals <- read_excel("./data/intramural_signups.xlsx")
    cafeteria <- read_sav("./data/cafeteria_survey.sav")
Merge all three data sets into one using the student ID number

    combined_data <- students %>%
      left_join(intramurals, by=c("stuid"="studentid")) %>%
      left_join(cafeteria, by=c("stuid"="studentid"))
Write the merged results to a specific program's file format using functions in the haven package:

    write_sav(combined_data, "./exports/combined_data.sav")      # creates an SPSS output file
    write_sas(combined_data, "./exports/combined_data.sas7bdat") # creates a SAS output file
    write_dta(combined_data, "./exports/combined_data.dta")      # creates a Stata output file
    write_xlsx(combined_data, path = "./exports/combined_data.xlsx")


