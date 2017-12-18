package com.internousdev.practice.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.internousdev.practice.DTO.LoginDTO;
import com.internousdev.practice.util.DBConnector;

public class LoginDAO {
	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private LoginDTO loginDTO = new LoginDTO();

	public LoginDTO getLoginUserInfo(String loginuserId, String loginuserPass) {
		String sql = "select*from login_user_transaction where login_id=? and login_pass=?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, loginuserId);
			ps.setString(2, loginuserPass);
			;

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				loginDTO.setLoginId(rs.getString("login_id"));
				loginDTO.setLoginPassword(rs.getString("login_pass"));
				loginDTO.setUserName(rs.getString("user_name"));

				if (!(rs.getString("login_id").equals(null))) {
					loginDTO.setLoginFlg(true);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// TODO 自動生成されたメソッド・スタブ
		return loginDTO;
	}
	public LoginDTO getLoginDTO(){
		return loginDTO;
	}

}
