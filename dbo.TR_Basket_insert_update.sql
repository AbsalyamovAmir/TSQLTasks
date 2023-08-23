CREATE TRIGGER ApplyDiscountOnMultipleSKUs
ON dbo.Basket
AFTER INSERT
AS
BEGIN
    
    SET DiscountValue = Value * 0.05
    FROM dbo.Basket AS b
    JOIN (
        SELECT ID_SKU, COUNT(*) AS SKUCount
        FROM inserted
        GROUP BY ID_SKU
    ) AS grouped ON b.ID_SKU = grouped.ID_SKU
    WHERE grouped.SKUCount >= 2;

    UPDATE b
    SET DiscountValue = 0
    FROM dbo.Basket AS b
    WHERE b.ID_SKU NOT IN (
        SELECT ID_SKU
        FROM inserted
        GROUP BY ID_SKU
        HAVING COUNT(*) >= 2
    );
END;