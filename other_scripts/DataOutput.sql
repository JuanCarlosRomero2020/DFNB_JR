
/*****************************************************************************************************************
NAME:    DataOutput
PURPOSE: Data Output process for project 1 

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     08/02/2019   JCRomero       1. Built this table for LDS BC IT240


RUNTIME: 
Approx. 1 min

NOTES:
Data output manipulations for the Project 1

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

-- 1) Customer Detail

SELECT a.acct_id, 
       a.open_close_code, 
       a.loan_amt, 
       b.branch_id, 
       b.branch_desc, 
       c.cust_id, 
       c.last_name, 
       c.cust_since_date
FROM dbo.tblAccountDim AS a
     INNER JOIN dbo.tblBranchDim AS b ON a.branch_id = b.branch_id
     INNER JOIN dbo.tblCustomerDim AS c ON b.branch_id = c.pri_branch_id;

-- 2) Loan Rank

WITH s1
     AS (SELECT DISTINCT 
                v.acct_id, 
                v.acct_since_year, 
                v.pri_cust_id, 
                v.pri_cust_name, 
                v.loan_amt, 
                RANK() OVER(
                ORDER BY v.loan_amt DESC) AS loan_amt_rank
         --v.tran_fee_amt_sum, 
         --RANK() OVER(
         --ORDER BY v.tran_fee_amt_sum DESC) AS tran_fee_amt_sum_rank
         FROM dbo.v_denorm_acct_cust_rel_prod_branch_region AS v)
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

-- 3) v_denorm_acct_cust_branch_region_prod Relation

SELECT tad.acct_id, 
       YEAR(tad.open_date) AS acct_since_year, 
       tad.pri_cust_id, 
       tcd.last_name + ', ' + tcd.first_name AS pri_cust_name, 
       YEAR(tcd.cust_since_date) AS cust_since_year, 
       tcd.cust_rel_id AS pri_cust_rel_id, 
       tad.prod_id, 
       --     tpd.prod_code, 
       tpd.prod_desc, 
       --       tpd.prod_code + ' - ' + tpd.prod_desc AS prod, 
       tad.branch_id, 
       tbd.branch_code, 
       tbd.branch_desc, 
       tbd.branch_code + ' - ' + tbd.branch_desc AS branch, 
       tbd.region_id, 
       trd.region_desc, 
       tad.loan_amt
--, SUM(tf.tran_fee_amt) as tran_fee_amt_sum
FROM dbo.tblAccountDim AS tad 
     --LEFT JOIN dbo.tblTransactionFact as tf
     -- ON tad.acct_id = tf.acct_id
     INNER JOIN dbo.tblCustomerDim AS tcd ON tad.pri_cust_id = tcd.cust_id
     INNER JOIN dbo.tblProductDim AS tpd ON tpd.prod_id = tad.prod_id
     INNER JOIN dbo.tblBranchDim AS tbd ON tbd.branch_id = tad.branch_id
     INNER JOIN dbo.tblRegionDim AS trd ON trd.region_id = tbd.region_id
WHERE YEAR(tad.open_date) BETWEEN 2016 AND 2019
GROUP BY tad.acct_id, 
         YEAR(tad.open_date), 
         tad.pri_cust_id, 
         tcd.last_name + ', ' + tcd.first_name, 
         YEAR(tcd.cust_since_date), 
         tcd.cust_rel_id, 
         tad.prod_id, 
         --      tpd.prod_code, 
         tpd.prod_desc, 
         --    tpd.prod_code + ' - ' + tpd.prod_desc, 
         tad.branch_id, 
         tbd.branch_code, 
         tbd.branch_desc, 
         tbd.branch_code + ' - ' + tbd.branch_desc, 
         tbd.region_id, 
         trd.region_desc, 
         tad.loan_amt;

--4) Loan sum

SELECT b.branch_id, 
       b.branch_desc,
	   b.latitud,
	   b.longitud,
       YEAR(a.open_date) AS year, 
       MONTH(a.open_date) AS month, 
       SUM(a.loan_amt) AS total, 
       COUNT(c.cust_id) AS totalcustomer
FROM dbo.tblBranchDim AS b
     INNER JOIN dbo.tblAccountDim AS a ON b.branch_id = a.branch_id
     INNER JOIN dbo.tblCustomerDim AS c ON a.branch_id = c.pri_branch_id
WHERE YEAR(a.open_date) BETWEEN 2016 AND 2019
GROUP BY b.branch_id, 
         b.branch_desc,
		 b.latitud,
	     b.longitud,
         a.open_date, 
         a.loan_amt, 
         c.cust_id;

--5) Total Loan vs Current Balanceby Gender

SELECT YEAR(open_date) AS YEAR, 
       SUM(loan_amt) AS Total_Loan, 
       SUM(cur_bal) AS Total_current_bal, 
       gender,
       2021-YEAR(birth_date) AS age
FROM [DFNB2].[dbo].[stg_p1]
WHERE [open_close_code] = 'O'
      AND YEAR(open_date) BETWEEN 2016 AND 2019
GROUP BY YEAR(open_date), 
         gender,
		 birth_date;