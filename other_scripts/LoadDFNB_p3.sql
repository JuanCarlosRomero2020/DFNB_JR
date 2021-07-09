
/*****************************************************************************************************************
NAME:    Create and LoadData P3
PURPOSE: ETL process for creating and loading data for project 3 IT 240
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     07/9/2021   JCRomero       1. Built this table for LDS BC IT240 Project 3
2.0     07/9/2021   JCRomero       1. Load this table for LDS BC IT240 Project 3


RUNTIME: 
30 sec

NOTES: 
This script is the final solution for Project 3.4: Create v1 of Prototype Script. It is designed so you can
run the entire script (F5) repeatedly 

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.

******************************************************************************************************************/

-- 1) Drop contraints
-- Q1: How to drop tables with Foreign Keys?
-- A1: Check to see if Foreign Keys Exist, drop the Foreign Keys first, then drop the tables
-- https://stackoverflow.com/questions/1776079/sql-drop-table-foreign-key-constraint
--IF EXISTS
--(
--    SELECT fk.*
--      FROM sys.foreign_keys AS fk
--     WHERE fk.name = 'FK_tblBranchDim_branch_id_tblOpendateAcct_BranchFact'
--           AND parent_object_id = OBJECT_ID(N'dbo.tblTransactionFact')
--)
--    BEGIN
--        ALTER TABLE dbo.tblOpendateAcct_BranchFact DROP CONSTRAINT FK_tblTransactionFact_branch_id_tblBranchDim_branch_id;
--END;
--IF EXISTS
--(
--    SELECT fk.*
--      FROM sys.foreign_keys AS fk
--     WHERE fk.name = 'FK_tblTransactionFact_acct_id_tblAccountDim_acct_id'
--           AND parent_object_id = OBJECT_ID(N'dbo.tblTransactionFact')
--)
--    BEGIN
--        ALTER TABLE dbo.tblTransactionFact DROP CONSTRAINT FK_tblTransactionFact_acct_id_tblAccountDim_acct_id;
--END;
--IF EXISTS
--(
--    SELECT fk.*
--      FROM sys.foreign_keys AS fk
--     WHERE fk.name = 'FK_tblTransactionFact_tran_type_id_tblTransactionTypeDim_tran_type_id'
--           AND parent_object_id = OBJECT_ID(N'dbo.tblTransactionFact')
--)
--    BEGIN
--        ALTER TABLE dbo.tblTransactionFact DROP CONSTRAINT FK_tblTransactionFact_tran_type_id_tblTransactionTypeDim_tran_type_id;
--END;
-- 2) Create the empty table shells
-- Q2: How to check for table to see if it exists before attempting to drop it?
-- A2: Thusly...
-- https://stackoverflow.com/questions/167576/check-if-table-exists-in-sql-server
-- 2.1) Open date account vs Loan Branch fact table OpendateAcct_BranchFact
-- Q2.1: How to define uniqueness in this dimension?
-- A2.1: Here it is...
-- 11
SELECT a.prod_id, --FK
       YEAR(a.open_date) AS open_year, 
       MONTH(a.open_date) AS open_month, 
       SUM(a.loan_amt) AS total_loan_amount, 
       a.[open_close_code] AS STATUS, 
       b.[prod_desc], 
       c.[branch_desc], 
       c.[branch_id], --FK
       SUM(a.loan_amt) * 0.05 AS Total_Anual_Revenue, 
       SUM(a.loan_amt) * 0.05 / 12 AS Total_Monthly_revenue
FROM [dbo].[tblAccountDim] AS a
     INNER JOIN dbo.tblBranchDim AS c ON a.branch_id = c.branch_id
     INNER JOIN dbo.tblProductDim AS b ON a.prod_id = b.prod_id
WHERE [open_close_code] = 'o'
GROUP BY a.prod_id, 
         a.open_date, 
         a.[open_close_code], 
         b.prod_desc, 
         c.[branch_desc], 
         c.[branch_id], 
         a.[loan_amt]
ORDER BY 1, 
         2;
