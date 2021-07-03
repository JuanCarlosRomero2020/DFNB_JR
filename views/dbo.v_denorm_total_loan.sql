USE [DFNB2]
GO

/****** Object:  View [dbo].[v_denorm_total_loan]    Script Date: 6/20/2021 9:25:17 PM ******/
DROP VIEW [dbo].[v_denorm_total_loan]
GO

/****** Object:  View [dbo].[v_denorm_total_loan]    Script Date: 6/20/2021 9:25:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_denorm_total_loan]
AS

/*****************************************************************************************************************
NAME:    dbo.v_denorm_total_loan.sql
PURPOSE: Q1 - Account
SUPPORT: Jaussi Consulting LLC
         www.jaussiconsulting.net
         jon@jaussiconsulting.net

MODIFICATION LOG:
Ver       Date         Author       Description
-         -
1.0       06/20/2021   JCRomero     1. Built this View for LDS BC IT 240


RUNTIME: 
Approx. 1 min

NOTES: 

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.

******************************************************************************************************************/

SELECT YEAR(p1.open_date) AS YEAR, 
       SUM(p1.loan_amt) AS Total_Loan, 
       SUM(p1.cur_bal) AS Total_current_bal, 
       p1.gender,
       2021-YEAR(p1.birth_date) AS age,
       p2.tran_type_desc,
       SUM(p2.tran_fee_amt) AS tran_fee_amt
FROM [DFNB2].[dbo].[stg_p1] AS p1
INNER JOIN [DFNB2].[dbo].[stg_p2] AS p2 ON p1.branch_id = p2.branch_id
WHERE [open_close_code] = 'O'
      AND YEAR(open_date) BETWEEN 2016 AND 2019
GROUP BY YEAR(open_date), 
         gender,
		 birth_date,
		 tran_type_desc,
		 tran_fee_amt;
GO


