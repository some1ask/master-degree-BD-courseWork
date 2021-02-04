create database courseworkTvDW

-- ************************************** [DimBrands]
CREATE TABLE [DimBrands]
(
 [brandsKey] int NOT NULL ,
 [brandName] nvarchar(50) NOT NULL ,
 CONSTRAINT [PK_brands] PRIMARY KEY CLUSTERED ([brandsKey] ASC),
 CONSTRAINT [ind_206] UNIQUE NONCLUSTERED ([brandName] ASC)
);
GO

-- ************************************** [DimGeography]
CREATE TABLE [DimGeography]
(
 [geographyKey]      int NOT NULL ,
 [city]              nvarchar(50) NOT NULL ,
 [countryRegionCode] nvarchar(3) NOT NULL ,
 [countryRegionName] nvarchar(50) NOT NULL ,
 [postalCode]        nvarchar(15) NOT NULL ,
 CONSTRAINT [PK_geography] PRIMARY KEY CLUSTERED ([geographyKey] ASC)
);
GO

-- ************************************** [DimCustomers]
CREATE TABLE [DimCustomers]
(
 [customerKey]   int NOT NULL ,
 [firstName]     nvarchar(50) NOT NULL ,
 [middleName]    nvarchar(50) NOT NULL ,
 [lastName]      nvarchar(50) NOT NULL ,
 [gender]        nvarchar(1) NOT NULL ,
 [maritalStatus] nvarchar(1) NOT NULL ,
 [email]         nvarchar(50) NOT NULL ,
 [yearlyIncome]  money NOT NULL ,
 [ageGroup]      nvarchar(30) NOT NULL ,
 [geographyKey]  int NOT NULL ,
 CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED ([customerKey] ASC),
 CONSTRAINT [ind_208] UNIQUE NONCLUSTERED ([email] ASC),
 CONSTRAINT [FK_164] FOREIGN KEY ([geographyKey])  REFERENCES [DimGeography]([geographyKey])
);
GO
CREATE NONCLUSTERED INDEX [fkIdx_165] ON [DimCustomers] 
 (
  [geographyKey] ASC
 )
GO

-- ************************************** [DimDate]
CREATE TABLE [DimDate]
(
 [dateKey]              int NOT NULL ,
 [fullDateAlternateKey] date NOT NULL ,
 [monthName]            nvarchar(30) NOT NULL ,
 [dayNumberOfMonth]     tinyint NOT NULL ,
 [calendarQuarter]      tinyint NOT NULL ,
 [calendarYear]         smallint NOT NULL ,
 CONSTRAINT [PK_dimdate] PRIMARY KEY CLUSTERED ([dateKey] ASC)
);
GO

-- ************************************** [DimTVs]
CREATE TABLE [DimTVs]
(
 [tvKey]             int NOT NULL ,
 [tvCode]            nvarchar(25) NOT NULL ,
 [tvName]            nvarchar(255) NOT NULL ,
 [cost]              money NOT NULL ,
 [diagonal]          float NOT NULL ,
 [resolution]        nvarchar(25) NOT NULL ,
 [matrixType]        nvarchar(25) NOT NULL ,
 [shape]             nvarchar(25) NOT NULL ,
 [color]             nvarchar(25) NOT NULL ,
 [wirelessInterface] nvarchar(3) NOT NULL ,
 [smartTV]           nvarchar(3) NOT NULL ,
 [3D]                nvarchar(3) NOT NULL ,
 [year]              smallint NOT NULL ,
 [brandsKey]         int NOT NULL ,
 CONSTRAINT [PK_tvs] PRIMARY KEY CLUSTERED ([tvKey] ASC),
 CONSTRAINT [ind_207] UNIQUE NONCLUSTERED ([tvCode] ASC),
 CONSTRAINT [FK_177] FOREIGN KEY ([brandsKey])  REFERENCES [DimBrands]([brandsKey])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_178] ON [DimTVs] 
 (
  [brandsKey] ASC
 )
GO

-- ************************************** [DimSales]
CREATE TABLE [FactSales]
(
 [salesKey]        int NOT NULL ,
 [orderNumber]     nvarchar(20) NOT NULL ,
 [orderLineNumber] tinyint NOT NULL ,
 [sellingPrice]    money NOT NULL ,
 [amount]          smallint NOT NULL ,
 [customerKey]     int NOT NULL ,
 [tvKey]           int NOT NULL ,
 [dateKey]         int NOT NULL ,
 CONSTRAINT [PK_sales] PRIMARY KEY CLUSTERED ([salesKey] ASC),
 CONSTRAINT [FK_199] FOREIGN KEY ([customerKey])  REFERENCES [DimCustomers]([customerKey]),
 CONSTRAINT [FK_202] FOREIGN KEY ([tvKey])  REFERENCES [DimTVs]([tvKey]),
 CONSTRAINT [FK_279] FOREIGN KEY ([dateKey])  REFERENCES [DimDate]([dateKey])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_200] ON [DimSales] 
 (
  [customerKey] ASC
 )
GO

CREATE NONCLUSTERED INDEX [fkIdx_203] ON [DimSales] 
 (
  [tvKey] ASC
 )
GO

CREATE NONCLUSTERED INDEX [fkIdx_280] ON [DimSales] 
 (
  [dateKey] ASC
 )
GO



create view vSales as
select salesKey, gender, maritalStatus, ageGroup, sellingPrice, resolution, smartTV, [3D], brandName, geographyKey,
CAST(CASE
WHEN yearlyIncome < 2000
THEN 'Low'
ELSE 'High'
END as nvarchar) as incomeGroup,
CAST(CASE
WHEN diagonal < 32
THEN 'less than 32'
WHEN diagonal >= 32 AND diagonal <= 49
THEN '32-49'
ELSE '50 and more'
END as nvarchar) as diagonalGroup
from DimCustomers as c INNER JOIN FactSales as s ON c.customerKey = s.customerKey INNER JOIN DimTVs as tv ON s.tvKey = tv.tvKey INNER JOIN DimBrands as b ON tv.brandsKey = b.brandsKey





select * from DimGeography
select * from DimCustomers
select * from DimBrands
select * from DimTVs
select * from DimDate
select * from FactSales

update DimGeography set city = '!' Where geographyKey in (1,2,3,4,5)
delete DimGeography where geographyKey = 6

update DimCustomers set firstName = '!' Where customerKey in (1,2,3,4,5)
delete DimCustomers where customerKey = 6

update DimBrands set brandName = '!' Where brandsKey in (1)
delete DimBrands where brandsKey = 6

update DimTVs set tvCode = '!' Where tvKey in (1)
delete DimTVs where tvKey = 6

update DimDate set monthName = '!' Where dateKey in (1,2,3,4,5)
delete DimDate where dateKey = 6

update FactSales set orderNumber = '!' Where salesKey in (1,2,3,4,5)
delete FactSales where salesKey = 6