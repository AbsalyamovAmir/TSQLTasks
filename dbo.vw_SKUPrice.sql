CREATE VIEW SKUWithPrice AS
SELECT
    SKU.ID,
    SKU.Code,
    SKU.Name,
    udf.Price AS CalculatedPrice
FROM dbo.SKU
CROSS APPLY (
    SELECT dbo.udf_GetSKUPrice(ID) AS Price
) AS udf;