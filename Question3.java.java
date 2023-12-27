import java.io.*;
import java.text.*;
import java.util.*;
import java.sql.*;

public class Question3 {
	public static void main(String args[]) {
		int number;
		String url = "jdbc:sqlserver://sqlserver.dmst.aueb.gr;" +
	                   "databaseName=DB16;user=G516;password=50990g3we40;";
		Connection dbcon ;
		Statement stmt;
		String sql;
  		/*declare OBDC Conectivity*/
		try {Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");}
		catch(java.lang.ClassNotFoundException e)
		{System.out.print("ClassNotFoundException: ");
		System.out.println(e.getMessage());}
			/* execute SQL statements */
		try {
			dbcon = DriverManager.getConnection(url);
			stmt = dbcon.createStatement();
		 	System.out.println("Please give me the number of the card you want to delete");
			Scanner input = new Scanner(System.in);
			number = input.nextInt();
			sql = "Delete From Card1 Where card_number=" + number ;
		    stmt.executeUpdate(sql);
		    System.out.println("The credit card was deleted");
			stmt.close();
		    dbcon.close();
		}
		catch(SQLException e)
		{
		System.out.print("SQLException: ");
		System.out.println(e.getMessage());}
	}
}





