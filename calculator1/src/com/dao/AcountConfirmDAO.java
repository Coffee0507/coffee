package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Util.DBConnector;
import com.dto.AcountConfirmDTO;

public class AcountConfirmDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private AcountConfirmDTO dto = new AcountConfirmDTO();

	public AcountConfirmDTO getAcountInfo(String name1, String name2) throws SQLException {
		String sql = "select*from acount_info_transaction where name1 = ? and name2=?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, name1);
			ps.setString(2, name2);

			ResultSet rs = ps.executeQuery();

			if (!(rs.getString("name1").equals(null))) {

				dto.setName1(rs.getString("name1"));
				dto.setName2(rs.getString("name2"));
				dto.setFlg(true);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			con.close();
		}

		return dto;
	}

}
