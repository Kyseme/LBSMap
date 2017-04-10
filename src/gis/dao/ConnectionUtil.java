package gis.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionUtil {
	public static Connection getConnection(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
		Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/sun_lbs","root","654321");
			return connection;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	/*
	 * 
	 * 	public static void main(String[] args) {
		System.out.println(getConnection());
	}
	 */


}
