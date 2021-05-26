--Q1: By Order Quantity, what were the five most popular products sold in 2014?

--Include these data points in the output:

--Order Date Year

--Product ID

--Product Name

--Product Number

--Product Color

--Sales Order Count

--Order Quantity

--Sales Order Line total

--A1: Here they are
--OrderDateYear	ProductID	ProductName	ProductNumber	ProductColor	SalesOrderIDCount	OrderQtySum	SalesOrderLineTotalSum
--2014	         870	    Water Bottle - 30 oz.	WB-H098	NULL	2273	2902	12900.317660
--2014	         712	    AWC Logo Cap	CA-1098   	   Multi	1267	1950	14430.970952
--2014	         711	    Sport-100 Helmet,               Blue	HL-U509-B	Blue	1221	1776	52353.591556
--2014	         873	    Patch Kit/8 Patches	PK-7098  	NULL	1608	1761	3850.406000
--2014	         707	    Sport-100 Helmet, Red	HL-U509-R	Red	1231	1717	51697.665517

SELECT TOP 5 YEAR(soh.OrderDate) AS OrderDateYear, 
             p.ProductID, 
             p.Name AS ProductName, 
             p.ProductNumber, 
             p.Color AS ProductColor, 
             COUNT(sod.SalesOrderID) AS SalesOrderIDCount, 
             SUM(sod.OrderQty) AS OrderQtySum, 
             SUM(sod.LineTotal) AS SalesOrderLineTotalSum
FROM Production.Product AS p
     INNER JOIN Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
     INNER JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE YEAR(soh.OrderDate) = 2014
GROUP BY YEAR(soh.OrderDate), 
         p.ProductID, 
         p.Name, 
         p.ProductNumber, 
         p.Color
ORDER BY 7 DESC;
   

--Q2: How long are the 7 longest Person names and to whom do they belong? Rank by Full Name length, Last Name Length, First Name Length

--Include these data points in the output:

--Business Entity ID

--Full Name

--Full Name Length

--First Name

--First Name Length

--Middle Name

--Last Name

--Last Name Length

-- A2: Here they are
--BusinessEntityID	FullName	FullNameLenght	FirstName	FirstNameLength	MiddleName	LastName	LastNameLength
--4388	Osarumwense Uwaifiokun Agbonile	31	Osarumwense	11	Uwaifiokun	Agbonile	8
--1979	Ranjit Rudra Varkey Chudukatil	30	Ranjit	6	Rudra	Varkey Chudukatil	17
--565	Janaina Barreiro Gambaro Bueno	30	Janaina Barreiro Gambaro	24	NULL	Bueno	5
--272	Janaina Barreiro Gambaro Bueno	30	Janaina	7	Barreiro Gambaro	Bueno	5
--2348	Janaina Barreiro Gambaro Bueno	30	Janaina	7	Barreiro Gambaro	Bueno	5
--775	Alvaro De Matos Miranda Filho	29	Alvaro	6	NULL	De Matos Miranda Filho	22
--1619	Paulo Sergio Da Silva Pinto	27	Paulo	5	Sergio Da Silva	Pinto	5

SELECT TOP 7 p.BusinessEntityID, 
             REPLACE(COALESCE(p.FirstName, '') + ' ' + COALESCE(p.MiddleName, '') + ' ' + COALESCE(p.LastName, ''), '  ', ' ') AS FullName, 
             LEN(REPLACE(COALESCE(p.FirstName, '') + ' ' + COALESCE(p.MiddleName, '') + ' ' + COALESCE(p.LastName, ''), '  ', ' ')) AS FullNameLenght, 
             p.FirstName, 
             LEN(p.FirstName) AS FirstNameLength, 
             p.MiddleName, 
             p.LastName, 
             LEN(p.LastName) AS LastNameLength
FROM Person.Person AS p
ORDER BY 3 DESC, 
         8 DESC, 
         5 DESC;
	    

--Q3: Which Department pays its female workers on average the most per year?

--Include these fields:

--Department ID

--Department Name

--Gender

--Total Yearly Pay

--Business Entity ID Count

--Average Yearly Pay

-- A3: Here they are
--DepartmentID	DepartmentName	Gender	TotalYearlyPay	BusinessEntityIDCount	AverageYearlyPay
--2	Tool Design	F	52000.00	1	52000.00
--16	Executive	F	147713.90	3	49237.9666
--1	Engineering	F	128846.10	3	42948.70
--10	Finance	F	335985.40	8	41998.175
--6	Research and Development	F	81730.80	2	40865.40
--11	Information Services	F	144951.90	4	36237.975
--9	Human Resources	F	61639.32	2	30819.66
--7	Production	F	1322464.00	46	28749.2173
--5	Purchasing	F	164879.872	6	27479.9786
--3	Sales	F	186562.40	7	26651.7714

WITH s1
     AS (SELECT d.DepartmentID, 
                d.Name AS DepartmentName, 
                e.Gender, 
                eph.Rate, 
                eph.PayFrequency, 
                e.SalariedFlag,
                CASE
                    WHEN e.SalariedFlag = 1
                    THEN rate * 1000
                    WHEN e.SalariedFlag = 0
                    THEN rate * 2000
                    ELSE 0
                END AS YearlyPay, 
                COUNT(e.BusinessEntityID) AS BusinessEntityIDCount,
                CASE
                    WHEN e.SalariedFlag = 1
                    THEN rate * 1000
                    WHEN e.SalariedFlag = 0
                    THEN rate * 2080
                    ELSE 0
                END * COUNT(e.BusinessEntityID) AS TotalYearlyPay
         FROM HumanResources.Employee AS e
              INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh ON e.BusinessEntityID = edh.BusinessEntityID
              INNER JOIN HumanResources.EmployeePayHistory AS eph ON edh.BusinessEntityID = eph.BusinessEntityID
              INNER JOIN HumanResources.Department AS d ON edh.DepartmentID = d.DepartmentID
         WHERE e.Gender = 'F'
         GROUP BY d.DepartmentID, 
                  d.Name, 
                  e.Gender, 
                  eph.Rate, 
                  eph.PayFrequency, 
                  e.SalariedFlag,
                  CASE
                      WHEN e.SalariedFlag = 1
                      THEN rate * 1000
                      WHEN e.SalariedFlag = 0
                      THEN rate * 2080
                      ELSE 0
                  END)
     SELECT TOP 10 s1.DepartmentID, 
                   s1.DepartmentName, 
                   s1.Gender, 
                   SUM(s1.TotalYearlyPay) AS TotalYearlyPay, 
                   SUM(s1.BusinessEntityIDCount) AS BusinessEntityIDCount, 
                   SUM(s1.TotalYearlyPay) / SUM(s1.BusinessEntityIDCount) AS AverageYearlyPay
     FROM s1
     GROUP BY s1.DepartmentID, 
              s1.DepartmentName, 
              s1.Gender
     ORDER BY 6 DESC;

