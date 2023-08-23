CREATE FUNCTION udf_GetSKUPrice(@ID_SKU INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalValue DECIMAL(18, 2);
    DECLARE @TotalQuantity INT;

    SELECT @TotalValue = SUM(Value),
           @TotalQuantity = SUM(Quantity)
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU;

    IF @TotalQuantity = 0
        RETURN 0.00;
    ELSE
        RETURN @TotalValue / @TotalQuantity;
END;