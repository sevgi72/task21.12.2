CREATE DATABASE Restaurant
USE Restaurant

CREATE TABLE Meals
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50),
Price DECIMAL(18,2)
)
CREATE TABLE [Tables]
(
Id INT PRIMARY KEY IDENTITY,
TableNo INT ,
)
CREATE TABLE Orders
(
Id INT PRIMARY KEY IDENTITY,
MealId INT FOREIGN KEY REFERENCES Meals(Id),
TableId INT FOREIGN KEY REFERENCES [Tables](Id),
OrderDate DATETIME NOT NULL
)
-- Insert into Meals
INSERT INTO Meals ([Name], Price)
VALUES
('Burger', 8.99),
('Pizza', 12.50),
('Pasta', 10.75),
('Salad', 6.25);

-- Insert into Tables
INSERT INTO [Tables] (TableNo)
VALUES
(1),
(2),
(3),
(4);

-- Insert into Orders
-- Make sure MealId and TableId exist in Meals and Tables
INSERT INTO Orders (Id, MealId, TableId, OrderDate)
VALUES
(1, 1, 1, GETDATE()),
(2, 2, 2, GETDATE()),
(3, 3, 1, GETDATE()),
(4, 4, 3, GETDATE());


SELECT t.* , COUNT(o.Id) AS OrderCount  FROM [Tables] t
JOIN Orders o 
ON t.Id=o.TableId
GROUP BY t.Id ,t.TableNo;

SELECT m.[Name] , COUNT (o.Id) AS OrderCount FROM Meals m
JOIN Orders o 
ON m.Id=o.MealId
GROUP BY m.[Name]

SELECT o.* , m.Name AS MealName  FROM Orders o
JOIN Meals m
ON m.Id=o.MealId


SELECT o.* , m.Name AS MealName, t.TableNo FROM Orders o
JOIN Meals m
ON m.Id=o.MealId
JOIN [Tables] T
ON t.Id=o.TableId


SELECT t.TableNo ,SUM(m.Price) AS TotalAmount FROM [Tables] t
JOIN Orders o
ON t.Id=o.TableId
JOIN  Meals m
ON m.Id=o.MealId
GROUP BY t.TableNo

SELECT DATEDIFF(HOUR,MIN(OrderDate),MAX(OrderDate)) AS DateDifference FROM Orders o WHERE o.TableId=1;

SELECT * FROM Orders
WHERE OrderDate<DATEADD(MINUTE,-30,GETDATE())


SELECT * FROM Tables t
JOIN OrderS o
ON t.Id=o.TableId
WHERE o.Id=null

SELECT DATEADD(MINUTE,-60,GETDATE()) AS LastOrder FROM Tables t
JOIN Orders o
ON t.Id=o.TableId
WHERE o.Id=null
