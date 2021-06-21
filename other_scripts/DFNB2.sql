
USE [DFNB2];
GO

/****** Object:  1.-Table [dbo].[tblAccountCustomerDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblAccountCustomerDim]
([acct_id]           [INT] NOT NULL, 
 [cust_id]           [SMALLINT] NOT NULL, 
 [acct_cust_role_id] [SMALLINT] NOT NULL, 
 CONSTRAINT [PK_tblAccountCustomerDim] PRIMARY KEY CLUSTERED([acct_id] ASC, [cust_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object: 2.- Table [dbo].[tblAccountCustomerRoleDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblAccountCustomerRoleDim]
([acct_cust_role_id]   [SMALLINT] NOT NULL, 
 [acct_cust_role_desc] [VARCHAR](50) NULL, 
 CONSTRAINT [PK_tblAccountCustomerRoleDim] PRIMARY KEY CLUSTERED([acct_cust_role_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object:  3.-Table [dbo].[tblAccountDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblAccountDim]
([acct_id]         [INT] NOT NULL, 
 [prod_id]         [SMALLINT] NOT NULL, 
 [open_date]       [DATE] NOT NULL, 
 [close_date]      [DATE] NOT NULL, 
 [open_close_code] [VARCHAR](1) NOT NULL, 
 [branch_id]       [SMALLINT] NOT NULL, 
 [pri_cust_id]     [SMALLINT] NOT NULL, 
 [loan_amt]        [DECIMAL](20, 4) NOT NULL, 
 CONSTRAINT [PK_tblAccountDim] PRIMARY KEY CLUSTERED([acct_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object:  4.-Table [dbo].[tblAccountFact]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblAccountFact]
([as_of_date] [DATE] NOT NULL, 
 [acct_id]    [INT] NOT NULL, 
 [cur_bal]    [DECIMAL](20, 4) NOT NULL, 
 CONSTRAINT [PK_tblAccountFact] PRIMARY KEY CLUSTERED([as_of_date] ASC, [acct_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object:  5.-Table [dbo].[tblAddressDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblAddressDim]
([add_id]   [INT] NOT NULL, 
 [add_lat]  [DECIMAL](16, 12) NOT NULL, 
 [add_lon]  [DECIMAL](16, 12) NOT NULL, 
 [add_type] [VARCHAR](1) NOT NULL, 
 CONSTRAINT [PK_tblAddressDim] PRIMARY KEY CLUSTERED([add_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object:  6.-Table [dbo].[tblAreaDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblAreaDim]
([area_id]   [INT] NOT NULL, 
 [area_desc] [VARCHAR](50) NULL, 
 CONSTRAINT [PK_tblAreaDim] PRIMARY KEY CLUSTERED([area_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object:  7.-Table [dbo].[tblBranchDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblBranchDim]
([branch_id]     [SMALLINT] NOT NULL, 
 [branch_code]   [VARCHAR](5) NOT NULL, 
 [branch_desc]   [VARCHAR](100) NOT NULL, 
 [branch_add_id] [INT] NOT NULL, 
 [region_id]     [INT] NOT NULL, 
 [area_id]       [INT] NOT NULL, 
 CONSTRAINT [PK_tblBranchDim] PRIMARY KEY CLUSTERED([area_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object:  8.-Table [dbo].[tblCustomerDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
CREATE TABLE [dbo].[tblCustomerDim]
([cust_id]              [SMALLINT] NOT NULL, 
 [last_name]            [VARCHAR](100) NOT NULL, 
 [first_name]           [VARCHAR](100) NOT NULL, 
 [gender]               [VARCHAR](1) NOT NULL, 
 [birth_date]           [DATE] NOT NULL, 
 [cust_since_date]      [DATE] NOT NULL, 
 [pri_branch_id]        [SMALLINT] NOT NULL, 
 [cust_pri_branch_dist] [DECIMAL](7, 2) NOT NULL, 
 [cust_add_id]          [INT] NOT NULL, 
 [cust_lat]             [DECIMAL](16, 12) NOT NULL, 
 [cust_lon]             [DECIMAL](16, 12) NOT NULL, 
 [cust_rel_id]          [SMALLINT] NOT NULL, 
 CONSTRAINT [PK_tblCustomerDim] PRIMARY KEY CLUSTERED([cust_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object:  9.-Table [dbo].[tblProductDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblProductDim]
([prod_id]   [SMALLINT] NOT NULL, 
 [prod_desc] [VARCHAR](50) NULL, 
 CONSTRAINT [PK_tblProductDim] PRIMARY KEY CLUSTERED([prod_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object: 10.-Table [dbo].[tblRegionDim]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[tblRegionDim]
([region_id]   [INT] NOT NULL, 
 [region_desc] [VARCHAR](50) NULL, 
 CONSTRAINT [PK_tblRegionDim] PRIMARY KEY CLUSTERED([region_id] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

/****** Object:  View 1 [dbo].[v_denorm_acct_cust_rel_prod_branch_region]    Script Date: 6/14/2021 1:47:18 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

/*****************************************************************************************************************
NAME:    dbo.v_denorm_acct_cust_rel_prod_branch_region
PURPOSE: Create the dbo.v_denorm_acct_cust_rel_prod_branch_region

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     6/14/2021   JCRomero       1. Built this View for LDS BC IT240


RUNTIME: 
Approx. 1 min

NOTES:
These are the varioius Extract, Transform, and Load steps needed for the Example Data

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

CREATE VIEW dbo.v_denorm_acct_cust_rel_prod_branch_region
AS
     SELECT tad.acct_id, 
            YEAR(tad.open_date) AS acct_since_year, 
            tad.pri_cust_id, 
            tcd.last_name + ', ' + tcd.first_name AS pri_cust_name, 
            YEAR(tcd.cust_since_date) AS cust_since_year, 
            tcd.cust_rel_id AS pri_cust_rel_id, 
            tad.prod_id
            ,
            --	 , tpd.prod_code 
            tpd.prod_desc
            ,
            --	 , tpd.prod_code + ' - ' + tpd.prod_desc as prod 
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
              tad.prod_id
              ,
              --	 , tpd.prod_code 
              tpd.prod_desc
              ,
              -- , tpd.prod_code + ' - ' + tpd.prod_desc 
              tad.branch_id, 
              tbd.branch_code, 
              tbd.branch_desc
              ,
              -- , tbd.branch_code + ' - ' + tbd.branch_desc 
              tbd.region_id, 
              trd.region_desc, 
              tad.loan_amt;
GO

/****** Object:  View 2 [dbo].[dbo.v_q1_acct]    Script Date: 6/14/2021 1:47:18 AM ******/
/*****************************************************************************************************************
NAME:    dbo.v_q1_acct
PURPOSE: Create the dbo.v_q1_acct view

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     6/14/2021   JCRomero       1. Built this View for LDS BC IT240


RUNTIME: 
Approx. 1 min

NOTES:
These are the varioius Extract, Transform, and Load steps needed for the Example Data

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

CREATE VIEW [dbo].[v_q1_acct]
AS
     WITH s1
          AS (SELECT v.acct_id, 
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
          --   s1.tran_fee_amt_sum, 
          --   s1.tran_fee_amt_sum_rank, 
          --   (s1.loan_amt_rank + s1.tran_fee_amt_sum_rank) AS combined_value_rank
          FROM s1;
GO

/****** Object:  View 3 [dbo].[v_customer_detail_dim]    Script Date: 6/20/2021 1:47:18 AM ******/
/*****************************************************************************************************************
NAME:    dbo.v_customer_detail_dim
PURPOSE: Create the dbo.v_customer_detail_dim view

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     06/20/2021   JCRomero       1. Built this View for LDS BC IT240


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
GO

/****** Object:  View 4 [dbo].[v_customer_detail_dim]    Script Date: 6/20/2021 1:47:18 AM ******/
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