IF OBJECT_ID('dbo.tblOpenDateAcct_BranchFact', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblOpenDateAcct_BranchFact;
END;
SELECT a.prod_id, --FK
       YEAR(a.open_date) AS open_year, 
       MONTH(a.open_date) AS open_month, 
       SUM(a.loan_amt) AS total_loan_amount, 
       a.[open_close_code] AS STATUS, 
       b.[prod_desc], 
       c.[branch_desc], 
       c.[branch_id], --FK
       SUM(a.loan_amt) * 0.05 AS Total_Anual_Revenue, 
       SUM(a.loan_amt) * 0.05 / 12 AS Total_Monthly_revenue
INTO dbo.tblOpenDateAcct_BranchFact
FROM [dbo].[tblAccountDim] AS a
     INNER JOIN dbo.tblBranchDim AS c ON a.branch_id = c.branch_id
     INNER JOIN dbo.tblProductDim AS b ON a.prod_id = b.prod_id
WHERE 1 = 2
GROUP BY a.prod_id, 
         a.open_date, 
         a.[open_close_code], 
         b.prod_desc, 
         c.[branch_desc], 
         c.[branch_id], 
         a.[loan_amt]
ORDER BY open_date ASC;

-- 2.2) Open date Acct vs Loan Customer Fact (dbo.OpendateAcct_CustFact)
-- Q2.2: What is the primary key for this fact table?
-- A2.2: Composite Key = tran_date | tran_time | branch_id | tran_type_id | acct_id
-- 0
SELECT a.prod_id, 
       YEAR(a.open_date) AS open_year, 
       MONTH(a.open_date) AS open_month, 
       SUM(a.loan_amt) AS total_loan_amount, 
       a.[open_close_code] AS STATUS, 
       b.[prod_desc], 
       c.[cust_id], 
       COUNT(c.[cust_id]) AS Total_customers, 
       CONCAT(c.[first_name], ' ', c.[last_name]) AS Name, 
       SUM(a.loan_amt) * 0.05 AS Total_Anual_Revenue, 
       SUM(a.loan_amt) * 0.05 / 12 AS Total_Monthly_revenue
FROM [dbo].[tblAccountDim] AS a
     INNER JOIN dbo.tblCustomerDim AS c ON a.pri_cust_id = c.cust_id
     INNER JOIN dbo.tblProductDim AS b ON a.prod_id = b.prod_id
WHERE [open_close_code] = 'o'
GROUP BY a.prod_id, 
         a.open_date, 
         a.[open_close_code], 
         b.prod_desc, 
         c.[cust_id], 
         c.[first_name], 
         c.[last_name], 
         a.[loan_amt]
ORDER BY open_date ASC;
IF OBJECT_ID('dbo.tblOpendateAcct_CustFact', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblOpendateAcct_CustFact;
END;
SELECT a.prod_id, 
       YEAR(a.open_date) AS open_year, 
       MONTH(a.open_date) AS open_month, 
       SUM(a.loan_amt) AS total_loan_amount, 
       a.[open_close_code] AS STATUS, 
       b.[prod_desc], 
       c.[cust_id], 
       COUNT(c.[cust_id]) AS Total_customers, 
       CONCAT(c.[first_name], ' ', c.[last_name]) AS Name, 
       SUM(a.loan_amt) * 0.05 AS Total_Anual_Revenue, 
       SUM(a.loan_amt) * 0.05 / 12 AS Total_Monthly_revenue
INTO dbo.tblOpendateAcct_CustFact
FROM [dbo].[tblAccountDim] AS a
     INNER JOIN dbo.tblCustomerDim AS c ON a.pri_cust_id = c.cust_id
     INNER JOIN dbo.tblProductDim AS b ON a.prod_id = b.prod_id
WHERE 1 = 2
GROUP BY a.prod_id, 
         a.open_date, 
         a.[open_close_code], 
         b.prod_desc, 
         c.[cust_id], 
         c.[first_name], 
         c.[last_name], 
         a.[loan_amt]
ORDER BY open_date ASC;

--ALTER TABLE dbo.tblTransactionFact ADD tran_id INT IDENTITY;
--- 2.3) table 3 Revenue anual Goals (dbo.tblLoanRevenueGoalsFact)

SELECT OAB.[open_year], 
       OAB.[branch_desc], 
       SUM(OAB.[Total_Anual_Revenue]) AS Total_Anual_Revenue, 
       SUM(OAB.[Total_Anual_Revenue]) * 0.05 + SUM(OAB.[Total_Anual_Revenue]) AS Goal_Total_Anual_Revenue, 
       AVG(OAB.[Total_Anual_Revenue]) AS Avetage_Total_Anual_Revenue, 
       AVG(OAB.[Total_Anual_Revenue]) * 0.05 + AVG(OAB.[Total_Anual_Revenue]) AS Goal_Avetage_Total_Anual_Revenue
FROM dbo.tblOpenDateAcct_BranchFact AS OAB
GROUP BY open_year, 
         branch_desc
