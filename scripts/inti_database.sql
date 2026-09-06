/*
=================================================
Initialize Data Warehouse Database
=================================================
Purpose: This Initialize The SQL Server Database Used for The DWH project.

It Performs The Following Operations:
  1- Check Whether The 'DWH_Prj_1' database is already Exists.
  2- Removes the existing database if found.
  3- Creates a fresh 'DWH_Prj_1' database.
  4- Creates the Bronze, Silver, and Gold schemas used to organize the different stages of the data pipeline.

Database Layers:
Bronze -> Raw source data
Silver -> Cleaned and transformed data
Gold -> Business-ready analytical data

IMPORTANT:
This script is designed to recreate the database from scratch.
If a 'DWH_Prj_1' database already exists, it will be permanently deleted along with all of its data.

Make sure any required data has been backed up before executing this script.
*/

-- Check If There is a Database With The Same Name
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DWH_Prj_1')
BEGIN
	DROP DATABASE DWH_Prj_1
END;

-- Create The DWH Database
CREATE DATABASE DWH_Prj_1;
USE DWH_Prj_1;

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
