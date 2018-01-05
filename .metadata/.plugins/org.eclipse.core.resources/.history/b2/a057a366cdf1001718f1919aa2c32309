package com.internousdev.pra.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.internousdev.pra.DTO.MyPageDTO;
import com.internousdev.pra.util.DBConnector;

public class MyPageDAO {
	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private MyPageDTO myPageDTO = new MyPageDTO();

	public MyPageDTO getMyPageUserInfo(String item_transaction_id, String user_master_id) throws SQLException {
		String sql = "SELECT total_count,total_price,pay FROM user_buy_item_transaction where item_transaction_id=? AND user_master_id=?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, item_transaction_id);
			ps.setString(2, user_master_id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				myPageDTO.setTotalPrice(rs.getString("total_price"));
				myPageDTO.setTotalCount(rs.getString("total_count"));
				myPageDTO.setTotalPayment(rs.getString("pay"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			con.close();
		}
		return myPageDTO;
	}

	public int buyItemHistoryDelete(String item_transaction_id, String user_master_id) throws SQLException {
		String sql = "DELETE FROM user_buy_item_transaction where item_transaction_id=? AND user_master_id=?";

		int rs = 0;
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, item_transaction_id);
			ps.setString(2, user_master_id);

			rs = ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			con.close();
		}

		return rs;
	}
	public MyPageDTO myPageDTO(){
		return myPageDTO();
	}

}
