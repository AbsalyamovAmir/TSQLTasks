CREATE DATABASE dbo;

IF OBJECT_ID ('dbo.SKU', 'U') IS NOT NULL
    DROP TABLE dbo.SKU;

CREATE TABLE dbo.SKU (
    ID INT identity PRIMARY KEY,
    Code AS 's' + CAST(ID AS VARCHAR(10)) UNIQUE,
    Name VARCHAR(100)
);

IF OBJECT_ID ('dbo.Family', 'U') IS NOT NULL
    DROP TABLE dbo.Family;

CREATE TABLE dbo.Family (
    ID INT identity PRIMARY KEY,
    Surname VARCHAR(100),
    BudgetValue DECIMAL(18, 2)
);

IF OBJECT_ID ('dbo.Basket', 'U') IS NOT NULL
    DROP TABLE dbo.Basket;

CREATE TABLE dbo.Basket (
    ID INT identity PRIMARY KEY,
    ID_SKU INT,
    ID_Family INT,
    Quantity INT CHECK (Quantity >= 0),
    Value DECIMAL(18, 2) CHECK (Value >= 0),
    PurchaseDate DATETIME DEFAULT GETDATE(),
    DiscountValue DECIMAL(18, 2)
    CONSTRAINT fk_dbo.SKU
        FOREIGN KEY(ID)
        REFERENCES dbo.SKU(ID)
    CONSTRAINT fk_dbo.Family
        FOREIGN KEY(ID)
        REFERENCES dbo.Family(ID)     
);