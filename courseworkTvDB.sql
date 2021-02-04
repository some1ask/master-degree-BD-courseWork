create database courseworkTvDB

-- ************************************** [brands]
CREATE TABLE [brands]
(
 [brandsKey] int NOT NULL ,
 [brandName] nvarchar(50) NOT NULL ,
 CONSTRAINT [PK_brands] PRIMARY KEY CLUSTERED ([brandsKey] ASC),
 CONSTRAINT [ind_206] UNIQUE NONCLUSTERED ([brandName] ASC)
);
GO

-- ************************************** [geography]
CREATE TABLE [geography]
(
 [geographyKey]      int NOT NULL ,
 [city]              nvarchar(50) NOT NULL ,
 [countryRegionCode] nvarchar(3) NOT NULL ,
 [countryRegionName] nvarchar(50) NOT NULL ,
 [postalCode]        nvarchar(15) NOT NULL ,
 CONSTRAINT [PK_geography] PRIMARY KEY CLUSTERED ([geographyKey] ASC)
);
GO

-- ************************************** [customers]
CREATE TABLE [customers]
(
 [customerKey]   int NOT NULL ,
 [firstName]     nvarchar(50) NOT NULL ,
 [middleName]    nvarchar(50) NOT NULL ,
 [lastName]      nvarchar(50) NOT NULL ,
 [gender]        nvarchar(1) NOT NULL ,
 [maritalStatus] nvarchar(1) NOT NULL ,
 [email]         nvarchar(50) NOT NULL ,
 [yearlyIncome]  money NOT NULL ,
 [birthDate]     date NOT NULL ,
 [geographyKey]  int NOT NULL ,
 CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED ([customerKey] ASC),
 CONSTRAINT [ind_208] UNIQUE NONCLUSTERED ([email] ASC),
 CONSTRAINT [FK_164] FOREIGN KEY ([geographyKey])  REFERENCES [geography]([geographyKey])
);
GO
CREATE NONCLUSTERED INDEX [fkIdx_165] ON [customers] 
 (
  [geographyKey] ASC
 )
GO

-- ************************************** [TVs]
CREATE TABLE [TVs]
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
 CONSTRAINT [FK_177] FOREIGN KEY ([brandsKey])  REFERENCES [brands]([brandsKey])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_178] ON [TVs] 
 (
  [brandsKey] ASC
 )

GO

-- ************************************** [sales]
CREATE TABLE [sales]
(
 [salesKey]        int NOT NULL ,
 [orderNumber]     nvarchar(20) NOT NULL ,
 [orderLineNumber] tinyint NOT NULL ,
 [sellingPrice]    money NOT NULL ,
 [amount]          smallint NOT NULL ,
 [orderDate]       date NOT NULL ,
 [customerKey]     int NOT NULL ,
 [tvKey]           int NOT NULL ,
 CONSTRAINT [PK_sales] PRIMARY KEY CLUSTERED ([salesKey] ASC),
 CONSTRAINT [FK_199] FOREIGN KEY ([customerKey])  REFERENCES [customers]([customerKey]),
 CONSTRAINT [FK_202] FOREIGN KEY ([tvKey])  REFERENCES [TVs]([tvKey])
);
GO
CREATE NONCLUSTERED INDEX [fkIdx_200] ON [sales] 
 (
  [customerKey] ASC
 )
GO
CREATE NONCLUSTERED INDEX [fkIdx_203] ON [sales] 
 (
  [tvKey] ASC
 )
GO