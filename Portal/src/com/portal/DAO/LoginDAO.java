package com.portal.DAO;


import java.sql.Connection;
import java.sql.PreparedStatement;

import com.portal.DTO.LoginDTO;
import com.portal.util.DBConnector;

public class LoginDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private LoginDTO dto = new LoginDTO();
	private String sql = "select * from user_info where user_id = ? and password = ?";

	public LoginDTO loginInfo(){

		PreparedStatement ps = con.prepareStatement(sql);





		return dto;
	}

}
