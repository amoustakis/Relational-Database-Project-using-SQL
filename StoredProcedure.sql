/*stored procedure*/
DROP PROCEDURE exercise2;
CREATE PROCEDURE exercise2(
@card1 int,
@month1 int,
@sum real output)
AS
DECLARE @charge real, @day int;
SET @sum=0;
DECLARE cursor1 CURSOR FOR
SELECT Transaction1.charge, DAY(Transaction1.date1)
FROM Transaction1
WHERE card_number = @card1 AND MONTH(date1) = @month1

OPEN cursor1;
FETCH NEXT FROM cursor1
INTO @charge, @day;
WHILE @@FETCH_STATUS = 0
BEGIN 
	if @day <= 10
		SET @sum = @sum +0.01 * @charge;
	if (@day <= 20 AND @day > 10)
		SET @sum = @sum + 0.02 * @charge;
	if @day > 20
		SET @sum = @sum +0.03 * @charge;
	FETCH NEXT FROM cursor1
	INTO @charge, @day;
END
CLOSE cursor1;
DEALLOCATE cursor1;
GO

BEGIN
DECLARE @sum1 REAL

EXECUTE exercise2 1, 7, @sum1 Output
SELECT @sum1
END