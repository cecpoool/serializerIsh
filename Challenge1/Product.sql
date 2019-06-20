CREATE TABLE [dbo].[Product] (
    [ProdID] NVARCHAR(16),
    [CatID] int NOT NULL,
	[ProdDesc] NVARCHAR(100),
	[UnitPrice] DECIMAL(10,2),
	PRIMARY KEY (ProdID),
	FOREIGN KEY (CatID) REFERENCES Category(CatID)
	);