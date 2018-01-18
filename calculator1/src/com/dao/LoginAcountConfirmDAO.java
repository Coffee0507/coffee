package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Util.DBConnector;
import com.dto.LoginAcountConfirmDTO;

public class LoginAcountConfirmDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private LoginAcountConfirmDTO dto = new LoginAcountConfirmDTO();

	public LoginAcountConfirmDTO info(String name1, String name2) throws SQLException {

		String sql = "select*from acount_info_transaction where name1 = ? and name2 = ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, name1);
			ps.setString(2, name2);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				dto.setId(rs.getInt("id"));
				dto.setName1(name1);
				dto.setName2(name2);
				dto.setBirthYear(rs.getString("birth_year"));
				dto.setBirthMonth(rs.getString("birth_month"));
				dto.setBirthDay(rs.getString("birth_day"));
				dto.setSex(rs.getString("sex"));
				dto.setFlg(true);
			}

			StringBuilder name = new StringBuilder();

			name.append(dto.getBirthDay());
			name.append(",");
			name.append(dto.getBirthYear());

			System.out.println(name);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

}
