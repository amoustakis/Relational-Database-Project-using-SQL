DROP TABLE Payment;
DROP TABLE Transaction1;
DROP TABLE Store;
DROP TABLE Sight_account;
DROP TABLE Bank_account;
DROP TABLE Ownership1;
DROP TABLE Account;
DROP TABLE Card1;
DROP TABLE Customer;
DROP TABLE Region;

CREATE TABLE Region
(region_code CHAR(5),
name CHAR(15),
population1 INTEGER,
average_income REAL,
PRIMARY KEY (region_code))

CREATE TABLE Customer
(customer_id INTEGER,
name CHAR(11),
surname CHAR(13),
customer_address CHAR(35),
vap_number CHAR(10),
phone_number CHAR(12),
geo_id CHAR(5),
PRIMARY KEY (customer_id),
FOREIGN KEY (geo_id) REFERENCES Region(region_code)
ON DELETE CASCADE)

CREATE TABLE Card1
(card_number INTEGER,
date_of_issue DATE,
date_of_expirsy DATE,
balance REAL,
rate REAL,
limit REAL,
owner1 INTEGER,
PRIMARY KEY (card_number),
FOREIGN KEY (owner1) REFERENCES Customer(customer_id))


CREATE TABLE Account 
(account_number INTEGER,
balance REAL,
card_number INTEGER,
PRIMARY KEY (account_number),
FOREIGN KEY (card_number) REFERENCES Card1(card_number) 
ON DELETE CASCADE)

CREATE TABLE Ownership1
(customer_id1 INTEGER,
account_number1 INTEGER,
FOREIGN KEY (customer_id1) REFERENCES Customer(customer_id) ON DELETE CASCADE,
FOREIGN KEY (account_number1) REFERENCES Account(account_number) ON DELETE CASCADE)

CREATE TABLE Bank_account
(account_number INTEGER,
interest_rate REAL,
PRIMARY KEY (account_number),
FOREIGN KEY (account_number) REFERENCES Account(account_number)
ON DELETE CASCADE)

CREATE TABLE Sight_account
(account_number INTEGER,
overdraft_amount REAL,
PRIMARY KEY (account_number),
FOREIGN KEY (account_number) REFERENCES Account(account_number)
ON DELETE CASCADE)

CREATE TABLE Store
(store_code INTEGER,
name CHAR(11),
service_number INTEGER,
region_code CHAR(5),
PRIMARY KEY (store_code),
FOREIGN KEY (region_code) REFERENCES Region(region_code)
ON DELETE CASCADE)

CREATE TABLE Transaction1 
(transaction_code INTEGER,
bank_code INTEGER,
date1 DATE,
hour1 TIME,
charge REAL,
card_number INTEGER,
store_code INTEGER,
PRIMARY KEY (transaction_code),
FOREIGN KEY (card_number) REFERENCES Card1(card_number) ON DELETE CASCADE,
FOREIGN KEY (store_code) REFERENCES Store(store_code) ON DELETE CASCADE)

CREATE TABLE Payment
(customer_number INTEGER,
date1 DATE,
payment_amount REAL,
customer_id INTEGER,
PRIMARY KEY (customer_number, customer_id),
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
ON DELETE CASCADE)

