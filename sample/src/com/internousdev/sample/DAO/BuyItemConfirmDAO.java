package com.internousdev.sample.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.internousdev.sample.util.DBConnector;
import com.internousdev.sample.util.UtilDate;

public class BuyItemConfirmDAO {
	private DBConnector db = new DBConnector();
	private UtilDate utilDate = new UtilDate();
	private Connection con = db.getConnection();

	public void buyItemInfo(String itemId, String itemPrice, String itemStock, String loginId, String pay) throws SQLException{

		String sql = "insert into user_buy_item_transaction(item_transaction_id,total_price,total_count,user_master_id,pay,insert_date) values(?,?,?,?,?,?)";

		try{
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, itemId);
			ps.setString(2, itemPrice);
			ps.setString(3, itemStock);
			ps.setString(4, loginId);
			ps.setString(5, pay);
			ps.setString(6, utilDate.getDate());

			ps.execute();

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			con.close();
		}
	}
}