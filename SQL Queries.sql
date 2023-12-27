/*Ερωτηση1*/
	SELECT customer_id, name, surname, customer_address, vap_number, phone_number
 	FROM Customer

	/*Ερωτηση2*/
	SELECT transaction_code, charge, card_number
    FROM Transaction1
	WHERE date1 BETWEEN '2017-05-12' AND '2017-05-18'

	/*Ερωτηση3*/
	SELECT C.customer_id, C.name, O.account_number1
	FROM Customer C, Ownership1 O
	WHERE C.customer_id = O.customer_id1

	/*Ερωτηση4*/
	SELECT DISTINCT C.name, C.phone_number
	FROM Customer C, Region R, Store S, Transaction1 T, Card1 U
	WHERE R.region_code = '291' AND T.date1 BETWEEN '2017-06-01' AND '2017-06-30' AND R.region_code = S.region_code AND T.store_code = S.store_code AND  C.customer_id = U.owner1 AND T.card_number = U.card_number
	
	/*Ερωτηση5*/
	/* Οι ημερομηνίες που λήγουν οι πιστωτικές κάρτες είναι από 20-01-2019 έως 29-01-2019. ’μα ελένξετε το άν τρέχει σωστά το ερώτημα μετά τις 29-12-2018 τότε 
	για να βγάλει κάποιο αποτέλεσμα πρέπει να γίνουν αλλαγές στα inserts και συγκεκριμένα στο date_of_expirsy της Card1*/
	SELECT card_number
	FROM Card1
	WHERE date_of_expirsy = DATEADD(month, 1, CAST(GETDATE() as date))

	/*Ερωτηση6*/
	UPDATE Card1
	SET limit = limit * 0.99

	/*Ερωτηση7*/
	SELECT C.name, C.surname, C.vap_number, SUM(A.balance) as Sum1
	FROM Customer C, Account A, Ownership1 O
	WHERE C.customer_id = O.customer_id1 AND O.account_number1 = A.account_number 
	GROUP BY C.customer_id, C.name, C.surname, C.vap_number
	HAVING SUM(A.balance)>10000

	/*Ερωτηση8*/
	SELECT SUM(charge) as charge , MONTH(date1) as month
	FROM Transaction1
	WHERE YEAR(date1) = '2017'
	GROUP BY  MONTH(date1)

	/*Ερωτηση9*/
	SELECT C.name, C.surname, MONTH(date1) as month1 , SUM(T.charge) AS total_charge
	FROM Customer C, Transaction1 T, Card1 U
	WHERE C.customer_id = U.owner1 AND T.card_number = U.card_number AND YEAR(date1) = '2017' 
	GROUP BY MONTH(date1), C.customer_id, C.name, C.surname

	/*Ερωτηση10*/
	SELECT C.customer_id
	FROM Customer C, Transaction1 T,Card1 U
	WHERE C.customer_id = U.owner1 AND T.card_number = U.card_number AND T.charge >= ALL (SELECT charge
																						  FROM Transaction1)
	/*Ερώτηση11*/ 
	GO
	CREATE VIEW View_a(customer_id, name, surname) as 
	SELECT C.customer_id, C.name, C.surname
	FROM Customer C, Transaction1 T, Card1 U
	WHERE C.customer_id = U.owner1 AND T.card_number = U.card_number AND T.store_code = '2019'
	GROUP BY C.customer_id, C.name, C.surname

	GO
	CREATE VIEW View_b(customer_id, name, surname) as 
	SELECT C.customer_id, C.name, C.surname
	FROM Customer C, Transaction1 T, Card1 U
	WHERE C.customer_id = U.owner1 AND T.card_number = U.card_number AND T.store_code= '3021'
	GROUP BY C.customer_id, C.name, C.surname

	GO
	CREATE VIEW View_c(customer_id, name, surname) as 
	SELECT C.customer_id, C.name, C.surname
	FROM Customer C, Transaction1 T, Card1 U
	WHERE C.customer_id = U.owner1 AND T.card_number = U.card_number AND T.store_code= '7182'
	GROUP BY C.customer_id, C.name, C.surname

	SELECT View_a.customer_id, View_a.name, View_a.surname
	FROM View_a , View_b, View_c
	WHERE View_a.customer_id = View_b.customer_id AND View_a.customer_id = View_c.customer_id

	 
	/*Ερώτηση12*/
	SELECT C.customer_id
	FROM Customer C, Transaction1 T, Card1 U
	WHERE C.customer_id=U.owner1 AND T.card_number=U.card_number AND MONTH(T.date1)=07 AND YEAR(T.date1)=2017 
	GROUP BY C.customer_id, YEAR(T.date1), MONTH(T.date1)
	HAVING AVG(T.charge)>50 AND COUNT(T.charge)>5 
	                                                  
	/*Ερώτηση13*/
	GO
	CREATE VIEW View_d(customer_id, sum_charge) as
	SELECT C.customer_id, SUM(T.charge)
	FROM Customer C, Transaction1 T, Card1 U
	WHERE C.customer_id=U.owner1 AND T.card_number=U.card_number AND YEAR(T.date1) = 2017
	GROUP BY C.customer_id

	GO
	CREATE VIEW View_e(customer_id, average_income) as
	SELECT C.customer_id, R.average_income 
	FROM Customer C, Region R
	WHERE R.region_code = C.geo_id 
	GROUP BY C.customer_id, R.average_income

	SELECT View_d.customer_id, cast(View_d.sum_charge as float) / cast(View_e.average_income as float) * 100 as per
	FROM View_d, View_e
	WHERE View_d.customer_id = View_e.customer_id
	                                                                                                                                                                                                                                                                                                                     
    
	/*Ερώτηση14*/ 
	GO
	CREATE VIEW View14021(charge) as
	SELECT AVG(T.charge)
	FROM Transaction1 T
    WHERE YEAR(T.date1) = '2017' AND MONTH(T.date1) = '07'
	   	
    SELECT C.name, C.surname
	FROM Customer C, Transaction1 T, Card1 U, View14021 V
	WHERE C.customer_id = U.owner1 AND T.card_number = U.card_number 
	GROUP BY C.customer_id, C.name, C.surname, YEAR(T.date1), MONTH(T.date1), V.charge
	HAVING YEAR(T.date1) = '2017' AND MONTH(T.date1) = '07' AND AVG(T.charge) >= 3*V.charge
		
 
	/*Ερώτηση15*/
	GO
	CREATE VIEW View3a(customer_id, average_charge) as
	SELECT C.customer_id, AVG(T.charge)
	FROM Customer C, Card1 U, Transaction1 T
	WHERE  C.customer_id = U.owner1 AND T.card_number = U.card_number AND YEAR(T.date1)=2017 AND MONTH(T.date1)=7
	GROUP BY C.customer_id

	GO
	CREATE VIEW View4a(customer_id, average_charge) as
	SELECT C.customer_id, AVG(T.charge)
	FROM Customer C, Card1 U, Transaction1 T
	WHERE  C.customer_id = U.owner1 AND T.card_number = U.card_number AND YEAR(T.date1)=2016 AND MONTH(T.date1)=7
	GROUP BY C.customer_id
	
	SELECT View3a.customer_id
	FROM View3a, View4a
	WHERE View3a.customer_id = View4a.customer_id AND View3a.average_charge > 1.5 * View4a.average_charge
	

