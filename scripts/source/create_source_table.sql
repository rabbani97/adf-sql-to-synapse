-- Create the Customers source table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    RegistrationDate DATETIME
);

-- Insert sample data
INSERT INTO Customers VALUES
(1, 'John', 'Smith', 'john.smith@example.com', '555-123-4567', '2023-01-15'),
(2, 'Emma', 'Johnson', 'emma.j@example.com', '555-234-5678', '2023-02-20'),
(3, 'Michael', 'Williams', 'mike.w@example.com', '555-345-6789', '2023-03-10'),
(4, 'Sophia', 'Brown', 'sophia.b@example.com', '555-456-7890', '2023-04-05'),
(5, 'William', 'Jones', 'will.jones@example.com', '555-567-8901', '2023-05-22');