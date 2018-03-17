package log.input.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {

	private Connection con = null;
	private String driverName = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost/LogDB";
	private String user = "root";
	private String pass = "mysql";

	public Connection getConnection() {

		try {
			Class.forName(driverName);
			con = (Connection) DriverManager.getConnection(url, user, pass);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return con;

	}

}
