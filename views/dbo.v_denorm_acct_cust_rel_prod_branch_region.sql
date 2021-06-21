USE [DFNB2]
GO

/****** Object:  View [dbo].[v_denorm_acct_cust_rel_prod_branch_region]    Script Date: 6/15/2021 3:40:23 PM ******/
DROP VIEW [dbo].[v_denorm_acct_cust_rel_prod_branch_region]
GO

/****** Object:  View [dbo].[v_denorm_acct_cust_rel_prod_branch_region]    Script Date: 6/15/2021 3:40:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[v_denorm_acct_cust_rel_prod_branch_region]
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
SELECT tad.acct_id
     , YEAR(tad.open_date) as acct_since_year
     , tad.pri_cust_id
	 , tcd.last_name + ', ' + tcd.first_name as pri_cust_name
	 , YEAR(tcd.cust_since_date) as cust_since_year
	 , tcd.cust_rel_id as pri_cust_rel_id
	 , tad.prod_id
	 , tpd.prod_code
	 , tpd.prod_desc
	 , tpd.prod_code + ' - ' + tpd.prod_desc as prod
	 , tad.branch_id
	 , tbd.branch_code
	 , tbd.branch_desc
	 , tbd.branch_code + ' - ' + tbd.branch_desc as branch
	 , tbd.region_id
	 , trd.region_desc
	 , tad.loan_amt
	 --, SUM(tf.tran_fee_amt) as tran_fee_amt_sum
  FROM dbo.tblAccountDim as tad 
 --LEFT JOIN dbo.tblTransactionFact as tf
   -- ON tad.acct_id = tf.acct_id
 INNER JOIN dbo.tblCustomerDim as tcd
   ON tad.pri_cust_id = tcd.cust_id
 INNER JOIN dbo.tblProductDim as tpd
   ON tpd.prod_id = tad.prod_id
 INNER JOIN dbo.tblBranchDim as tbd
   ON tbd.branch_id = tad.branch_id
 INNER JOIN dbo.tblRegionDim as trd
   ON trd.region_id = tbd.region_id
WHERE YEAR(tad.open_date) between 2016 and 2019
GROUP BY tad.acct_id
     , YEAR(tad.open_date)
     , tad.pri_cust_id
	 , tcd.last_name + ', ' + tcd.first_name
	 , YEAR(tcd.cust_since_date)
	 , tcd.cust_rel_id
	 , tad.prod_id
	 , tpd.prod_code
	 , tpd.prod_desc
	 , tpd.prod_code + ' - ' + tpd.prod_desc
	 , tad.branch_id
	 , tbd.branch_code
	 , tbd.branch_desc
	 , tbd.branch_code + ' - ' + tbd.branch_desc
	 , tbd.region_id
	 , trd.region_desc
	 , tad.loan_amt;

GO


