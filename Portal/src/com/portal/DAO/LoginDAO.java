package com.portal.DAO;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.portal.DTO.LoginDTO;
import com.portal.util.DBConnector;

public class LoginDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private LoginDTO dto = new LoginDTO();
	private String sql = "select * from user_info where user_id = ? and password = ?";

	public LoginDTO loginInfo(){

		try {
			PreparedStatement ps = con.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}





		return dto;
	}

}
