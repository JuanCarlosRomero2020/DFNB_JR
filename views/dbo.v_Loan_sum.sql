USE [DFNB2]
GO

/****** Object:  View [dbo].[v_Loan_sum]    Script Date: 6/15/2021 3:40:23 PM ******/
DROP VIEW [dbo].[v_Loan_sum]
GO

/****** Object:  View [dbo].[v_Loan_sum]    Script Date: 6/15/2021 3:40:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[v_Loan_sum]
AS
/*****************************************************************************************************************
NAME:    DataAnalysisForQ1Q2Q3.sql
PURPOSE: Data Analysis for Q1, Q2, Q3

SUPPORT: Jaussi Consulting LLC
         www.jaussiconsulting.net
         jon@jaussiconsulting.net

MODIFICATION LOG:
Ver       Date         Author       Description
-         -
1.0       06/15/2021   JCRomero      1. Built this script for LDS BC IT 240


RUNTIME: 
Approx. 1 min

NOTES: 
Creates a denormalized view of the data points required to answer the questions, then generates appropriately
grained output for the Excel Pivot table

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.

******************************************************************************************************************/
     SELECT b.branch_id, 
            b.branch_desc, 
            YEAR(a.open_date) AS year, 
            MONTH(a.open_date) AS month, 
            SUM(a.loan_amt) AS total,
			COUNT(c.cust_id) AS totalcustomer
     FROM  dbo.tblBranchDim AS b
	 INNER JOIN  dbo.tblAccountDim AS a
     ON b.branch_id = a.branch_id
	 INNER JOIN dbo.tblCustomerDim AS c
     ON a.branch_id = c.pri_branch_id
     WHERE YEAR(a.open_date) BETWEEN 2016 AND 2019
     GROUP BY  b.branch_id,
	           b.branch_desc,
			   a.open_date,
			   a.loan_amt,
			   c.cust_id;
			  
