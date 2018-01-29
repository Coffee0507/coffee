package com.example.demo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {

	private String driverName = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost/Controller";
	private String username = "root";
	private String password = "msyql";
	private Connection con = null;

	public Connection getConnection() {

		try {
			Class.forName(driverName);
			con = (Connection) DriverManager.getConnection(url, username, password);
		} catch (ClassNotFoundException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
}
