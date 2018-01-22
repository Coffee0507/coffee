package com.internousdev.sample.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.internousdev.sample.DTO.MyPageDTO;
import com.internousdev.sample.util.DBConnector;

public class MyPageDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private MyPageDTO myPageDTO = new MyPageDTO();

	public MyPageDTO BuyItemHistoryInfo(String loginUserId) throws SQLException {

		String sql1 = "select*from uer_buy_item_transaction where user_master_id=?";

		try {
			PreparedStatement ps1 = con.prepareStatement(sql1);

			ps1.setString(1, loginUserId);
			ResultSet rs1 = ps1.executeQuery();

			if (rs1.next()) {
				myPageDTO.setItemPrice(rs1.getString("total_price"));
				myPageDTO.setItemStock(rs1.getString("total_count"));
				myPageDTO.setItemPay(rs1.getString("pay"));
				myPageDTO.setItemId(rs1.getString("item_transaction_id"));

				String sql2 = "select*from item_info_transaction";

				try {
					PreparedStatement ps2 = con.prepareStatement(sql2);

					ps2.setString(1, "item_transaction_id");
					ResultSet rs2 = ps2.executeQuery();

					if (rs2.next()) {
						myPageDTO.setItemName(rs2.getString("item_name"));
						myPageDTO.setMyPageFlg(true);
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			con.close();
		}
		return myPageDTO;

	}

	public int buyItemHistoryDelete(String itemId) {

		String sql = "delete from user_buy_item_transaction where item_transaction_id=?";
		int rs = 0;
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1,itemId);
			rs = ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return rs;
	}

}
