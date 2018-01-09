package com.internousdev.pra.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.internousdev.pra.util.DBConnector;
import com.internousdev.pra.util.DateUtil;

public class BuyItemConfirmDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private DateUtil dateUtil = new DateUtil();

	public void buyItemInfo(String itemId, String itemName, String itemPrice, String stock, String loginId,
			String pay) {
		String sql = "insert into user_buy_item_transaction(item_transaction_id,item_name,item_price,item_stock,user_master_id,pay,insert_date) values(?,?,?,?,?,?,?)";

		try {

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, itemId);
			ps.setString(2, itemName);
			ps.setString(3, itemPrice);
			ps.setString(4, stock);
			ps.setString(5, loginId);
			ps.setString(6, pay);
			ps.setString(7, dateUtil.getDate());
			ps.execute();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
