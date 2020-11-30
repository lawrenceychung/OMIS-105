
-- Clauses of the SELECT Statement
SELECT ProductDescription, ProductStandardPrice 
FROM Product_T 
WHERE ProductStandardPrice < 275;

SELECT C.CustomerName AS CName, C.CustomerAddress 
FROM Customer_T AS C
WHERE CustomerName = 'Home Furnishings';

SELECT ProductStandardPrice, ProductDescription, ProductID 
FROM Product_T;

-- Using Expressions
SELECT ProductID, ProductStandardPrice, ProductStandardPrice*1.1 AS PlusTax 
FROM Product_T;

-- Using Functions
SELECT AVG(ProductStandardPrice) AS AveragePrice 
FROM Product_T;

SELECT COUNT(*) AS CNT
FROM OrderLine_T 
WHERE OrderID = 1004;

SELECT MIN(ProductDescription) AS MINIMUM
FROM Product_T;

-- Using Comparison Operators
SELECT OrderID, OrderDate 
FROM Order_T 
WHERE OrderDate < '24-OCT-2017';

SELECT ProductDescription, ProductFinish 
FROM Product_T 
WHERE ProductFinish != 'Cherry';

-- Using Null Values
SELECT * 
FROM Customer_T 
WHERE CustomerPostalCode IS NULL;

-- Using Boolean Operators
SELECT ProductDescription, ProductFinish, ProductStandardPrice 
FROM Product_T 
WHERE ProductDescription LIKE '%Desk' OR ProductDescription LIKE '%Table' AND ProductStandardPrice > 300;

SELECT ProductDescription, ProductFinish, ProductStandardPrice 
FROM Product_T
WHERE (ProductDescription LIKE '%Desk' OR ProductDescription LIKE '%Table') AND ProductStandardPrice > 300;

-- Using Ranges for Qualification
SELECT ProductDescription, ProductStandardPrice 
FROM Product_T 
WHERE ProductStandardPrice >= 200 AND ProductStandardPrice <= 300;

SELECT ProductDescription, ProductStandardPrice 
FROM Product_T 
WHERE ProductStandardPrice BETWEEN 200 AND 300;

-- Using Distinct Values
SELECT OrderID 
FROM OrderLine_T;

SELECT DISTINCT OrderID 
FROM OrderLine_T;

SELECT DISTINCT OrderID, OrderedQuantity 
FROM OrderLine_T;

-- Using IN and NOT IN with Lists
SELECT CustomerName, CustomerCity, CustomerState 
FROM Customer_T 
WHERE CustomerState IN ('FL', 'TX', 'CA', 'HI');

-- Sorting Results: The ORDER BY Clause
SELECT CustomerName, CustomerCity, CustomerState 
FROM Customer_T 
WHERE CustomerState IN ('FL', 'TX', 'CA', 'HI') 
ORDER BY CustomerState, CustomerName;

SELECT CustomerName, CustomerCity, CustomerState 
FROM Customer_T 
WHERE CustomerState IN ('FL', 'TX', 'CA', 'HI') ORDER BY 3, 1;

-- Categorizing Results: The GROUP BY Clause
SELECT CustomerState, COUNT(CustomerID) 
FROM Customer_T 
GROUP BY CustomerState 
ORDER BY CustomerState;

SELECT CustomerState, CustomerCity, COUNT(CustomerCity) FROM Customer_T GROUP BY CustomerState, CustomerCity ORDER BY CustomerState, CustomerCity;

-- Qualifying Results by Categories: The HAVING Clause
SELECT CustomerState, COUNT(CustomerState) 
FROM Customer_T 
GROUP BY CustomerState 
HAVING COUNT(CustomerState)>1;

SELECT ProductFinish, AVG (ProductStandardPrice) 
FROM Product_T 
WHERE ProductFinish IN ('Cherry', 'Natural Ash', 'Natural Maple', 'White Ash')
GROUP BY ProductFinish 
HAVING AVG (ProductStandardPrice) < 750 
ORDER BY ProductFinish;

-- PRACTICE PROBLEMS --

-- List the customers that live in California or Washington. Order them by zip code from high to low.
SELECT *
FROM Customer_T
WHERE CustomerState='CA' OR CustomerState='FL'
ORDER BY CustomerPostalCode

