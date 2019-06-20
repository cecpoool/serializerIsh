CREATE TABLE [dbo].[Order] (
    [CustID] NVARCHAR(8),
	[ProdID] NVARCHAR(16),
	[OrderDate] Date,
	[Quantity] int,
	[ShipDate] Date,
	[ShipMode] NVARCHAR(50),
	PRIMARY KEY (CustID,ProdID,OrderDate),
	FOREIGN KEY (CustID) REFERENCES Customer(CustID),
	FOREIGN KEY (ProdID) REFERENCES Product(ProdID),
	FOREIGN KEY (ShipMode) REFERENCES Shipping(ShippingMeth)
	)