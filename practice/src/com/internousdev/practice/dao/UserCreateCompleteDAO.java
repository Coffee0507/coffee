package com.internousdev.practice.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.internousdev.practice.util.DBConnector;
import com.internousdev.practice.util.DateUtil;

public class UserCreateCompleteDAO {
	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private DateUtil dateUtil = new DateUtil();
	private String sql = "INSERT INTO login_user_transaction(login_id,login_pass,user_name,insert_date) value(?,?,?,?)";

	public void createUserInfo(String loginUserId,String loginPassword,String userName)throws SQLException{

	try{
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, "loginUserId");
	ps.setString(2,"login_Pass");
	ps.setString(3,"userName");

	ps.execute();



	}catch(Exception e){
		e.printStackTrace();
	}finally{
		con.close();
	}
	}
}