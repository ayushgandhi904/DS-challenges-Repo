-- Q-11
-- Create a student table

CREATE TABLE Student (
	ID INT PRIMARY KEY NOT NULL,
    NAME VARCHAR(25) NOT NULL,
    AGE INT NOT NULL,
    ADDRESS VARCHAR(40)
);

-- Inserting 5 records

INSERT INTO Student (ID, NAME, AGE, ADDRESS)
VALUES
	(1, 'Ayush Gandhi', 20, 'Vadodara'),
    (2, 'Hemil Gandhi', 19, 'Vadodara'),
    (3, 'Roma Patel', 24, 'Delhi'),
    (4, 'Rajesh Vyas', 29, 'Mumbai'),
    (5, 'Sachin Tendulkar', 40, 'Mumbai');
    

-- Q-12
-- Finding student with youngest age
SELECT *
FROM STUDENT
ORDER BY AGE ASC
LIMIT 1;


-- Q-13 
SELECT p.Name, a.Address
FROM Person p
JOIN Address a ON p.PersonID = a.PersonID;

-- Q-14
SELECT DISTINCT Age
FROM Student
ORDER BY Age DESC
LIMIT 1 OFFSET 1;


-- Q-15
SELECT DISTINCT Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;


-- Q-16
SELECT CompanyID, 
       AVG(Salary) AS MedianSalary
FROM (
    SELECT e1.CompanyID, 
           e1.Salary,
           COUNT(e2.Salary) AS SalaryCount
    FROM Employee e1
    JOIN Employee e2 ON e1.CompanyID = e2.CompanyID AND e1.Salary >= e2.Salary
    GROUP BY e1.CompanyID, e1.Salary
    HAVING ABS(SUM(SalaryCount) - COUNT(*)) <= 1
) AS MedianQuery
GROUP BY CompanyID;


-- Q-17
WITH SalaryData AS (
    SELECT
        ID,
        DATE_TRUNC('month', Month) AS Month,
        SUM(Salary) OVER (PARTITION BY ID ORDER BY Month ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS CumulativeSum
    FROM Employee
)
SELECT ID, Month, CumulativeSum
FROM SalaryData
ORDER BY ID ASC, Month DESC;

-- Q-18
SELECT 
    p1.PointID AS Point1ID,
    p2.PointID AS Point2ID,
    SQRT(POW(p2.X - p1.X, 2) + POW(p2.Y - p1.Y, 2)) AS Distance
FROM Points p1
CROSS JOIN Points p2
WHERE p1.PointID <> p2.PointID
ORDER BY Distance
LIMIT 1;

-- Q-19
SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY OrderCount DESC, CustomerName ASC
LIMIT 5;

-- Q-20
SELECT
    b.title AS ProductName,
    SUM(o.quantity) AS TotalQuantitySold
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY TotalQuantitySold DESC
LIMIT 3;






