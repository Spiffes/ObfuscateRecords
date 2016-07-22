/*-------------------------------------------------------------- */
/*				   				 */
/*This program replaces letters in any columns* of any selected */
/*database with random letter. The user inputs Databases in the	 */
/*first where cluase at the start of this program 				 */
/** Columns with Address in the name 							 */
/* ***** Find and replace is resource heavey,  */
/*Created 7.18.2016												 */
/*-------------------------------------------------------------- */

DECLARE @i int
DECLARE @DB_Name Varchar(100)
DECLARE @DBName Varchar(100)
DECLARE @tblName Varchar(100)
DECLARE @ColumnName Varchar(100)
DECLARE @FromClause Varchar(MAX)
DECLARE @numrows int 
DECLARE @SQL Varchar(Max) 
DECLARE @ArrDatabases TABLE(idx smallint Primary Key IDENTITY(1,1), DBName VARCHAR(100))
DECLARE @ArrFromClause TABLE(idx smallint Primary Key IDENTITY(1,1),ColumnName VARCHAR(100), DBName VARCHAR (MAX), tblName VARCHAR(100), FromClause VARCHAR(MAX))

/*------------------------------------------------------------------------------------------------------------*/
--Creates a list of Databsae on the server-----
  INSERT INTO @ArrDatabases  
	select distinct Name as DBName
	From sys.databases
	 -- where name IN ('-', '-')   -- Select Database you want to run this on. If none this will run for every datasbase on server

-- Debug 
   --Select * from @ArrFromClause	

/*------------------------------------------------------------------------------------------------------------*/
-- Loops through each the list to Databases and creates a list of table and columns. 
-- also creates column FromClause that in the correct Sql from format.
SET @i = 1
SET @numrows = (SELECT COUNT(*) FROM @ArrDatabases)
IF @numrows > 0
    WHILE (@i <= (SELECT MAX(idx) FROM @ArrDatabases))
    BEGIN
	
        -- get the next DB Name primary key
        SET @DB_Name = (SELECT DBName FROM @ArrDatabases WHERE idx = @i)
        -- Create SQL Statement
		SET @SQL = CONCAT( 'USE ',@DB_Name,' select distinct COLUMN_NAME as ColumnName, TABLE_CATALOG as DBName, TABLE_NAME as tblName,
											(TABLE_CATALOG +''.''+ TABLE_SCHEMA +''.''+TABLE_NAME) as FromClause
											 from INFORMATION_SCHEMA.COLUMNS
											 Where COLUMN_NAME Like ''%Address%''')                     --Adjust your column clause to filter
		Insert into @ArrFromClause
		EXEC(@SQL) 


        -- increment counter for next column
        SET @i = @i + 1
    END

-- Debug 
 -- Select * from @ArrFromClause
/*------------------------------------------------------------------------------------------------------------*/
-- Pulling information out of the @ArrFromClause runs find and replaces looping through each column

SET @i = 1
SET @numrows = (SELECT COUNT(*) FROM @ArrFromClause)
IF @numrows > 0
    WHILE (@i <= (SELECT MAX(idx) FROM @ArrFromClause))
    BEGIN


        -- pull information out of each row record 
        SET @ColumnName = (SELECT ColumnName FROM @ArrFromClause WHERE idx = @i)
		SET @FromClause =  (SELECT FromClause FROM @ArrFromClause WHERE idx = @i)
		SET @DBName =  (SELECT DBName FROM @ArrFromClause WHERE idx = @i)
		SET @tblName = (SELECT tblName FROM @ArrFromClause WHERE idx = @i)
        -- Find and replace letters
		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''a'', ''6'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''s'', ''k'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''t'', ''z'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 


		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''9'', ''4'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''d'', ''h'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''y'', ''c'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''b'', ''3'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''e'', ''f'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''m'', ''w'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''n'', ''q'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''7'', ''2'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''5'', ''8'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

		SET @SQL = CONCAT( 'USE [', @DB_Name , '];','UPDATE ', @tblName, '
					SET  ',@ColumnName,' = REPLACE(', @ColumnName, ', ''u'', ''p'')',
					'FROM ', @FromClause )
	
		EXEC(@SQL) 

	


		select * from @ArrFromClause

        -- increment counter for next Column
        SET @i = @i + 1
    END
