package com.internousdev.practice.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import com.internousdev.practice.DTO.LoginActionDTO;
import com.internousdev.practice.util.DBConnector;

public class LoginDAO {
	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	public Map<String, Object> session;
	private LoginActionDTO loginActionDTO;

	public LoginActionDTO getLoginUserInfo(String loginUserId, String loginPassword) {
		String sql = "select * from login_user_Transaction where login_id=? And login_pass=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, loginUserId);
			ps.setString(2, loginPassword);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				loginActionDTO.setLoginId(rs.getString("login_id"));
				loginActionDTO.setLoginPassword(rs.getString("login_pass"));
				loginActionDTO.setUserName(rs.getString("user_name"));

				if(!(rs.getString("login_id").equals(null))){
					loginActionDTO.setLoginFlg(true);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loginActionDTO;

	}

	public LoginActionDTO getLoginActionDTO(){
		return loginActionDTO;
	}

}