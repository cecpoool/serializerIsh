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
The type for column CatName in table [dbo].[Category] is currently  NVARCHAR (50) NOT NULL but is being changed to  VARCHAR (50) NOT NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Category])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Customer].[State] is being dropped, data loss could occur.

The type for column Country in table [dbo].[Customer] is currently  NVARCHAR (50) NULL but is being changed to  VARCHAR (50) NULL. Data loss could occur.

The type for column CustID in table [dbo].[Customer] is currently  NVARCHAR (8) NOT NULL but is being changed to  VARCHAR (8) NOT NULL. Data loss could occur.

The type for column FullName in table [dbo].[Customer] is currently  NVARCHAR (50) NULL but is being changed to  VARCHAR (50) NULL. Data loss could occur.

The type for column Region in table [dbo].[Customer] is currently  NVARCHAR (12) NULL but is being changed to  VARCHAR (12) NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Customer])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The type for column CustID in table [dbo].[Order] is currently  NVARCHAR (8) NOT NULL but is being changed to  VARCHAR (8) NOT NULL. Data loss could occur.

The type for column ProdID in table [dbo].[Order] is currently  NVARCHAR (16) NOT NULL but is being changed to  VARCHAR (16) NOT NULL. Data loss could occur.

The type for column ShipMode in table [dbo].[Order] is currently  NVARCHAR (50) NULL but is being changed to  VARCHAR (50) NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Order])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[Product].[Description] is being dropped, data loss could occur.

The type for column ProdID in table [dbo].[Product] is currently  NVARCHAR (16) NOT NULL but is being changed to  VARCHAR (16) NOT NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Product])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The type for column Region in table [dbo].[Region] is currently  NVARCHAR (12) NOT NULL but is being changed to  VARCHAR (12) NOT NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Region])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The type for column SegName in table [dbo].[Segment] is currently  NVARCHAR (50) NOT NULL but is being changed to  VARCHAR (50) NOT NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Segment])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The type for column ShippingMeth in table [dbo].[Shipping] is currently  NVARCHAR (50) NOT NULL but is being changed to  VARCHAR (50) NOT NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Shipping])
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
PRINT N'Dropping unnamed constraint on [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK__Order__ShipMode__6C190EBB];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK__Product__CatID__6D0D32F4];


GO
PRINT N'Altering [dbo].[Category]...';


GO
ALTER TABLE [dbo].[Category] ALTER COLUMN [CatName] VARCHAR (50) NOT NULL;


GO
PRINT N'Starting rebuilding table [dbo].[Customer]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Customer] (
    [CustID]    VARCHAR (8)   NOT NULL,
    [FullName]  VARCHAR (50)  NULL,
    [SegID]     INT           NULL,
    [Country]   VARCHAR (50)  NULL,
    [City]      NVARCHAR (50) NULL,
    [CustState] VARCHAR (50)  NULL,
    [Postcode]  INT           NULL,
    [Region]    VARCHAR (12)  NULL,
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
PRINT N'Starting rebuilding table [dbo].[Order]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Order] (
    [CustID]    VARCHAR (8)  NOT NULL,
    [ProdID]    VARCHAR (16) NOT NULL,
    [OrderDate] DATE         NOT NULL,
    [Quantity]  INT          NULL,
    [ShipDate]  DATE         NULL,
    [ShipMode]  VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([CustID] ASC, [ProdID] ASC, [OrderDate] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Order])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Order] ([CustID], [ProdID], [OrderDate], [Quantity], [ShipDate], [ShipMode])
        SELECT   [CustID],
                 [ProdID],
                 [OrderDate],
                 [Quantity],
                 [ShipDate],
                 [ShipMode]
        FROM     [dbo].[Order]
        ORDER BY [CustID] ASC, [ProdID] ASC, [OrderDate] ASC;
    END

DROP TABLE [dbo].[Order];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Order]', N'Order';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Product]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Product] (
    [ProdID]    VARCHAR (16)    NOT NULL,
    [CatID]     INT             NOT NULL,
    [ProdDesc]  VARCHAR (100)   NULL,
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
PRINT N'Starting rebuilding table [dbo].[Region]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Region] (
    [Region] VARCHAR (12) NOT NULL,
    PRIMARY KEY CLUSTERED ([Region] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Region])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Region] ([Region])
        SELECT   [Region]
        FROM     [dbo].[Region]
        ORDER BY [Region] ASC;
    END

