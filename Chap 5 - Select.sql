
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

--____________________________________________________________________________________________________________________________________________________________________________
-- Retrieve a list of the raw materials and quantities required to produce a cherry end table (product with product description ‘cherry end table’). 
-- The query should output the material ID, material name, material standard price, and quantity of raw material required. 
-- Sort the results with the most expensive raw materials listed first. 
SELECT RawMaterial_T.MaterialID, MaterialName, MaterialStandardPrice, QuantityRequired
FROM Product_T INNER JOIN Uses_T ON Product_T.ProductID = Uses_T.ProductID INNER JOIN RawMaterial_T ON Uses_T.MaterialID = RawMaterial_T.MaterialID
WHERE ProductDescription = 'Cherry End Table'
ORDER BY MaterialStandardPrice DESC

-- Retrieve the Walnut raw materials of size 12in X 10in (in various lengths) with material standard price greater than 700. 
-- Output the material name, material, size, material standard price, and a marked-up material retail price of 133% of the standard price. 
-- Sort in ascending order of material size. 
SELECT MaterialName, Size, MaterialStandardPrice, (MaterialStandardPrice * 1.33) AS MarkedUpPrice
FROM RawMaterial_T
WHERE Material = 'Walnut' AND Size LIKE '12in x 10in%' AND MaterialStandardPrice > 700
ORDER BY Size ASC

-- Retrieve the count of the materials with supply unit price less than 5 supplied by each vendor. 
-- Output the vendor name and the count of materials supplied that meets this supply unit price criterion. 
-- Sort in descending order of materials supplied.
SELECT VendorName, COUNT(SupplyUnitPrice) AS MaterialCountUnder5
FROM Vendor_T INNER JOIN Supplies_T ON Vendor_T.VendorID = Supplies_T.VendorID
WHERE SupplyUnitPrice < 5
GROUP BY VendorName
ORDER BY COUNT(SupplyUnitPrice) DESC

-- Retrieve the orders placed by customer with ID 4 or 12, facilitated by salesperson with ID 2 or 6, after March 8, 2018 but before March 12, 2018. 
-- Output the order ID, order date, customer ID, and salesperson ID. 
-- Sort in ascending order of customer ID, then in ascending order of order date. 
SELECT OrderID, OrderDate, CustomerID, SalesPersonID
FROM Order_T
WHERE CustomerID IN (4,12) AND SalesPersonID IN (2,6) AND OrderDate > '2018-03-09' AND OrderDate < '2018-03-12' 
ORDER BY CustomerID ASC, OrderDate ASC 

-- Retrieve a list of the orders greater than $1,000 placed after 9/1/2017 and before 3/11/2018, sorted in descending order of the total dollar amount of the order. 
-- Also provide the total quantity of items included in the order, as well as the average price of all items included in the order. 
-- The query should output the customer ID, customer name, order ID, the total dollar amount of the order, total quantity of items included, and average price of items included. (12 points)
SELECT Customer_T.CustomerId, CustomerName, OrderPayment_T.OrderID, PaymentAmount AS TotalDollarAmount,
SUM(OrderedQuantity) AS TotalItemQuantity, AVG(ProductStandardPrice) AS AveragePriceOfItems
FROM Product_T, Customer_T, OrderLine_T INNER JOIN
(SELECT Order_T.OrderID, OrderDate, PaymentAmount, CustomerID
FROM Order_T INNER JOIN Payment_T ON Order_T.OrderID = Payment_T.OrderID
WHERE PaymentAmount > 1000 AND OrderDate >= '2017-09-01' AND OrderDate <= '2018-03-11') OrderPayment_T ON OrderLine_T.OrderID = OrderPayment_T.OrderID
WHERE Product_T.ProductID = OrderLine_T.ProductID AND Customer_T.CustomerId = OrderPayment_T.CustomerID
GROUP BY Customer_T.CustomerId, CustomerName, OrderPayment_T.OrderID, PaymentAmount
ORDER BY TotalDollarAmount DESC
 
 -- Retrieve the average price, maximum price, and minimum price of products within a product line, considering product lines 3 or 4. 
 -- Output the product line ID, and the average, maximum, and minimum prices of all products within that product line. 
 -- Sort in ascending order of product line ID. 
SELECT ProductLine_T.ProductLineID, AVG(ProductStandardPrice) AS AvgPrice, MAX(ProductStandardPrice) AS MaxPrice, MIN(ProductStandardPrice) AS MinPrice
FROM ProductLine_T INNER JOIN Product_T ON ProductLine_T.ProductLineID = Product_T.ProductLineID
WHERE ProductLine_T.ProductLineID IN (3,4)
GROUP BY ProductLine_T.ProductLineID
ORDER BY ProductLineID ASC

-- Retrieve a sales report for the years 2017 and 2018 summarizing PVFC sales by customer state. 
-- Only include customer states with multiple orders in a given year in the sales report. 
-- The query should output the year, customer state, number of orders in the year, the average order total, and total sales for the year. 
-- Sort the results first in ascending year, then ascending customer state. Hint: use the year function to return the year for a given date (year(date) returns year; e.g. year('9/1/2017') returns 2017). 
SELECT YEAR(OrderDate) AS YRs, CustomerState, COUNT(Order_T.OrderID) AS NumOfOrders, AVG(PaymentAmount) AS AvgOrderTotal, SUM(PaymentAmount) AS TotalSales
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerId = Order_T.CustomerID INNER JOIN Payment_T ON Order_T.OrderID = Payment_T.OrderID
GROUP BY CustomerState, YEAR(OrderDate)
HAVING COUNT(Order_T.OrderID) > 1
ORDER BY YEAR(OrderDate) ASC, CustomerState ASC

