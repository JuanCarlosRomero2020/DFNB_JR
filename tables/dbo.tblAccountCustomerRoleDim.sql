/*****************************************************************************************************************
NAME:    dbo.tblAccountCustomerRoleDim
PURPOSE: Create the Account Customer Role Dimension stage table
SUPPORT: Jaussi Consulting LLC
         www.jaussiconsulting.net
         jon@jaussiconsulting.net
MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/13/2021  JCRomero      1. Built this script for LDS BC IT 240
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

/****** Object:  Table [dbo].[tblAccountCustomerRoleDim]    Script Date: 3/24/2021 7:37:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAccountCustomerRoleDim]') AND type in (N'U'))
DROP TABLE [dbo].[tblAccountCustomerRoleDim]
GO

/****** Object:  Table [dbo].[tblAccountCustomerRoleDim]    Script Date: 3/24/2021 7:37:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAccountCustomerRoleDim](
	[acct_cust_role_id] [smallint] NOT NULL,
	[acct_cust_role_desc] [varchar](50) NULL,
 CONSTRAINT [PK_tblAccountCustomerRoleDim] PRIMARY KEY CLUSTERED 
(
	[acct_cust_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO