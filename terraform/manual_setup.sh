#!/bin/bash

# Get values from Terraform outputs
RESOURCE_GROUP=$(terraform output -raw resource_group_name)
SQL_SERVER=$(terraform output -raw sql_server_name)
SQL_DATABASE=$(terraform output -raw sql_database_name)
SYNAPSE_WORKSPACE=$(terraform output -raw synapse_workspace_name)
SYNAPSE_POOL=$(terraform output -raw synapse_sql_pool_name)

echo "===== MANUAL STEPS REQUIRED ====="
echo "Please execute the following SQL scripts in the Azure portal:"
echo ""
echo "1. For Azure SQL Database ($SQL_DATABASE):"
echo "   - Go to: Azure Portal → SQL Server ($SQL_SERVER) → Databases → $SQL_DATABASE → Query editor"
echo "   - Login with sqladmin and your password"
echo "   - Execute this SQL:"
echo ""
echo "-- Create the Customers source table"
echo "CREATE TABLE Customers ("
echo "    CustomerID INT PRIMARY KEY,"
echo "    FirstName NVARCHAR(50),"
echo "    LastName NVARCHAR(50),"
echo "    Email NVARCHAR(100),"
echo "    Phone NVARCHAR(20),"
echo "    RegistrationDate DATETIME"
echo ");"
echo ""
echo "-- Insert sample data"
echo "INSERT INTO Customers VALUES"
echo "(1, 'John', 'Smith', 'john.smith@example.com', '555-123-4567', '2023-01-15'),"
echo "(2, 'Emma', 'Johnson', 'emma.j@example.com', '555-234-5678', '2023-02-20'),"
echo "(3, 'Michael', 'Williams', 'mike.w@example.com', '555-345-6789', '2023-03-10'),"
echo "(4, 'Sophia', 'Brown', 'sophia.b@example.com', '555-456-7890', '2023-04-05'),"
echo "(5, 'William', 'Jones', 'will.jones@example.com', '555-567-8901', '2023-05-22');"
echo ""
echo "2. For Synapse Analytics ($SYNAPSE_WORKSPACE):"
echo "   - Go to: Azure Portal → Synapse workspace ($SYNAPSE_WORKSPACE) → Open Synapse Studio"
echo "   - Go to Develop → + → SQL script"
echo "   - Connect to: $SYNAPSE_POOL"
echo "   - Execute this SQL:"
echo ""
echo "-- Create the Customers destination table in Synapse Analytics"
echo "CREATE TABLE dbo.Customers ("
echo "    CustomerID INT NOT NULL,"
echo "    FirstName NVARCHAR(50),"
echo "    LastName NVARCHAR(50),"
echo "    Email NVARCHAR(100),"
echo "    Phone NVARCHAR(20),"
echo "    RegistrationDate DATETIME"
echo ")"
echo "WITH"
echo "("
echo "    DISTRIBUTION = HASH(CustomerID),"
echo "    CLUSTERED COLUMNSTORE INDEX"
echo ");"
echo ""
echo "===== END OF MANUAL STEPS ====="