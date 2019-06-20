CREATE TABLE [dbo].[Customer] (
    [CustID] NVARCHAR(8),
	[FullName] NVARCHAR(50),
	[SegID] int,
	[Country] NVARCHAR(50),
	[City] NVARCHAR(50),
	[CustState] NVARCHAR(50),
	[Postcode] INT,
	[Region] NVARCHAR(12),
	PRIMARY KEY (CustID),
	FOREIGN KEY (SegID) REFERENCES Segment(SegtID),
	FOREIGN KEY (Region) REFERENCES Region(Region)
	)