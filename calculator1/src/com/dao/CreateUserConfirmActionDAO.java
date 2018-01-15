package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.Util.DBConnector;
import com.Util.UtilDate;
import com.dto.CreateUserConfirmActionDTO;

public class CreateUserConfirmActionDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private UtilDate utilDate = new UtilDate();

	public CreateUserConfirmActionDTO getCreateInfo(String name1, String name2, String birth_year, String birth_month,
			String birth_day, String sex) {

		String sql = "INSERT INTO acount_info_transaction(name1,name2,birth_year,birth_month,birth_day,sex,insert_date) values(?,?,?,?,?,?,?)";

		try{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,name1);
			ps.setString(2,name2);
			ps.setString(3, birth_year);
			ps.setString(4, birth_month);
			ps.setString(5, birth_day);
			ps.setString(6, sex);
			ps.setString(7, utilDate.getDate());

			int rs = ps.executeUpdate();


		}catch(Exception e){
			e.printStackTrace();
		}
		return null;


	}

}
