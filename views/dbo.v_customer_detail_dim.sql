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
SELECT a.acct_id
     , a.open_close_code
     , a.loan_amt
     , b.branch_id
     , b.branch_desc
     , c.cust_id
     , c.last_name
     , c.cust_since_date
  FROM dbo.tblAccountDim AS a
 INNER JOIN dbo.tblBranchDim AS b 
    ON a.branch_id = b.branch_id 
 INNER JOIN dbo.tblCustomerDim AS c
   ON b.branch_id = c.pri_branch_id;

GO

