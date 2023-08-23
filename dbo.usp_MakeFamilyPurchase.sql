CREATE PROCEDURE UpdateFamilyBudget(@FamilySurName VARCHAR(255))
BEGIN
    DECLARE @FamilyID INT;
    DECLARE @TotalPurchaseValue DECIMAL(18, 2);

    SELECT @FamilyID = ID
    FROM dbo.Family
    WHERE Surname = @FamilySurName;

    IF @FamilyID IS NULL
    BEGIN
        RAISEERROR('Семьи с фамилией %s не существует.', 16, 1, @FamilySurName);
        RETURN;
    END;

    SELECT @TotalPurchaseValue = SUM(Value)
    FROM dbo.Basket
    WHERE ID_Family = @FamilyID;

    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - @TotalPurchaseValue
    WHERE ID = @FamilyID;
END;