CREATE VIEW [dbo].[v_Loan_sum]
AS
     SELECT b.branch_id, 
            b.branch_desc, 
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
              a.open_date, 
              a.loan_amt, 
              c.cust_id;
GO

/****** Object:  View 5 [dbo].[v_denorm_total_loan]    Script Date: 6/20/2021 1:47:18 AM ******/
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

CREATE VIEW [dbo].[v_denorm_total_loan]
AS
     SELECT YEAR(open_date) AS YEAR, 
            SUM(loan_amt) AS Total_Loan, 
            SUM(cur_bal) AS Total_current_bal, 
            gender
     FROM [DFNB2].[dbo].[stg_p1]
     WHERE [open_close_code] = 'O'
           AND YEAR(open_date) BETWEEN 2016 AND 2019
     GROUP BY YEAR(open_date), 
              gender;
GO
ALTER TABLE [dbo].[tblAccountCustomerDim]
WITH CHECK
ADD CONSTRAINT [FK_tblAccountCustomerDim_acct_cust_role_id_tblAccountCustomerRoleDim_acct_cust_role_id] FOREIGN KEY([acct_cust_role_id]) REFERENCES [dbo].[tblAccountCustomerRoleDim]([acct_cust_role_id]);
GO
ALTER TABLE [dbo].[tblAccountCustomerDim] CHECK CONSTRAINT [FK_tblAccountCustomerDim_acct_cust_role_id_tblAccountCustomerRoleDim_acct_cust_role_id];
GO
ALTER TABLE [dbo].[tblAccountCustomerDim]
WITH CHECK
ADD CONSTRAINT [FK_tblAccountCustomerDim_acct_id_tblAccountDim_acct_id] FOREIGN KEY([acct_id]) REFERENCES [dbo].[tblAccountDim]([acct_id]);
GO
ALTER TABLE [dbo].[tblAccountCustomerDim] CHECK CONSTRAINT [FK_tblAccountCustomerDim_acct_id_tblAccountDim_acct_id];
GO
ALTER TABLE [dbo].[tblAccountCustomerDim]
WITH CHECK
ADD CONSTRAINT [FK_tblAccountCustomerDim_cust_id_tblCustomerDim_cust_id] FOREIGN KEY([cust_id]) REFERENCES [dbo].[tblCustomerDim]([cust_id]);
GO
ALTER TABLE [dbo].[tblAccountCustomerDim] CHECK CONSTRAINT [FK_tblAccountCustomerDim_cust_id_tblCustomerDim_cust_id];
GO
USE [DFNB2];
GO
ALTER DATABASE [DFNB2] SET READ_WRITE; 
GO