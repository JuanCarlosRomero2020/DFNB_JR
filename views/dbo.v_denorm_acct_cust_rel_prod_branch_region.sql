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
2.0       07/02/2021   JCRomero      1. Add transaction description column
3.0       07/02/2021   JCRomero      1. Add transaction percentaje column

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
SELECT tad.acct_id, 
       YEAR(tad.open_date) AS acct_since_year, 
       tad.pri_cust_id, 
       tcd.last_name + ', ' + tcd.first_name AS pri_cust_name, 
       YEAR(tcd.cust_since_date) AS cust_since_year, 
       tcd.cust_rel_id AS pri_cust_rel_id, 
       tad.prod_id, 
       tpd.prod_code, 
       tpd.prod_desc, 
       tpd.prod_code + ' - ' + tpd.prod_desc AS prod, 
       tad.branch_id, 
       tbd.branch_code, 
       tbd.branch_desc, 
       tbd.branch_code + ' - ' + tbd.branch_desc AS branch, 
       tbd.region_id, 
       trd.region_desc, 
       tad.loan_amt
      , SUM(tf.tran_fee_amt) as tran_fee_amt_sum,
	   ttd.tran_type_desc,
	   SUM(ttd.tran_fee_prct) as porcentaje,
	   RANK() OVER(
                ORDER BY tad.loan_amt DESC) AS loan_amt_rank,
       RANK() OVER(
                ORDER BY tf.tran_fee_amt DESC) AS tran_fee_amt_sum_rank
FROM dbo.tblAccountDim AS tad 
     LEFT JOIN dbo.tblTransactionFact as tf
     ON tad.acct_id = tf.acct_id
     INNER JOIN dbo.tblCustomerDim AS tcd ON tad.pri_cust_id = tcd.cust_id
     INNER JOIN dbo.tblProductDim AS tpd ON tpd.prod_id = tad.prod_id
     INNER JOIN dbo.tblBranchDim AS tbd ON tbd.branch_id = tad.branch_id
     INNER JOIN dbo.tblRegionDim AS trd ON trd.region_id = tbd.region_id
	 INNER JOIN dbo.tblTransactionTypeDim AS ttd ON ttd.tran_type_id = tf.tran_type_id
WHERE YEAR(tad.open_date) BETWEEN 2016 AND 2019
GROUP BY tad.acct_id, 
         YEAR(tad.open_date), 
         tad.pri_cust_id, 
         tcd.last_name + ', ' + tcd.first_name, 
         YEAR(tcd.cust_since_date), 
         tcd.cust_rel_id, 
         tad.prod_id, 
         tpd.prod_code, 
         tpd.prod_desc, 
         tpd.prod_code + ' - ' + tpd.prod_desc, 
         tad.branch_id, 
         tbd.branch_code, 
         tbd.branch_desc, 
         tbd.branch_code + ' - ' + tbd.branch_desc, 
         tbd.region_id, 
         trd.region_desc, 
         tad.loan_amt,
		 ttd.tran_type_desc,
		 ttd.tran_fee_prct,
		 tf.tran_fee_amt;

GO


