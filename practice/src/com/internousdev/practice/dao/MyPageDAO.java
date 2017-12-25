package com.internousdev.practice.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.internousdev.practice.dto.MyPageDTO;
import com.internousdev.practice.util.DBConnector;

public class MyPageDAO {
	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private MyPageDTO myPageDTO = new MyPageDTO();

	public MyPageDTO getMyPageUserInfo(String item_transaction_id, String user_master_id) {
		String sql = "SELECT total_price,total_count,pay FROM user_buy_item_transaction where item_transaction_id=? AND user_master_id=?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, item_transaction_id);
			ps.setString(2, user_master_id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				myPageDTO.setTotalPrice(rs.getString("total_price"));
				myPageDTO.setTotalCount(rs.getString("total_count"));
				myPageDTO.setPayment(rs.getString("pay"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return myPageDTO;
	}

	public int buyItemHistoryDelete(String item_transaction_id, String user_master_id) throws SQLException {
		String sql = "DELETE FROM user_buy_item_transaction where item_transaction_id=? AND user_master_id=?";

		int result = 0;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, item_transaction_id);
			ps.setString(2, user_master_id);

			result = ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public MyPageDTO getMyPageDTO(){
		return myPageDTO;
	}
}