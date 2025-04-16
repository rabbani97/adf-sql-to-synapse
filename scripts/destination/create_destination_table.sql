-- Create the Customers destination table in Synapse Analytics
CREATE TABLE dbo.Customers (
    CustomerID INT NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    RegistrationDate DATETIME
)
WITH
(
    DISTRIBUTION = HASH(CustomerID),
    CLUSTERED COLUMNSTORE INDEX
);