-- Which employees were hired during 2005
SELECT * 
FROM Employee_T
WHERE EmployeeDateHired LIKE '%2005%'

-- List the employees whose last mames begins with an L.
SELECT * 
FROM Employee_T
WHERE EmployeeName LIKE '% L%'

-- List the Material ID, MaterialName, Material, MaterialStandardPrice, and Thickness 
-- for all raw materials made of cherry, pine, or walnet. Order the listing by Material, StandardPrice, and Thickness.
SELECT MaterialID, MaterialName, Material, MaterialStandardPrice, Thickness
FROM RawMaterial_T
WHERE Material IN ('Cherry','Pine','Walnut')
ORDER BY Material, MaterialStandardPrice, Thickness

-- List all raw materials tha are made of cherry and that have dimensions (thickness and width) of 12 x 12.
SELECT *
FROM RawMaterial_T
WHERE Material = 'Cherry' AND Thickness = '12' AND Width = '12'

-- List the number of customers living at each state that is included in the Customer_T table.
SELECT CustomerState, COUNT(CustomerID) AS NumberofCustomers
FROM Customer_T
GROUP BY CustomerState

-- Display the product line ID and the average standard price for all products in each product line.
SELECT ProductLineID, AVG(ProductStandardPrice) AS AverageProductLineCost
FROM Product_T
GROUP BY ProductLineID

-- Modify the previous question by considering only those products the standard price of which is greater than $200. 
-- Include in the answer set only those product lines that have an average standard price of at least $500.
SELECT ProductLineID, AVG(ProductStandardPrice) AS AverageProductLineCost
FROM Product_T
WHERE ProductStandardPrice > 200
GROUP BY ProductLineID
HAVING AVG(ProductStandardPrice) > 500

-- For every produce that has been ordered, display the product ID and the total quantity ordered (label this result TotalOrdered). 
-- List the most popular product first and the leaset popular last. 
SELECT ProductID, SUM(OrderedQuantity) AS TotalOrdered
FROM OrderLine_T
GROUP BY ProductID
ORDER BY SUM(OrderedQuantity) DESC

-- For each order, display the order Id, the number of separate products included in the order, 
-- and the total number of product units (for all products) ordered.
SELECT OrderID, COUNT(ProductID) AS cntProd, SUM(OrderedQuantity) AS SumQnt
FROM OrderLine_T
GROUP BY OrderID

-- For each customer, list the CustomerId and total number of orders placed.
SELECT CustomerID, COUNT(OrderID) AS CntofOrders
FROM Order_T
GROUP BY CustomerID

-- Display the product ID and the number of orders placed for each product. 
-- Show the results in decreasing order by the number of times the product has been order and label this result column NumbOrders.
SELECT ProductID, COUNT(OrderID) AS NumOrders
FROM OrderLine_T
GROUP BY ProductID
ORDER BY COUNT(OrderID) DESC

-- For each customer, List the customer Id and the toal number of orders placed in 2018.
SELECT CustomerID, COUNT(OrderID) AS SntOrders
FROM Order_T
WHERE OrderDate LIKE '%2018%'
GROUP BY CustomerID
HAVING COUNT(OrderID) > 2

-- For employees who live in TN or FL, list the age at which they were hired.
SELECT EmployeeID, EmployeeName, (YEAR(EmployeeDateHired) - YEAR(EmployeeBirthDate)) AS EmpAge
FROM Employee_T
WHERE EmployeeState IN ('TN', 'FL')

-- List ProductID, ProductDescription, ProductFinish, and ProductStandardPrice for oak products with 
-- ProductStandardPrice greater than $400 or cherry products with a StandarPrice less than $300.
SELECT ProductID, ProductDescription, ProductFinish, ProductStandardPrice
FROM Product_T
WHERE (ProductFinish = 'Oak' AND ProductStandardPrice > 400) OR (ProductFinish = 'Cherry' AND ProductStandardPrice < 300)

-- List MaterialName, Material, and Width for raw materials that are not cherry or oak and whose width is more than 10 inches.
SELECT SalesPersonID, COUNT(OrderID) AS OrderPerSalesperson
FROM Order_T
WHERE SalesPersonID NOT IN (3,5,9)
GROUP BY SalesPersonID

