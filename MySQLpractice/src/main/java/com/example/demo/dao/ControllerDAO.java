package com.example.demo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.demo.dto.ControllerDTO;
import com.example.demo.util.DBConnector;

public class ControllerDAO {

	private ControllerDTO dto;
	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();

	public ControllerDTO getInfo() {
		String sql = "select * from Controller where name = ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, "takahashi");

			ResultSet rs = ps.executeQuery();

			if(rs.next()){
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setAge(rs.getString("age"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dto;
	}

}