DROP TABLE [dbo].[Region];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Region]', N'Region';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Altering [dbo].[Segment]...';


GO
ALTER TABLE [dbo].[Segment] ALTER COLUMN [SegName] VARCHAR (50) NOT NULL;


GO
PRINT N'Starting rebuilding table [dbo].[Shipping]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Shipping] (
    [ShippingMeth] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([ShippingMeth] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Shipping])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Shipping] ([ShippingMeth])
        SELECT   [ShippingMeth]
        FROM     [dbo].[Shipping]
        ORDER BY [ShippingMeth] ASC;
    END

DROP TABLE [dbo].[Shipping];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Shipping]', N'Shipping';

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
PRINT N'Creating unnamed constraint on [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order] WITH NOCHECK
    ADD FOREIGN KEY ([ShipMode]) REFERENCES [dbo].[Shipping] ([ShippingMeth]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product] WITH NOCHECK
    ADD FOREIGN KEY ([CatID]) REFERENCES [dbo].[Category] ([CatID]);


GO
if '$(LoadTestData)' = 'true'

BEGIN

DELETE FROM dbo.[Order];
DELETE FROM dbo.[Customer];
DELETE FROM dbo.[Product];
DELETE FROM dbo.[Shipping];
DELETE FROM dbo.[Region]
DELETE FROM dbo.[Segment];
DELETE FROM dbo.[Category];


INSERT INTO Category(CatID, CatName) VALUES
(1, 'Furniture'),
(2, 'Office Supplies'),
(3, 'Technology');

INSERT INTO Segment(SegtID, SegName) VALUES
(1, 'Consumer'),
(2, 'Corporate'),
(3, 'Home Office');

INSERT INTO Region(Region) VALUES
('South'),
('Central'),
('West'),
('East'),
('North');

INSERT INTO Shipping(ShippingMeth) VALUES
('Second Class'),
('Standard Class'),
('First Class'),
('Overnight Express');

INSERT INTO Product(ProdID, CatID, ProdDesc, UnitPrice) VALUES
('FURBO10001798', 1, 'Bush Somerset Collection Bookcase', 261.96),
('FURCH10000454', 2, 'Mitel 5320 IP Phone VoIP phone', 731.94),
('OFFLA10000240', 3, 'Self-Adhesive Address Labels for Typewriters by Universal', 14.62);
	
INSERT INTO Customer(CustID, FullName, SegID, Country, City, CustState, Postcode, Region) VALUES
('CG12520', 'Claire Gute', 1, 'United States', 'Henderson', 'Oklahoma', 42420, 'Central'),
('DV13045', 'Darrin Van Huff', 2, 'United States', 'Los Angeles', 'California', 90036, 'West'),
('SO20335', 'Sean ODonnell', 1, 'United States',  'Fort Lauderdale', 'Florida', 33311, 'South'),
('BH11710', 'Brosina Hoffman', 3, 'United States',  'Los Angeles', 'California', 90032, 'West');

INSERT INTO dbo.[Order](CustID, ProdID, OrderDate, Quantity, ShipDate,ShipMode) VALUES
('CG12520', 'FUR-BO-10001798', 2016-11-08, 2, 2016-11-11, 'Second Class'),
('CG12520', 'FUR-CH-10000454', 2016-11-08, 3, 2016-11-11, 'Second Class'),
('CG12520', 'OFF-LA-10000240', 2016-12-06, 2, 2016-06-16, 'Second Class'),
('DV13045', 'OFF-LA-10000240', 2015-11-21, 2, 2015-11-26, 'Second Class'),
('DV13045', 'OFF-LA-10000240', 2014-10-11, 1, 2014-10-15, 'Standard Class'),
('DV13045', 'FUR-CH-10000454', 2016-11-12, 9, 2016-11-16, 'Standard Class'),
('SO20335', 'OFF-LA-10000240', 2016-09-02, 5, 2016-09-08, 'Overnight Express'),
('SO20335', 'FUR-BO-10001798', 2017-08-25, 2, 2017-08-29, 'Second Class'),
('SO20335', 'FUR-CH-10000454', 2017-06-22, 2, 2017-06-26, 'Standard Class'),
('SO20335', 'FUR-BO-10001798', 2017-05-01, 3, 2017-05-02, 'First Class');	

END;
GO

GO