-- Display the territory ID and the number of salesperson in the territory for all territories that have more than one salesperson.
SELECT SalesTerritoryID, COUNT(SalespersonID) AS NumofSalesperson
FROM Salesperson_T
GROUP BY SalesTerritoryID
HAVING COUNT(SalespersonID) > 1

-- Write an SQL query to display the order number, customer number, order date, and items ordered for some particular customer.
SELECT Customer_T.CustomerID, CustomerName, OrderID, OrderDate
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerID = Order_T.CustomerID;

-- Display order ID, customer ID, order date, and items ordered (Product ID) for some particular customer
SELECT Order_T.OrderID, CustomerID, OrderDate, ProductID
FROM OrderLine_T INNER JOIN Order_T ON Order_T.OrderID = OrderLine_T.OrderID
WHERE CustomerID = 4

-- List employee name, employee birth date, manager name, manager’s birth date for those employees 
-- who were born before their manager (label manager’s data manager and manager birth)
SELECT Employee_T.EmployeeName AS empname, Employee_T.EmployeeBirthDate AS EmpBirth, Supervisor_T.EmployeeName AS SupervisorName, Supervisor_T.EmployeeBirthDate AS SupervisorBirth
FROM Employee_T INNER JOIN Employee_T Supervisor_T ON Supervisor_T.EmployeeID = Employee_T.EmployeeSupervisor
WHERE Employee_T.EmployeeBirthDate < Supervisor_T.EmployeeBirthDate

-- Which customer who has not placed any orders ofr computer desks
SELECT Customer_T.CustomerId, CustomerName, CustomerAddress
FROM Customer_T
WHERE CustomerId IN (SELECT Customerid FROM Order_T INNER JOIN OrderLine_T ON OrderLine_T.OrderID = Order_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID  WHERE ProductDescription LIKE '%computer desk%');

-- save the query in memory so that this query can be ran again much faster
CREATE VIEW ComputerDesk AS
SELECT Customer_T.CustomerId, CustomerName, CustomerAddress
FROM Customer_T
WHERE CustomerId IN (SELECT Customerid FROM Order_T INNER JOIN OrderLine_T ON OrderLine_T.OrderID = Order_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID  WHERE ProductDescription LIKE '%computer desk%');

SELECT * from ComputerDesk

-- Write an SQL query to list all product line names and, for each product line, 
-- the number of products and the average product price. Make sure to include all product lines separately.
SELECT ProductLineName, COUNT (ProductID) AS NumOfProducts, AVG(ProductStandardPrice) AS AvgPrice
FROM Product_T INNER JOIN ProductLine_T ON Product_T.ProductLineID = ProductLine_T.ProductLineID
GROUP BY ProductLineName

-- Modify the previous question to include only those product lines the average price of which is higher than $200.
SELECT ProductLineName, COUNT (ProductID) AS NumOfProducts, AVG(ProductStandardPrice) AS AvgPrice
FROM Product_T INNER JOIN ProductLine_T ON Product_T.ProductLineID = ProductLine_T.ProductLineID
GROUP BY ProductLineName
HAVING AVG(ProductStandardPrice) > 200

-- Write an SQL query to display the order number, customer number, order date, 
-- and items ordered for some particular customer.
SELECT Order_T.OrderID, CustomerID, OrderDate, ProductID
FROM Order_T INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID
WHERE CustomerID = 4

-- Write an SQL query to display each item ordered for order number 1, its standard price, and the total price of each item ordered.
SELECT OrderID, Product_T.ProductID, ProductStandardPrice, (ProductStandardPrice * OrderedQuantity) AS TotalPrice
FROM OrderLine_T INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE OrderID = 1

-- Write an SQL query to total the cost of order number 1.
SELECT OrderID, SUM (ProductStandardPrice * OrderedQuantity) AS TotalPrice
FROM OrderLine_T INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE OrderID = 1
GROUP BY OrderID


SELECT *
FROM Order_T
SELECT *
FROM OrderLine_T
SELECT *
FROM Product_T