/*Ερώτηση16*/
	GO
	CREATE VIEW a11(customer_id,date1) as
	SELECT C.customer_id, MONTH(T.date1) 
	FROM Customer C, Transaction1 T, Card1 U
	WHERE C.customer_id = U.owner1 AND T.card_number = U.card_number AND  YEAR(T.date1)=2017
	GROUP BY C.customer_id, MONTH(T.date1) 

	GO 
	CREATE VIEW b1(customer_id,average,date1) as
	SELECT DISTINCT a11.customer_id,AVG(T.charge), a11.date1
	FROM Transaction1 T, a11
	WHERE MONTH(T.date1) < a11.date1 AND YEAR(T.date1) = 2017
	GROUP BY a11.date1, a11.customer_id


	GO
	CREATE VIEW c1(customer_id, average,date1) as
	SELECT DISTINCT a11.customer_id,AVG(T.charge), a11.date1
	FROM Transaction1 T, a11
	WHERE MONTH(T.date1) > a11.date1 AND YEAR(T.date1)=2017
	GROUP BY a11.date1, a11.customer_id


	
	SELECT DISTINCT a11.customer_id
	FROM a11, b1, c1
	WHERE c1.average > b1.average and b1.date1=c1.date1 AND b1.customer_id = c1.customer_id

	/*Ερώτηση17*/
	
	CREATE VIEW View3c(customer_id, payment) as
	SELECT C.customer_id, SUM(P.payment_amount)
	FROM Customer C, Payment P
	WHERE C.customer_id = P.customer_id AND YEAR(P.date1) = 2017
	GROUP BY C.customer_id

	GO 
	CREATE VIEW View3d(customer_id, charge) as
	SELECT C.customer_id, SUM(T.charge)
	FROM Customer C, Transaction1 T, Card1 U
	WHERE C.customer_id = U.owner1 AND T.card_number = U.card_number AND YEAR(T.date1) = 2017
	GROUP BY C.customer_id

	SELECT View3c.customer_id, View3c.payment, View3d.charge
	FROM View3c, View3d
	WHERE View3c.customer_id = View3d.customer_id AND View3c.payment > View3d.charge
