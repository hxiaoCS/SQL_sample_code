
CREATE TABLE customer
(customerId Int NOT NULL IDENTITY(1000,1),
lastName Varchar(30) NOT NULL,
firstName Varchar(30) NOT NULL,
street 	Varchar(30),
city Varchar(35),
province Char(2),
postalCode	Varchar(7), 
country	Varchar(50),
phoneNumber Char(10),
email Varchar(50) CONSTRAINT email_uni UNIQUE,

CONSTRAINT customer_pk PRIMARY KEY(customerId));


INSERT INTO customer
(lastName, firstName, street, city, province, postalCode, country, phoneNumber, email)
VALUES ('Anuj', 'Henmanth', '858 King St W', 'Waterloo', 'ON', 'N2L 1E8', 'Canada','5195228888', 'esaia@email.com');

SELECT * from customer;

GO

CREATE PROCEDURE sp_InsertNewCustomer
@NewLastName Varchar(30),
@NewFirstName Varchar(30),
@NewPhoneNumber Char(10),
@NewEmail Varchar(50)			
AS
DECLARE	@RowCount AS Int
DECLARE	@CustomerId	AS Int
	
	-- Check to see if Customer already exist in database
	
SELECT	@RowCount = COUNT(*)
FROM customer
WHERE lastName = @NewLastName
AND	firstName = @NewFirstName
AND phoneNumber = @NewPhoneNumber
AND email =	@NewEmail;
		
	-- IF @RowCount > 0, this customer already exists.

	
IF (@RowCount > 0)
BEGIN
PRINT '   The Customer is already in the database. '
RETURN
END
		
	-- IF @RowCount = 0, this customer has not been recorded.	
ELSE
BEGIN
	-- Insert new record
INSERT INTO customer
(lastName, firstName, phoneNumber, email)
VALUES(@NewLastName, @NewFirstName, @NewPhoneNumber, @NewEmail);
END

EXEC sp_InsertNewCustomer
@NewLastName = 'Mike',
@NewFirstName = 'Bruchock',
@NewPhoneNumber = '5192227777',
@NewEmail = 'mike66@gmail.com'


EXEC sp_InsertNewCustomer
@NewLastName = 'Hary',
@NewFirstName = 'Black',
@NewPhoneNumber = '5192223121',
@NewEmail = 'black@gmail.com';

SELECT * from customer