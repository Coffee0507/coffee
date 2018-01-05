package com.internousdev.sample.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.internousdev.sample.DTO.LoginDTO;
import com.internousdev.sample.util.DBConnector;

public class LoginDAO {
	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private LoginDTO loginDTO = new LoginDTO();

	public LoginDTO getloginUserInfo(String loginUserId, String loginPass) {
		String sql = "select*from login_user_transaction where login_id=? and login_pass=?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, loginUserId);
			ps.setString(2, loginPass);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				loginDTO.setLoginUserId(rs.getString("login_id"));
				loginDTO.setLoginUserName(rs.getString("user_name"));
				loginDTO.setLoginPassword(rs.getString("login_pass"));

				loginDTO.setLoginFlg(true);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return loginDTO;
	}
	public LoginDTO getLoginDTO(){
		return loginDTO;
	}
}