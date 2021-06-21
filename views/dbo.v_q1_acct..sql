USE [DFNB2]
GO

/****** Object:  View [dbo].[v_q1_acct]    Script Date: 6/15/2021 3:59:02 PM ******/
DROP VIEW [dbo].[v_q1_acct]
GO

/****** Object:  View [dbo].[v_q1_acct]    Script Date: 6/15/2021 3:59:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[v_q1_acct]
AS
/*****************************************************************************************************************
NAME:    dbo.v_q1_acct.sql
PURPOSE: Q1 - Account
SUPPORT: Jaussi Consulting LLC
         www.jaussiconsulting.net
         jon@jaussiconsulting.net

MODIFICATION LOG:
Ver       Date         Author       Description
-         -
1.0       04/01/2021   JCRomero     1. Built this script for LDS BC IT 240


RUNTIME: 
Approx. 1 min

NOTES: 

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.

******************************************************************************************************************/
WITH s1
     AS (SELECT distinct v.acct_id, 
                v.acct_since_year, 
                v.pri_cust_id, 
                v.pri_cust_name, 
                v.loan_amt, 
                RANK() OVER(
                ORDER BY v.loan_amt DESC) AS loan_amt_rank
             --v.tran_fee_amt_sum, 
             --RANK() OVER(
             --ORDER BY v.tran_fee_amt_sum DESC) AS tran_fee_amt_sum_rank
         FROM dbo.v_denorm_acct_cust_branch_region_prod as v)
     SELECT s1.acct_id, 
            s1.acct_since_year, 
            s1.pri_cust_id, 
            s1.pri_cust_name, 
            s1.loan_amt, 
            s1.loan_amt_rank 
          --s1.tran_fee_amt_sum
          --s1.tran_fee_amt_sum_rank, 
          --(s1.loan_amt_rank + s1.tran_fee_amt_sum_rank) AS combined_value_rank
     FROM s1
	 WHERE s1.acct_since_year BETWEEN 2016 AND 2019;
GO


