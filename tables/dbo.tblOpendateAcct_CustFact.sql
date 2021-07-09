/*****************************************************************************************************************
NAME:    dbo.tblOpendateAcct_CustFact
PURPOSE: Create the Account Customer Dim stage table
SUPPORT: Jaussi Consulting LLC
         www.jaussiconsulting.net
         jon@jaussiconsulting.net
MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       7/9/2021  JCRomero      1. Built this script for LDS BC IT 240 P3
RUNTIME: 
1 sec
NOTES: 
LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
******************************************************************************************************************/


USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblOpendateAcct_CustFact]    Script Date: 7/9/2021 1:10:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblOpendateAcct_CustFact](
	[prod_id] [smallint] NOT NULL,
	[open_year] [int] NULL,
	[open_month] [int] NULL,
	[total_loan_amount] [decimal](38, 4) NULL,
	[STATUS] [varchar](1) NOT NULL,
	[prod_desc] [varchar](50) NOT NULL,
	[cust_id] [smallint] NOT NULL,
	[Total_customers] [int] NULL,
	[Name] [varchar](201) NOT NULL,
	[Total_Anual_Revenue] [numeric](38, 6) NULL,
	[Total_Monthly_revenue] [numeric](38, 6) NULL
) ON [PRIMARY]
GO


