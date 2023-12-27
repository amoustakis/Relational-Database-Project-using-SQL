import java.io.*;
import java.text.*;
import java.util.*;
import java.sql.*;

public class Question4 {
	public static void main(String args[]) {
		int number,month;
		float b=0;
		String url = "jdbc:sqlserver://sqlserver.dmst.aueb.gr;" +
	                   "databaseName=DB16;user=G516;password=50990g3we40;";
		Connection dbcon ;
		Statement stmt;
  		/*declare OBDC Conectivity*/
		try {Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");}
		catch(java.lang.ClassNotFoundException e)
		{System.out.print("ClassNotFoundException: ");
		System.out.println(e.getMessage());}
			/* execute SQL statements */
		try {
			dbcon = DriverManager.getConnection(url);
			stmt = dbcon.createStatement();
		 	System.out.println("Please give me the number of your card");
			Scanner input = new Scanner(System.in);
			number = input.nextInt();
			System.out.println("Now please give  number of the month you want");
			month = input.nextInt();
		    System.out.println("This is your statement:");
		    ResultSet rs = stmt.executeQuery("SELECT C.name, C.surname, C.customer_address, C.vap_number, C.phone_number FROM Customer C, Card1 U WHERE U.owner1 = C.customer_id AND U.card_number = " +number) ;
		    while ( rs.next() ) {
			String name = rs.getString("name");
		    String surname = rs.getString("surname");
		    String customer_address = rs.getString("customer_address");
		    String vap_number = rs.getString("vap_number");
		    String phone_number = rs.getString("phone_number");
		    System.out.println("name:" +name);
		    System.out.println("surname:" +surname);
		    System.out.println("address:" +customer_address);
		    System.out.println("Vap number:" +vap_number);
		    System.out.println("Phone number:" +phone_number);
			}
			rs = stmt.executeQuery("SELECT balance FROM Card1 WHERE card_number =" +number) ;
			while (rs.next()) {
			float balance =rs.getFloat("balance");
			System.out.println("Balance before the charges is: " +balance);
			b = balance;
	 		}
			rs = stmt.executeQuery("SELECT S.service_number, T.transaction_code, T.bank_code, T.date1, T.hour1, T.charge, T.card_number ,T.store_code FROM Transaction1 T, Store S WHERE T.store_code = S.store_code AND card_number =" + number + "AND month(date1) =" + month);
		    while ( rs.next() ) {
			int transaction_code = rs.getInt("transaction_code");
			String date1 = rs.getString("date1");
			String hour1 = rs.getString("hour1");
			float charge = rs.getFloat("charge");
			int store_code = rs.getInt("store_code");
			int service_number = rs.getInt("service_number");
			b = b - charge;
			System.out.println("The code of the transaction is:" +transaction_code);
			System.out.println("Took place:" +date1);
			System.out.println("At the exact hour:" +hour1);
			System.out.println("The exact charge:" +charge);
			System.out.println("In the store with code:" +store_code);
			System.out.println("The type of service was:" +service_number);
			}
			System.out.println("The new balance after the charges is:" +b);
			String sql = "UPDATE Card1 SET balance = " + b ;
		    stmt.executeUpdate(sql);
			rs.close();
			stmt.close();
		    dbcon.close();
		}
		catch(SQLException e)
		{
		System.out.print("SQLException: ");
		System.out.println(e.getMessage());}
	}
}