ORDER BY 1 ASC;
IF OBJECT_ID('dbo.tblLoanRevenueGoalsFact', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblLoanRevenueGoalsFact;
END;
SELECT OAB.[open_year], 
       OAB.[branch_desc], 
       SUM(OAB.[Total_Anual_Revenue]) AS Total_Anual_Revenue, 
       SUM(OAB.[Total_Anual_Revenue]) * 0.05 + SUM(OAB.[Total_Anual_Revenue]) AS Goal_Total_Anual_Revenue, 
       AVG(OAB.[Total_Anual_Revenue]) AS Avetage_Total_Anual_Revenue, 
       AVG(OAB.[Total_Anual_Revenue]) * 0.05 + AVG(OAB.[Total_Anual_Revenue]) AS Goal_Avetage_Total_Anual_Revenue
INTO dbo.tblLoanRevenueGoalsFact
FROM dbo.tblOpenDateAcct_BranchFact AS OAB
WHERE 1 = 2
GROUP BY open_year, 
         branch_desc
ORDER BY 1 ASC;

-- 3) Load tables
-- 3.1) Account Loan Branch Fact

TRUNCATE TABLE dbo.tblOpenDateAcct_BranchFact;
INSERT INTO dbo.tblOpenDateAcct_BranchFact
       SELECT a.prod_id, --FK
              YEAR(a.open_date) AS open_year, 
              MONTH(a.open_date) AS open_month, 
              SUM(a.loan_amt) AS total_loan_amount, 
              a.[open_close_code] AS STATUS, 
              b.[prod_desc], 
              c.[branch_desc], 
              c.[branch_id], --FK
              SUM(a.loan_amt) * 0.05 AS Total_Anual_Revenue, 
              SUM(a.loan_amt) * 0.05 / 12 AS Total_Monthly_revenue
       FROM [dbo].[tblAccountDim] AS a
            INNER JOIN dbo.tblBranchDim AS c ON a.branch_id = c.branch_id
            INNER JOIN dbo.tblProductDim AS b ON a.prod_id = b.prod_id
       GROUP BY a.prod_id, 
                a.open_date, 
                a.[open_close_code], 
                b.prod_desc, 
                c.[branch_desc], 
                c.[branch_id], 
                a.[loan_amt]
       ORDER BY open_date ASC;

-- 3.2) Load Account open date vs Customer Fact table 

TRUNCATE TABLE dbo.tblOpendateAcct_CustFact;
INSERT INTO dbo.tblOpendateAcct_CustFact
       SELECT a.prod_id, 
              YEAR(a.open_date) AS open_year, 
              MONTH(a.open_date) AS open_month, 
              SUM(a.loan_amt) AS total_loan_amount, 
              a.[open_close_code] AS STATUS, 
              b.[prod_desc], 
              c.[cust_id], 
              COUNT(c.[cust_id]) AS Total_customers, 
              CONCAT(c.[first_name], ' ', c.[last_name]) AS Name, 
              SUM(a.loan_amt) * 0.05 AS Total_Anual_Revenue, 
              SUM(a.loan_amt) * 0.05 / 12 AS Total_Monthly_revenue
       FROM [dbo].[tblAccountDim] AS a
            INNER JOIN dbo.tblCustomerDim AS c ON a.pri_cust_id = c.cust_id
            INNER JOIN dbo.tblProductDim AS b ON a.prod_id = b.prod_id
       GROUP BY a.prod_id, 
                a.open_date, 
                a.[open_close_code], 
                b.prod_desc, 
                c.[cust_id], 
                c.[first_name], 
                c.[last_name], 
                a.[loan_amt]
       ORDER BY open_date ASC;

-- 3.3) Load Anual Revenue Table

TRUNCATE TABLE dbo.tblLoanRevenueGoalsFact;

INSERT INTO dbo.tblLoanRevenueGoalsFact
       SELECT OAB.[open_year], 
              OAB.[branch_desc], 
              SUM(OAB.[Total_Anual_Revenue]) AS Total_Anual_Revenue, 
              SUM(OAB.[Total_Anual_Revenue]) * 0.05 + SUM(OAB.[Total_Anual_Revenue]) AS Goal_Total_Anual_Revenue, 
              AVG(OAB.[Total_Anual_Revenue]) AS Avetage_Total_Anual_Revenue, 
              AVG(OAB.[Total_Anual_Revenue]) * 0.05 + AVG(OAB.[Total_Anual_Revenue]) AS Goal_Avetage_Total_Anual_Revenue
       FROM dbo.tblOpenDateAcct_BranchFact AS OAB
       GROUP BY open_year, 
                branch_desc
       ORDER BY 1 ASC;

