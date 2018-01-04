package com.internousdev.pra.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.internousdev.pra.util.DBConnector;
import com.internousdev.pra.util.DateUtil;

public class BuyItemCompleteDAO {
	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private String sql = "INSERT INTO user_buy_item_transaction(item_transaction_id,total_price,total_count,user_master_id,pay,insert_date) VALUES(?,?,?,?,?,?)";
	private DateUtil dateUtil = new DateUtil();

	public void buyItemInfo(String item_transaction_id, String user_master_id, String total_price, String total_count, String pay) throws SQLException {
		PreparedStatement ps = con.prepareStatement(sql);

		try{
			ps.setString(1, item_transaction_id);
			ps.setString(2, total_price);
			ps.setString(3, total_count);
			ps.setString(4, user_master_id);
			ps.setString(5, pay);
			ps.setString(6, dateUtil.getDate());

			ps.execute();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			con.close();
		}
	}

}
