USE DFNB2
GO

/****** Object:  View [dbo].[v_customer_detail_dim]    Script Date: 6/15/2021 12:18:28 AM ******/

DROP VIEW [dbo].[v_customer_detail_dim]
GO

/****** Object:  View [dbo].[v_customer_detail_dim]    Script Date: 6/15/2021 12:18:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************************
NAME:    dbo.v_customer_detail_dim
PURPOSE: Create the dbo.v_customer_detail_dim view

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     06/20/2020   JCRomero       1. Built this View for LDS BC IT240
2.0       07/02/2021   JCRomero     1. Enhacement customer view for project 2

RUNTIME: 
Approx. 1 min

NOTES:
These are the varioius Extract, Transform, and Load steps needed for the Example Data

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

CREATE VIEW [dbo].[v_customer_detail_dim]
AS
SELECT TOP 10000
       a.acct_id, 
       a.open_close_code, 
	   YEAR(a.open_date) AS Year_open,
       a.loan_amt, 
       b.branch_id, 
       b.branch_desc,
	   b.latitud,
	   b.longitud,
       c.cust_id, 
       c.last_name, 
       YEAR(c.cust_since_date) AS customer_since,
       SUM(tf.tran_fee_amt) as tran_fee_amt_sum,
	   ttd.tran_type_desc,
	   SUM(ttd.tran_fee_prct) as porcentaje
	 FROM dbo.tblAccountDim AS a
     INNER JOIN dbo.tblBranchDim AS b ON a.branch_id = b.branch_id
     INNER JOIN dbo.tblCustomerDim AS c ON b.branch_id = c.pri_branch_id
	 INNER JOIN dbo.tblTransactionFact AS tf ON c.pri_branch_id = tf.branch_id
	 INNER JOIN dbo.tblTransactionTypeDim AS ttd ON tf.tran_type_id = ttd.tran_type_id
WHERE YEAR(a.open_date)  BETWEEN 2016 AND 2019 and open_close_code = 'O'
GROUP BY a.acct_id,
         a.open_close_code,
		 a.open_date,
		 a.loan_amt, 
         b.branch_id, 
         b.branch_desc,
	     b.latitud,
	     b.longitud,
		 c.cust_id,
		 c.last_name,
		 c.cust_since_date,
		 tf.tran_fee_amt,
		 ttd.tran_type_desc;

GO