-- 4) Referential integrity
-- 4.1) Primary Keys
-- 4.1.1) Transaction Type Dimension
-- Q4.1: How to define the PK?
-- A4.1: Simple - Transaction Type ID
--IF EXISTS
--(
--    SELECT 1
--      FROM sys.key_constraints
--     WHERE type = 'PK'
--           AND parent_object_id = OBJECT_ID('dbo.tblTransactionTypeDim')
--)
--    BEGIN
--        ALTER TABLE dbo.tblTransactionTypeDim DROP CONSTRAINT PK_tblTransactionTypeDim;
--END; 
--ALTER TABLE dbo.tblTransactionTypeDim
--ADD CONSTRAINT PK_tblTransactionTypeDim PRIMARY KEY(tran_type_id);
-- 4.1.2) Transaction Fact
-- Q4.1: How to define the PK?
-- A4.1: Thusly...
-- PK = Transaction ID
--IF EXISTS
--(
--    SELECT 1
--      FROM sys.key_constraints
--     WHERE type = 'PK'
--           AND parent_object_id = OBJECT_ID('dbo.tblTransactionFact')
--)
--    BEGIN
--        ALTER TABLE dbo.tblTransactionFact DROP CONSTRAINT PK_tblTransactionFact;
--END; 
--ALTER TABLE dbo.tblTransactionFact
--ADD CONSTRAINT PK_tblTransactionFact PRIMARY KEY(tran_id);
-- Alternate PK (APK) = tran_date | tran_time | branch_id | tran_type_id | acct_id
--IF EXISTS
--(
--    SELECT *
--      FROM sys.indexes
--     WHERE name = 'APK_tblTransactionFact'
--)
--    BEGIN
--        DROP INDEX APK_tblTransactionFact ON dbo.tblTransactionFact;
--END; 
--CREATE UNIQUE NONCLUSTERED INDEX APK_tblTransactionFact ON dbo.tblTransactionFact
--(
--	tran_date ASC,
--	tran_time ASC,
--	branch_id ASC,
--	acct_id ASC,
--	tran_type_id ASC
--);
-- 4.2) Foreign Keys
-- 4.2.1) Transaction Type Dimension
-- 4.2.2) Transaction Fact
--IF EXISTS
--(
--    SELECT fk.*
--      FROM sys.foreign_keys AS fk
--     WHERE fk.name = 'FK_tblTransactionFact_branch_id_tblBranchDim_branch_id'
--           AND parent_object_id = OBJECT_ID(N'dbo.tblTransactionFact')
--)
--    BEGIN
--        ALTER TABLE dbo.tblTransactionFact DROP CONSTRAINT FK_tblTransactionFact_branch_id_tblBranchDim_branch_id;
--END;
--ALTER TABLE dbo.tblTransactionFact
--ADD CONSTRAINT FK_tblTransactionFact_branch_id_tblTransactionFact_branch_id FOREIGN KEY(branch_id) REFERENCES dbo.tblBranchDim(branch_id);
----IF EXISTS
----(
----    SELECT fk.*
----      FROM sys.foreign_keys AS fk
----     WHERE fk.name = 'FK_tblTransactionFact_acct_id_tblAccountDim_acct_id'
----           AND parent_object_id = OBJECT_ID(N'dbo.tblTransactionFact')
----)
----    BEGIN
----        ALTER TABLE dbo.tblTransactionFact DROP CONSTRAINT FK_tblTransactionFact_acct_id_tblAccountDim_acct_id;
----END;
----ALTER TABLE dbo.tblTransactionFact
----ADD CONSTRAINT FK_tblTransactionFact_acct_id_tblAccountDim_acct_id FOREIGN KEY(acct_id) REFERENCES dbo.tblAccountDim(acct_id);
--IF EXISTS
--(
--    SELECT fk.*
--      FROM sys.foreign_keys AS fk
--     WHERE fk.name = 'FK_tblTransactionFact_tran_type_id_tblTransactionTypeDim_tran_type_id'
--           AND parent_object_id = OBJECT_ID(N'dbo.tblTransactionFact')
--)
--    BEGIN
--        ALTER TABLE dbo.tblTransactionFact DROP CONSTRAINT FK_tblTransactionFact_tran_type_id_tblTransactionTypeDim_tran_type_id;
--END;
--ALTER TABLE dbo.tblTransactionFact
--ADD CONSTRAINT FK_tblTransactionFact_tran_type_id_tblTransactionTypeDim_tran_type_id FOREIGN KEY(tran_type_id) REFERENCES dbo.tblTransactionTypeDim(tran_type_id);