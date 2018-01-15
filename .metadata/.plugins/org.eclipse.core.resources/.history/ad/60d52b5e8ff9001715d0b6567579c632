package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Util.DBConnector;
import com.Util.DateUtil;
import com.dto.AcountConfirmDTO;

public class AcountConfirmDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private AcountConfirmDTO dto = new AcountConfirmDTO();
	private DateUtil dateUtil = new DateUtil();

	public AcountConfirmDTO getAcountInfo(String age, String name1, String name2, String sex) throws SQLException {
		String sql = "insert into acount_info_transaction(name1,name2,age,sex,insert_date) values(?,?,?,?,?)";

		String time = dateUtil.getDate();
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, name1);
			ps.setString(2, name2);
			ps.setString(3, age);
			ps.setString(4, sex);
			ps.setString(5, time);

			ps.executeUpdate();

			Info(name1,age,sex,time);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			con.close();
		}

		return dto;
	}

	public String Info(String name1,String age,String sex,String time){
		String sql2 = "select*from acount_info_transaction where age=? and sex=? and insert_date=?";

		try {
			PreparedStatement ps2 = con.prepareStatement(sql2);

			ps2.setString(1, age);
			ps2.setString(2, sex);
			ps2.setString(3, time);

			ResultSet rs = ps2.executeQuery();
			if (rs.getString("name1").equals(name1)) {
				dto.setName1(rs.getString("name1"));
				dto.setName2(rs.getString("name2"));
				dto.setAge(rs.getString("age"));
				dto.setSex(rs.getString("sex"));
				dto.setTime(rs.getString("insert_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Info(name1,age,sex,time);
	}
}