-- Retrieve a list of the customers of PVFC and the total profit earned from all of their orders. 
-- Profit earned on a given order is the order total minus the total cost to produce the products sold. 
-- The cost of production for a given product is the total cost of all raw materials consumed in production. 
-- The query should output the customer ID, customer name, total amount of all orders placed by the customer, total cost of production of all products sold in these orders, and total dollars profit earned. 
-- Sort the results in descending order of profit. 
SELECT Customer_T.CustomerId, CustomerName, SUM(PaymentAmount) AS TotalOfAllOrders, SUM(TotalCost) AS TotalCost, (SUM(PaymentAmount) - SUM(TotalCost)) AS TotalProfit
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerId = Order_T.CustomerID INNER JOIN Payment_T ON Order_T.OrderID = Payment_T.OrderID INNER JOIN
(
SELECT OrderID, SUM(MaterialStandardPrice*QuantityRequired*OrderedQuantity) AS TotalCost
FROM OrderLine_T INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID INNER JOIN Uses_T ON Product_T.ProductID = Uses_T.ProductID INNER JOIN RawMaterial_T ON Uses_T.MaterialID = RawMaterial_T.MaterialID
GROUP BY OrderID
) TotalCosts_T 
ON Payment_T.OrderID = TotalCosts_T.OrderID
GROUP BY Customer_T.CustomerId, CustomerName


-- Retrieve a list of the customers who have ordered products with either ‘table’, ‘dresser’, or ‘stand’ in the product description, finished in either cherry or birch product finishes. 
-- Also provide the total quantity of products ordered by these customers that meet these criteria. 
-- The query should output the customer ID, customer name, and total quantity of products ordered meeting these criteria, sorted in descending order of quantity ordered. 
SELECT Customer_T.CustomerID, CustomerName, SUM(OrderedQuantity) AS TotalProductsWithCriteria
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerId = Order_T.CustomerID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID INNER JOIN ProductLine_T ON Product_T.ProductLineID = ProductLine_T.ProductLineID
WHERE (ProductDescription LIKE '%table%' OR ProductDescription LIKE '%stand%' OR ProductDescription LIKE '%dresser%') AND ProductFinish IN ('Cherry', 'Birch') 
GROUP BY Customer_T.CustomerID, CustomerName
ORDER BY TotalProductsWithCriteria DESC

