﻿/*
Deployment script for ChallengeSem12019

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar LoadTestData "true"
:setvar DatabaseName "ChallengeSem12019"
:setvar DefaultFilePrefix "ChallengeSem12019"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
/*
The column [dbo].[Customer].[State] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Customer])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Product].[Description] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Product])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping unnamed constraint on [dbo].[Customer]...';


GO
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [FK__Customer__SegID__68487DD7];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Customer]...';


GO
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [FK__Customer__Region__693CA210];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK__Order__CustID__6A30C649];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK__Order__ProdID__6B24EA82];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK__Product__CatID__6D0D32F4];


GO
PRINT N'Starting rebuilding table [dbo].[Customer]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Customer] (
    [CustID]    NVARCHAR (8)  NOT NULL,
    [FullName]  NVARCHAR (50) NULL,
    [SegID]     INT           NULL,
    [Country]   NVARCHAR (50) NULL,
    [City]      NVARCHAR (50) NULL,
    [CustState] NVARCHAR (50) NULL,
    [Postcode]  INT           NULL,
    [Region]    NVARCHAR (12) NULL,
    PRIMARY KEY CLUSTERED ([CustID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Customer])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Customer] ([CustID], [FullName], [SegID], [Country], [City], [Postcode], [Region])
        SELECT   [CustID],
                 [FullName],
                 [SegID],
                 [Country],
                 [City],
                 [Postcode],
                 [Region]
        FROM     [dbo].[Customer]
        ORDER BY [CustID] ASC;
    END

DROP TABLE [dbo].[Customer];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Customer]', N'Customer';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Product]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Product] (
    [ProdID]    NVARCHAR (16)   NOT NULL,
    [CatID]     INT             NOT NULL,
    [ProdDesc]  NVARCHAR (100)  NULL,
    [UnitPrice] DECIMAL (10, 2) NULL,
    PRIMARY KEY CLUSTERED ([ProdID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Product])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Product] ([ProdID], [CatID], [UnitPrice])
        SELECT   [ProdID],
                 [CatID],
                 [UnitPrice]
        FROM     [dbo].[Product]
        ORDER BY [ProdID] ASC;
    END

DROP TABLE [dbo].[Product];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Product]', N'Product';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating unnamed constraint on [dbo].[Customer]...';


GO
ALTER TABLE [dbo].[Customer] WITH NOCHECK
    ADD FOREIGN KEY ([SegID]) REFERENCES [dbo].[Segment] ([SegtID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Customer]...';


GO
ALTER TABLE [dbo].[Customer] WITH NOCHECK
    ADD FOREIGN KEY ([Region]) REFERENCES [dbo].[Region] ([Region]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order] WITH NOCHECK
    ADD FOREIGN KEY ([CustID]) REFERENCES [dbo].[Customer] ([CustID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order] WITH NOCHECK
    ADD FOREIGN KEY ([ProdID]) REFERENCES [dbo].[Product] ([ProdID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product] WITH NOCHECK
    ADD FOREIGN KEY ([CatID]) REFERENCES [dbo].[Category] ([CatID]);


GO
