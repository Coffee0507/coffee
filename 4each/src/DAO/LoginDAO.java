package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DTO.LoginDTO;
import util.DBConnector;

public class LoginDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private LoginDTO dto = new LoginDTO();

	public LoginDTO select(String id, String pass) {
		System.out.println(id+"$");
		String sql = "select *from logina where id=? and pass=?";

		try {
			System.out.println("###");
			PreparedStatement ps = con.prepareStatement(sql);

			System.out.println("$$$");
			ps.setString(1, id);
			ps.setString(2, pass);

			System.out.println(id+"#");

			ResultSet rs = ps.executeQuery();

			System.out.println(rs.getString(rs.getString(id))+"%");

			if (rs.next()) {
				dto.setId(rs.getString(id));
				dto.setPass(rs.getString(pass));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dto;
	}

}
