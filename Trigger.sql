/*trigger*/

CREATE TRIGGER question1 ON Transaction1
	FOR INSERT
	AS 
	BEGIN
	DECLARE @balance real;
	SET @balance = (SELECT balance FROM Card1)
	DECLARE @limit real;
	SET @limit = (SELECT limit FROM Card1)
	DECLARE @charge real;
	SET @charge = (SELECT charge FROM inserted)
	IF (@balance + @charge) > @limit 
	BEGIN 
		ROLLBACK Transaction
	END
	END 
