package com.koreait;

import java.sql.DriverManager;
import java.sql.*;
public class Dbconn {
	public static Connection conn;
	
	public static Connection getConnection() {
		conn = null;
		String url = "jdbc:mysql://localhost:3306/aiclass";
		String uid = "root";
		String upw = "1234";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url, uid, upw);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