-- Retrieve a list of salespersons and the orders they have each facilitated, including order ID, order date, and order total price. 
-- Each order facilitated by a salesperson contributes to their total sales. 
-- Also provide the contribution of each order to the salesperson's total sales, as a percentage of total sales. 
-- Round the percentage of total sales to two digits beyond the decimal point using the 'round' function - round(#,2) where # is the number to round. 
-- The query should output the salesperson name, order ID, order date, order total price, and percentage of salesperson total sales. 
-- Sort the list first in alphabetical order of salesperson name, then by ascending order date, and then with larger order totals listed first.
SELECT SalespersonName, Order_T.OrderID, OrderDate, PaymentAmount AS OrderTotalPrice, ROUND(PaymentAmount / TotalSales * 100,2) AS PercentageofSales
FROM Salesperson_T INNER JOIN Order_T ON Salesperson_T.SalespersonID = Order_T.SalesPersonID INNER JOIN Payment_T ON Order_T.OrderID = Payment_T.OrderID INNER JOIN
(
SELECT Salesperson_T.SalesPersonID, SUM(PaymentAmount) AS TotalSales
FROM Salesperson_T INNER JOIN Order_T ON Salesperson_T.SalespersonID = Order_T.SalesPersonID INNER JOIN Payment_T ON Order_T.OrderID = Payment_T.OrderID
GROUP BY Salesperson_T.SalesPersonID
) TotalSales_T 
ON Salesperson_T.SalespersonID = TotalSales_T.SalespersonID
ORDER BY SalespersonName ASC, OrderDate ASC, OrderTotalPrice DESC

--___________________________________________________________________________________________________________________________________________________________________________

-- Write a SQL query that lists those work centers that employe at least one person who has the skill ‘QC1’
-- Print work center ID, number of empoloyees with skill 'QC1'
SELECT WorkCenterID, COUNT(WorksIn_T.EmployeeID) AS NumberOfEmployees
FROM WorksIn_T INNER JOIN EmployeeSkills_T on WorksIn_T.EmployeeID = EmployeeSkills_T.EmployeeID
WHERE SkillID = 'QC1'
GROUP BY WorkCenterID

-- Show the customer ID and name for all the customers who have ordered both products with IDs 3 and 4 on the same order.
SELECT Order_T.CustomerID, CustomerName
FROM OrderLine_T INNER JOIN Order_T ON OrderLine_T.OrderID = Order_T.OrderID INNER JOIN Customer_T ON Order_T.CustomerID = Customer_T.CustomerId
WHERE ProductID = 3 AND Customer_T.CustomerId IN
(
SELECT Customer_T.CustomerId
FROM OrderLine_T INNER JOIN Order_T ON OrderLine_T.OrderID = Order_T.OrderID INNER JOIN Customer_T ON Order_T.CustomerID = Customer_T.CustomerId
WHERE ProductID = 4
)

-- Write an SQL query that lists for each vendor (including vendor ID and vendor name) those materials that the vendor supplies where the supply unit prices is at least four times the materiall standard price.
SELECT DISTINCT Vendor_T.VendorID, VendorName
FROM Vendor_T INNER JOIN Supplies_T ON Vendor_T.VendorID = Supplies_T.VendorID INNER JOIN RawMaterial_T ON Supplies_T.MaterialID = RawMaterial_T.MaterialID
WHERE SupplyUnitPrice >= (MaterialStandardPrice * 4)

-- The production manager at PVFC is concerned about support for purchased parts in products owned by customers. 
-- A simple analysis he wants done is to determine for each customer how many vendors are in the same state as that customer. 
-- Develop a list of all the PVFC customers by name with the number of vendors in the same state as those customers. (Label this computed result NumVendors)
SELECT CustomerId, CustomerState, NumberOfVendors
FROM Customer_T INNER JOIN
(
SELECT VendorState, COUNT(VendorID) AS NumberOfVendors
FROM Vendor_T
GROUP BY VendorState
) Will_T
ON Will_T.VendorState = Customer_T.CustomerState

-- _____________________________________________________________________________________________________________________________________________________________________________
-- 5-60. Use the Pine Valley database to answer the following questions:How many work centers does Pine Valley have? Where are they located?
SELECT COUNT(*) cnt
FROM WorkCenter_T

SELECT WorkCenterLocation
FROM WorkCenter_T

-- 5-61. List the employees whose last names begin with an L.
SELECT EmployeeID, EmployeeName
FROM Employee_T
WHERE EmployeeName LIKE '% L%'

-- 5-62. Which employees were hired during 2005? 
SELECT EmployeeID, EmployeeName
FROM Employee_T
WHERE YEAR(EmployeeDateHired ) = '2005'

-- 5-63. List the customers who live in California or Washington. Order them by zip code, from high to low.
SELECT CustomerId, CustomerName
FROM Customer_T
WHERE CustomerState IN ('CA', 'WA')
ORDER BY CustomerPostalCode DESC

-- 5-64. List the number of customers living at each state that is included in the Customer_T table.
SELECT CustomerState, COUNT(CustomerId) AS NumberOfCustomers
FROM Customer_T
GROUP BY CustomerState

-- 5-65. List all raw materials that are made of cherry and that have dimensions (thickness and width) of 12 by 12.
SELECT MaterialID, MaterialName
FROM RawMaterial_T
WHERE Material = 'Cherry' AND Thickness = '12' AND Width = '12'

-- 5-66. List the MaterialID, MaterialName, Material, MaterialStandardPrice, and Thickness for all raw materials made of cherry, pine, or walnut. 
-- Order the listing by Material, StandardPrice, and Thickness.
SELECT MaterialID, MaterialName, Material, MaterialStandardPrice, Thickness
FROM RawMaterial_T
WHERE Material IN ('Cherry', 'Pine', 'Walnut')
ORDER BY Material, MaterialStandardPrice, Thickness

-- 5-67. Display the product line ID and the average standard price for all products in each product line. 
SELECT ProductLineID, AVG(ProductStandardPrice) AS AvgPrice
FROM Product_T
GROUP BY ProductLineID

-- 5-68. Modify query in 5-67 by considering only those products the standard price of which is greater than $200. 
-- Include in the answer set only those product lines that have an average standard price of at least $500.
SELECT ProductLineID, AVG(ProductStandardPrice) AS AvgPrice
FROM Product_T
WHERE ProductStandardPrice > 200
GROUP BY ProductLineID
HAVING AVG(ProductStandardPrice) > 500

-- 5-69. For every product that has been ordered, display the product ID and the total quantity ordered 
-- (label this result TotalOrdered). List the most popular product first and the least popular last.
SELECT ProductID, SUM(OrderedQuantity) AS TotalOrdered
FROM OrderLine_T
GROUP BY ProductID
ORDER BY SUM(OrderedQuantity) DESC

-- 5-70. For each order, display the order ID, the number of separate products included in the order, and the total number of product units (for all products) ordered.
SELECT OrderID, COUNT(ProductID) AS NumOfProducts, SUM(OrderedQuantity) AS SumOrders
FROM OrderLine_T
GROUP BY OrderID

-- 5-71. For each customer, list the CustomerID and total number of orders placed.
SELECT CustomerID, COUNT(OrderID) AS NumberOfOrders
FROM Order_T
GROUP BY CustomerID

-- 5-73. Display the product ID and the number of orders placed for each product. 
-- Show the results in decreasing order by the number of times the product has been ordered and label this result column NumOrders.
SELECT ProductID, COUNT(OrderID) AS NumOrders
FROM OrderLine_T
GROUP BY ProductID
ORDER BY COUNT(OrderID) DESC

-- 5-75. For each customer, list the customer ID and the total number of orders placed in 2018.
SELECT CustomerID, COUNT (OrderID) AS NumberOfOrders
FROM Order_T
WHERE YEAR(OrderDate) = '2018'
GROUP BY CustomerID

-- 5-77. For each customer who had more than two orders, list the CustomerID and the total number of orders placed.
SELECT CustomerID, COUNT(OrderID) AS NumberOfOrders
FROM Order_T
GROUP BY CustomerID
HAVING COUNT(OrderID) > 2

-- 5-79. List all sales territories (TerritoryID) that have more than one salesperson.
SELECT SalesTerritoryID, COUNT (SalespersonID) AS NumSalesPersons
FROM Salesperson_T
GROUP BY SalesTerritoryID
HAVING COUNT (SalespersonID)> 1

-- 5-80. Which product is ordered most frequently?
SELECT ProductID, COUNT(OrderID) AS NumberOfOrders
FROM OrderLine_T
GROUP BY ProductID
ORDER BY COUNT(OrderID) DESC

-- 5-81. For employees who live in TN or FL, list the age at which they were hired.
SELECT EmployeeID, DATEDIFF(year,EmployeeBirthDate,EmployeeDateHired) AS StartingAge
FROM Employee_T
WHERE EmployeeState IN ('TN', 'FL')

-- 5-82. Measured by average standard price, what is the least expensive product finish?
SELECT TOP(1) ProductFinish, AVG(ProductStandardPrice) AS AvgPrice
FROM Product_T
GROUP BY ProductFinish
ORDER BY AVG(ProductStandardPrice) ASC

-- 5-83. Display the territory ID and the number of salespersons in the territory for all territories that have more than one salesperson. 
-- Label the number of salespersons NumSalesPersons.
SELECT SalesTerritoryID, COUNT (SalespersonID) AS NumSalesPersons
FROM Salesperson_T
GROUP BY SalesTerritoryID
HAVING COUNT (SalespersonID)> 1

-- 5-84. Display the SalesPersonID and a count of the number of orders for that salesperson for all salespersons 
-- except salespersons 3, 5, and 9. Write this query with as few clauses or components as possible, using the capabilities of SQL as much as possible.
SELECT SalespersonID, COUNT(OrderID) AS NumberOfOrders
FROM Order_T
WHERE SalesPersonID NOT IN (3,5,9)
GROUP BY SalespersonID

-- 5-86. List MaterialName, Material, and Width for raw materials that are not cherry or oak and whose width is greater than 10 inches. 
SELECT MaterialName, Material, Width
FROM RawMaterial_T
WHERE Material NOT IN ('Cherry', 'Oak') AND Width > 10

-- 5-87. List ProductID, ProductDescription, ProductFinish, and ProductStandardPrice for oak products 
-- with a ProductStandardPrice greater than $400 or cherry products with a StandardPrice less than $300. 
SELECT ProductID, ProductDescription, ProductFinish, ProductStandardPrice
FROM Product_T
WHERE (ProductFinish = 'Oak' AND ProductStandardPrice > 400) OR (ProductFinish = 'Cherry' AND ProductStandardPrice < 300)

-- 5-88. For each order, list the order ID, customer ID, order date, and most recent date among all orders. 
SELECT OrderID, CustomerID, OrderDate, RecentDate
FROM Order_T, (SELECT TOP(1) OrderDate AS RecentDate From Order_T ORDER BY OrderDate DESC) AS Temp_T

-- 5-89. For each customer, list the customer ID, the number of orders from that customer, 
-- and the ratio of the number of orders from that customer to the total number of orders from all customers combined. 
-- (This ratio, of course, is the percentage of all orders placed by each customer.)
SELECT CustomerID, COUNT(OrderID) AS NumberOfOrders, TotalOrders, CAST(COUNT(OrderID) AS FLOAT)/TotalOrders AS Ratio
FROM Order_T,(SELECT COUNT(OrderID) AS TotalOrders FROM Order_T) AS Temp_T
GROUP BY CustomerID, TotalOrders

-- 5-90. For products 1, 2, and 7, list in one row and three respective columns that product’s total unit sales; label the three columns Prod1, Prod2, and Prod7.
SELECT Prod1, Prod2, Prod7
FROM
(SELECT SUM(OrderedQuantity) AS Prod1 FROM OrderLine_T WHERE ProductID = 1) AS p1,
(SELECT SUM(OrderedQuantity) AS Prod2 FROM OrderLine_T WHERE ProductID = 2) AS p2,
(SELECT SUM(OrderedQuantity) AS Prod7 FROM OrderLine_T WHERE ProductID = 7) AS p3;

-- 5-91. List the average number of customers per state (including only the states that are included in the Customer_T table). 
-- Hint: A query can be used as a table specification in the FROM clause.
SELECT CustomerState, AVG(CustomerId) AS AvgCustomers
FROM Customer_T
GROUP BY CustomerState

SELECT      AVG(StateCustCount) AS AvgStateCustCnt
FROM(SELECT COUNT(CustomerID) AS StateCustCount FROM CUSTOMER_T GROUP BY CustomerState)AS T;
-- _______________________________________________________________________________________________________________________________________________________________________________-- 
-- 6-45. Write an SQL query that will find any customers who have not placed orders. 
SELECT CustomerID
FROM Customer_T
WHERE CustomerId NOT IN 
(
SELECT CustomerID
FROM Order_T
)

-- 6-46. Write an SQL query to list all product line names and, for each product line, the number of products and the average product price. 
-- Make sure to include all product lines separately.
SELECT ProductLineName, COUNT(ProductID) AS NumOfProducts, AVG(ProductStandardPrice) AS AvgPrice
FROM ProductLine_T INNER JOIN Product_T ON ProductLine_T.ProductLineID = Product_T.ProductLineID
GROUP BY ProductLineName

--  6-47. Modify P&E 6-46 to include only those product lines the average price of which is higher than $200.
SELECT ProductLineName, COUNT(ProductID) AS NumOfProducts, AVG(ProductStandardPrice) AS AvgPrice
FROM ProductLine_T INNER JOIN Product_T ON ProductLine_T.ProductLineID = Product_T.ProductLineID
GROUP BY ProductLineName
HAVING AVG(ProductStandardPrice) > 200

-- 6-48. List the names and number of employees supervised (label this value HeadCount) for each supervisor who supervises more than two employees.
SELECT Manager_T.EmployeeName, COUNT(Employee_T.EmployeeID) AS HeadCount
FROM Employee_T INNER JOIN
(
SELECT *
FROM Employee_T
) Manager_T ON Employee_T.EmployeeSupervisor = Manager_T.EmployeeID 
GROUP BY Manager_T.EmployeeName
HAVING COUNT(Employee_T.EmployeeID) > 2

-- 6-49. List the name of each employee, his or her birth date, the name of his or her manager, and the manager’s birth date 
-- for those employees who were born before their manager was born; label the manager’s data Manager and ManagerBirth. 
SELECT Employee_T.EmployeeName, Employee_T.EmployeeBirthDate, Manager_T.EmployeeName AS Manager, Manager_T.EmployeeBirthDate AS ManagerBday
FROM Employee_T INNER JOIN
(
SELECT *
FROM Employee_T
) Manager_T ON Employee_T.EmployeeSupervisor = Manager_T.EmployeeID 
WHERE Employee_T.EmployeeBirthDate < Manager_T.EmployeeBirthDate

-- 6-50. Write an SQL query to display the order number, customer number, order date, and items ordered for some particular customer. 
SELECT Order_T.OrderID, CustomerID, OrderDate, Product_T.ProductID
FROM Order_T INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE CustomerID = 4

-- 6-51. Write an SQL query to display each item ordered for order number 1, its standard price, and the total price for each item ordered. 
SELECT Product_T.ProductID, ProductStandardPrice, (OrderedQuantity * ProductStandardPrice) AS TotalPrice
FROM Order_T INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE Order_T.OrderID = 1

-- 6-52. Write an SQL query to display the total number of employees working at each work center (include ID and location for each work center).
SELECT WorkCenter_T.WorkCenterID, WorkCenterLocation, COUNT(EmployeeID) AS NumOfEmployees
FROM WorkCenter_T INNER JOIN WorksIn_T ON WorkCenter_T.WorkCenterID = WorksIn_T.WorkCenterID
GROUP BY WorkCenter_T.WorkCenterID, WorkCenterLocation

-- 6-53. Write an SQL query that lists those work centers that employ at least one person who has the skill ‘QC1’. 
SELECT WorkCenter_T.WorkCenterID, WorkCenterLocation
FROM WorkCenter_T INNER JOIN WorksIn_T ON WorkCenter_T.WorkCenterID = WorksIn_T.WorkCenterID INNER JOIN EmployeeSkills_T ON WorksIn_T.EmployeeID = EmployeeSkills_T.EmployeeID
WHERE SkillID = 'QC1'

-- 6-54. Write an SQL query to total the cost of order number 1. 
SELECT Order_T.OrderID, SUM(ProductStandardPrice * OrderedQuantity) AS TotalCost
FROM Order_T INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE Order_T.OrderID = 1
GROUP BY Order_T.OrderID

-- 6-55. Write an SQL query that lists for each vendor (including vendor ID and vendor name) those materials that the vendor supplies 
-- where the supply unit prices is at least four times the material standard price. 
SELECT Vendor_T.VendorID, VendorName, MaterialName
FROM Vendor_T INNER JOIN Supplies_T ON Vendor_T.VendorID = Supplies_T.VendorID INNER JOIN RawMaterial_T ON Supplies_T.MaterialID = RawMaterial_T.MaterialID
WHERE SupplyUnitPrice >= MaterialStandardPrice * 4

-- 6-56. Calculate the total raw material cost (label TotCost) for each product compared to its standard product price. 
-- Display product ID, product description, standard price, and the total cost in the result. 
SELECT Product_T.ProductID, ProductDescription, ProductStandardPrice, SUM(MaterialStandardPrice * QuantityRequired) AS TotCost
FROM Product_T INNER JOIN Uses_T ON Product_T.ProductID = Uses_T.ProductID INNER JOIN RawMaterial_T ON Uses_T.MaterialID = RawMaterial_T.MaterialID
GROUP BY Product_T.ProductID, ProductDescription, ProductStandardPrice

-- 6-57. For every order that has been received, display the order ID, the total dollar amount owed on that order 
-- (you’ll have to calculate this total from attributes in one or more tables; label this result TotalDue), 
-- and the amount received in payments on that order (assume that there is only one payment made on each order). 
--To make this query a little simpler, you don’t have to include those orders for which no payment has yet been received. 
-- List the results in decreasing order of the difference between total due and amount paid. 
SELECT  Order_T.OrderID, SUM(OrderedQuantity * ProductStandardPrice) AS TotalDue, PaymentAmount
FROM Order_T INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID INNER JOIN Payment_T ON OrderLine_T.OrderID = Payment_T.OrderID
GROUP BY Order_T.OrderID, PaymentAmount
ORDER BY (SUM(OrderedQuantity * ProductStandardPrice) - PaymentAmount) DESC

-- 6-58. Write an SQL query to list each customer who has bought computer desks and the number of units sold to each customer. 
SELECT Customer_T.CustomerID, CustomerName, SUM(OrderedQuantity) AS UnitsBought
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerId = Order_T.CustomerID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE ProductDescription LIKE '%computer desk%'
GROUP BY Customer_T.CustomerID, CustomerName

-- 6-59. Write an SQL query to list each customer who bought at least one product that belongs to product line Basic in March 2018. List each customer only once. 
SELECT DISTINCT Customer_T.CustomerID, CustomerName
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerID = Order_T.CustomerID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID INNER JOIN ProductLine_T ON Product_T.ProductLineID = ProductLine_T.ProductLineID
WHERE ProductLineName = 'Basic' AND MONTH(OrderDate) = 3 AND YEAR(OrderDate) = 2018

-- 6-60. Modify Problem and Exercise 6-59 so that you include the number of products in product line Basic that the customer ordered in March 2018. 
SELECT DISTINCT Customer_T.CustomerID, CustomerName, COUNT(Product_T.ProductID) AS NumOfBasicProduct
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerID = Order_T.CustomerID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID INNER JOIN ProductLine_T ON Product_T.ProductLineID = ProductLine_T.ProductLineID
WHERE ProductLineName = 'Basic' AND MONTH(OrderDate) = 3 AND YEAR(OrderDate) = 2018
GROUP BY Customer_T.CustomerID, CustomerName

-- 6-61. Modify Problem and Exercise 6-60 so that the list includes the number of products each customer bought in each product line in March 2018.
SELECT DISTINCT Customer_T.CustomerID, CustomerName, COUNT(Product_T.ProductID) AS NumOfBasicProduct
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerID = Order_T.CustomerID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID INNER JOIN ProductLine_T ON Product_T.ProductLineID = ProductLine_T.ProductLineID
WHERE ProductLineName = 'Basic' AND MONTH(OrderDate) = 3 AND YEAR(OrderDate) = 2018
GROUP BY Customer_T.CustomerID, CustomerName, ProductLine_T.ProductLineID, ProductLineName

-- 6-62. List, in alphabetical order, the names of all employees (managers) who are now managing people with skill ID BS12; 
-- list each manager’s name only once, even if that manager manages several people with this skill.
SELECT DISTINCT EmployeeName
FROM Employee_T INNER JOIN
(
SELECT Employee_T.EmployeeID, SkillID, EmployeeSupervisor
FROM EmployeeSkills_T INNER JOIN Employee_T ON EmployeeSkills_T.EmployeeID = Employee_T.EmployeeID
WHERE SkillID = 'BS12'
) Temp_T ON Temp_T.EmployeeSupervisor = Employee_T.EmployeeID

-- 6-63. Display the salesperson name, product finish, and total quantity sold (label as TotSales) for each finish by each salesperson. 
SELECT SalespersonName, ProductFinish, SUM(OrderedQuantity) AS TotSales
FROM Product_T INNER JOIN OrderLine_T ON Product_T.ProductID = OrderLine_T.ProductID INNER JOIN Order_T ON OrderLine_T.OrderID = Order_T.OrderID INNER JOIN Salesperson_T ON Order_T.SalesPersonID = Salesperson_T.SalespersonID
GROUP BY ProductFinish, SalespersonName

-- 6-64. Write a query to list the number of products produced in each work center (label as TotalProducts).
-- If a work center does not produce any products, display the result with a total of 0. 
SELECT WorkCenterLocation, COUNT(ProductID) AS TotalProducts
FROM WorkCenter_T LEFT OUTER JOIN Producedin_T ON WorkCenter_T.WorkCenterID = Producedin_T.WorkCenterID
GROUP BY WorkCenterLocation

-- 6-65. The production manager at PVFC is concerned about support for purchased parts in products owned by customers. 
-- A simple analysis he wants done is to determine for each customer how many vendors are in the same state as that customer. 
-- Develop a list of all the PVFC customers by name with the number of vendors in the same state as that customer. (Label this computed result NumVendors.) 
SELECT CustomerId, CustomerState, NumberOfVendors
FROM Customer_T INNER JOIN
(
SELECT VendorState, COUNT(VendorID) AS NumberOfVendors
FROM Vendor_T
GROUP BY VendorState
) Will_T
ON Will_T.VendorState = Customer_T.CustomerState

SELECT CustomerName, CustomerState, COUNT(VendorID) AS NumVendors
FROM Customer_T INNER JOIN Vendor_T ON Customer_T.CustomerState = Vendor_T.VendorState
GROUP BY CustomerName, CustomerState

-- 6-70. Display the EmployeeID and EmployeeName for those employees who do not possess the skill Router. Display the results in order by EmployeeName. 
SELECT EmployeeID, EmployeeName
FROM Employee_T
WHERE EmployeeID NOT IN
(
SELECT EmployeeID
FROM EmployeeSkills_T INNER JOIN Skill_T ON EmployeeSkills_T.SkillID = Skill_T.SkillID
WHERE SkillDescription = 'Router'
)

-- 6-74. Show the customer ID and name for all the customers who have ordered both products with IDs 3 and 4 on the same order. 
SELECT Order_T.CustomerID, CustomerName
FROM OrderLine_T INNER JOIN Order_T ON OrderLine_T.OrderID = Order_T.OrderID INNER JOIN Customer_T ON Order_T.CustomerID = Customer_T.CustomerId
WHERE ProductID = 3 AND Customer_T.CustomerId IN
(
SELECT Customer_T.CustomerId
FROM OrderLine_T INNER JOIN Order_T ON OrderLine_T.OrderID = Order_T.OrderID INNER JOIN Customer_T ON Order_T.CustomerID = Customer_T.CustomerId
WHERE ProductID = 4
)

-- 6-75. Display the customer names of all customers who have ordered (on the same or different orders) both products with IDs 3 and 4. -- NEED HELP
SELECT CustomerName, OrderLine_T.ProductID
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerId = Order_T.CustomerID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID
WHERE OrderLine_T.ProductID = '4' AND CustomerName IN
(
SELECT CustomerName
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerId = Order_T.CustomerID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID
WHERE ProductID = '3'
)

-- 6-76. Write an SQL query that lists the vendor ID, vendor name, material ID, material name, and supply unit prices for all those materials 
-- that are provided by more than one vendor. 
SELECT Vendor_T.VendorID, VendorName, Supplies_T.MaterialID, MaterialName, SupplyUnitPrice
FROM Vendor_T INNER JOIN Supplies_T ON Vendor_T.VendorID = Supplies_T.VendorID INNER JOIN RawMaterial_T ON Supplies_T.MaterialID = RawMaterial_T.MaterialID INNER JOIN
(
SELECT Supplies_T.MaterialID, COUNT(Vendor_T.VendorID) AS VendorCount
FROM Vendor_T INNER JOIN Supplies_T ON Vendor_T.VendorID = Supplies_T.VendorID
GROUP BY Supplies_T.MaterialID
)Temp_T ON RawMaterial_T.MaterialID = Temp_T.MaterialID
WHERE VendorCount > 1

-- 6-78. List the IDs and names of all products that cost less than the average product price in their product line. 
SELECT ProductID, ProductDescription
FROM Product_T INNER JOIN
(
SELECT Product_T.ProductLineID, AVG(ProductStandardPrice) AS AveragePrice
FROM Product_T INNER JOIN ProductLine_T ON Product_T.ProductLineID = ProductLine_T.ProductLineID
GROUP BY Product_T.ProductLineID
)Temp_T ON  Product_T.ProductLineID = Temp_T.ProductLineID
WHERE ProductStandardPrice < AveragePrice

-- 6-79. List the IDs and names of those sales territories that have at least 50 percent more customers as the average number of customers per territory. -- NEED HELP
SELECT Territory_T.TerritoryID, TerritoryName, AVG(CustomerCount) AS AvgCustomer
FROM Territory_T INNER JOIN
(
SELECT TerritoryID, COUNT(CustomerID) AS CustomerCount
FROM CustomerShipAddress_T
GROUP BY TerritoryID
)Temp_T ON Territory_T.TerritoryID = Temp_T.TerritoryID
GROUP BY Territory_T.TerritoryID, TerritoryName
HAVING CustomerCount >  AVG(CustomerCount) * 1.5

-- 6-80. Write an SQL query to list the order number, product ID, and ordered quantity for all ordered products for which 
-- the ordered quantity is greater than the average ordered quantity for that product.
SELECT OrderID, OrderLine_T.ProductID, OrderedQuantity
FROM OrderLine_T INNER JOIN
(
SELECT ProductID, AVG(OrderedQuantity) AS ProductAverage
FROM OrderLine_T
GROUP BY ProductID
)Temp_T ON OrderLine_T.ProductID = Temp_T.ProductID
WHERE OrderedQuantity > ProductAverage
ORDER BY OrderID

-- 6-81. Write an SQL query to list the salesperson who has sold the most computer desks.
SELECT TOP(1) Order_T.SalesPersonID, MAX(TotalQuantity) AS TotalSales
FROM Order_T INNER JOIN
(
SELECT SalesPersonID, SUM(OrderedQuantity) AS TotalQuantity
FROM Order_T INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE ProductDescription LIKE '%Computer Desk%'
GROUP BY SalesPersonID
)Temp_T ON Order_T.SalesPersonID = Temp_T.SalesPersonID
GROUP BY Order_T.SalesPersonID

-- 6-82. Display in product ID order the product ID and total amount ordered of that product by the customer who has bought the most of that product; 
-- use a derived table in a FROM clause to answer this query.
SELECT Product_T.ProductID, MAX(BiggestOrder) AS BiggestOrder
FROM Product_T INNER JOIN OrderLine_T ON Product_T.ProductID = OrderLine_T.ProductID INNER JOIN
(
SELECT ProductID, CustomerID, SUM(OrderedQuantity) AS BiggestOrder
FROM OrderLine_T INNER JOIN Order_T ON OrderLine_T.OrderID = Order_T.OrderID
GROUP BY ProductID, CustomerID
) AS Temp_T ON Temp_T.ProductID = OrderLine_T.ProductID
GROUP BY Product_T.ProductID

--___________________________________________________________________________________________________________________________________________________________________________
-- FINAL EXAM
-- 1. List the customers (ID and name) who live in California or New York. Order them by zip code, from high to low. (1 point)
SELECT CustomerId, CustomerName
FROM Customer_T
WHERE CustomerState='CA' OR CustomerState='NY'
ORDER BY CustomerPostalCode DESC

-- 2. Write an SQL query that will find any salesperson (ID) who have not facilitated any order in 2017. (2 points)
SELECT SalespersonID
FROM Salesperson_T
WHERE SalesPersonID NOT IN 
(
SELECT SalesPersonID
FROM Order_T
WHERE YEAR(OrderDate) = '2017'
)

-- 3. Display the product line ID, product line name and the average standard price for Walnut made products 
-- in those product lines that have an average standard price of at least $500. (3 points)
SELECT Product_T.ProductLineID, ProductLineName, AVG(ProductStandardPrice) AS AveragePrice
FROM Product_T INNER JOIN ProductLine_T ON Product_T.ProductLineID = ProductLine_T.ProductLineID
WHERE ProductFinish = 'Walnut'
GROUP BY Product_T.ProductLineID, ProductLineName
HAVING AVG(ProductStandardPrice) >= 500

-- 4. List, in alphabetical order, the names of all employees (managers) who are managing people in the SM1 work center. (3 points)
SELECT EmployeeName AS ManagerName
FROM Employee_T INNER JOIN
(
SELECT WorksIn_T.EmployeeID, WorkCenterID, EmployeeSupervisor
FROM WorksIn_T INNER JOIN Employee_T On WorksIn_T.EmployeeID = Employee_T.EmployeeID
WHERE WorkCenterID = 'SM1'
) Temp_T ON Temp_T.EmployeeSupervisor = Employee_T.EmployeeID
ORDER BY EmployeeName

-- 5. Write a query to list the SalesPersonID, SalesPersonName and the number of orders facilitated (label as TotalOrders). 
-- If a salesperson does not facilitate any orders, display the result with a total of 0. (3 points)
SELECT Salesperson_T.SalespersonID, SalespersonName, COUNT(OrderID) AS TotalOrders
FROM Salesperson_T LEFT OUTER JOIN Order_T ON Salesperson_T.SalespersonID = Order_T.SalesPersonID
GROUP BY Salesperson_T.SalespersonID, SalespersonName

-- 6. Retrieve a list of the customer states and the total profit earned from all of their orders on the Cherry and Birch products. 
-- Profit earned on a given order is the order total minus the total cost to produce the products sold. 
-- The cost of production for a given product is the total cost of all raw materials consumed in production. 
-- The query should output the state, total amount of all orders placed by its customers, total cost of production of all products sold in these orders, 
-- and total dollars profit earned. The output should be limited to the states with at least $2000 profit. Sort the results in descending order of profit. (3 points)
SELECT CustomerState, SUM(OrderedQuantity * ProductStandardPrice) AS TotalOfAllOrders, SUM(TotalCost * OrderedQuantity) AS TotalCost, (SUM(OrderedQuantity * ProductStandardPrice) - SUM(TotalCost * OrderedQuantity)) AS TotalProfit
FROM Customer_T INNER JOIN Order_T ON Customer_T.CustomerId = Order_T.CustomerID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID INNER JOIN
(
SELECT Product_T.ProductID, SUM(MaterialStandardPrice*QuantityRequired) AS TotalCost
FROM Product_T INNER JOIN Uses_T ON Product_T.ProductID = Uses_T.ProductID INNER JOIN RawMaterial_T ON Uses_T.MaterialID = RawMaterial_T.MaterialID
WHERE ProductFinish IN ('Cherry', 'Birch')
GROUP BY Product_T.ProductID
) TotalCosts_T 
ON Product_T.ProductID = TotalCosts_T.ProductID
GROUP BY CustomerState
HAVING (SUM(OrderedQuantity * ProductStandardPrice) - SUM(TotalCost * OrderedQuantity)) >= 2000
ORDER BY (SUM(OrderedQuantity * ProductStandardPrice) - SUM(TotalCost * OrderedQuantity)) DESC

-- 7. Write an SQL query to list the order ID, product ID, and ordered quantity for all ordered products for which 
-- the ordered quantity is at least three times the average ordered quantity for that product. 
-- Also, the average ordered quantity for each product should appear at the end in a separate column. 
-- Limit the output to the products with the average ordered quantity of at least 2 . (3 points)
SELECT OrderID, OrderLine_T.ProductID, OrderedQuantity, ProductAverage
FROM OrderLine_T INNER JOIN
(
SELECT ProductID, AVG(OrderedQuantity) AS ProductAverage
FROM OrderLine_T
GROUP BY ProductID
)Temp_T ON OrderLine_T.ProductID = Temp_T.ProductID
WHERE OrderedQuantity >= ProductAverage * 3 AND ProductAverage >= 2
ORDER BY OrderID

-- 8. For the those Ash materials that are provided by at least two vendors, 
-- write a query that lists the vendor ID, vendor name, material ID, material name, and size. (4 points)
SELECT Vendor_T.VendorID, VendorName, Supplies_T.MaterialID, MaterialName, Size
FROM Vendor_T INNER JOIN Supplies_T ON Vendor_T.VendorID = Supplies_T.VendorID INNER JOIN RawMaterial_T ON Supplies_T.MaterialID = RawMaterial_T.MaterialID INNER JOIN
(
SELECT Supplies_T.MaterialID, COUNT(Vendor_T.VendorID) AS VendorCount
FROM Vendor_T INNER JOIN Supplies_T ON Vendor_T.VendorID = Supplies_T.VendorID INNER JOIN RawMaterial_T ON Supplies_T.MaterialID = RawMaterial_T.MaterialID
GROUP BY Supplies_T.MaterialID
)Temp_T ON RawMaterial_T.MaterialID = Temp_T.MaterialID
WHERE VendorCount >= 2 AND Material = 'Ash'

-- 9. Display the salesperson names of all salespersons who have ordered at least one Cherry product 
-- and at least one Walnut product on the same or different orders. (4 points)
SELECT DISTINCT Salesperson_T.SalespersonName
FROM Salesperson_T INNER JOIN Order_T ON Salesperson_T.SalespersonID = Order_T.SalesPersonID
WHERE 
(Salesperson_T.SalespersonName IN
(
SELECT Salesperson_T.SalespersonName 
FROM Salesperson_T INNER JOIN Order_T ON Salesperson_T.SalespersonID = Order_T.SalesPersonID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE ProductFinish = 'Cherry')) AND 
(Salesperson_T.SalespersonName IN
(
SELECT Salesperson_T.SalespersonName 
FROM Salesperson_T INNER JOIN Order_T ON Salesperson_T.SalespersonID = Order_T.SalesPersonID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
WHERE ProductFinish = 'Walnut' 
))

-- 10. Retrieve a list of salespersons and the orders they have each facilitated, including order ID, order date, and order total price. 
-- Each order facilitated by a salesperson contributes to their total sales. 
-- Also provide the contribution of each order to the salesperson's total sales, as a percentage of total sales. 
-- The query should output the salesperson name, order ID, order date, order total price, distinct number of orders facilitated by salesperson, 
-- and percentage of salesperson total sales. Exclude orders with more than 30% contribution. 
-- Sort the list first in alphabetical order of salesperson name, then by ascending order date, and then with larger order totals listed first. (4 points)
SELECT SalespersonName, Order_T.OrderID, OrderDate, SUM(OrderedQuantity * ProductStandardPrice) AS OrderTotalPrice, DistinctOrders, SUM((OrderedQuantity * ProductStandardPrice) / TotalSales * 100) AS PercentageofSales
FROM Salesperson_T INNER JOIN Order_T ON Salesperson_T.SalespersonID = Order_T.SalesPersonID INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID INNER JOIN
(
SELECT SalesPersonID, SUM(OrderedQuantity * ProductStandardPrice) AS TotalSales, COUNT (DISTINCT Order_T.OrderID) AS DistinctOrders
FROM Order_T INNER JOIN OrderLine_T ON Order_T.OrderID = OrderLine_T.OrderID INNER JOIN Product_T ON OrderLine_T.ProductID = Product_T.ProductID
GROUP BY SalesPersonID
) TotalSales_T 
ON Order_T.SalespersonID = TotalSales_T.SalespersonID 
GROUP BY SalespersonName, Order_T.OrderID, OrderDate, DistinctOrders
HAVING SUM(((OrderedQuantity * ProductStandardPrice) / TotalSales) * 100) <= 30
ORDER BY SalespersonName ASC, OrderDate ASC, OrderTotalPrice DESC
