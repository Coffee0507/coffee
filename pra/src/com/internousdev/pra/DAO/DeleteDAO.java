package com.internousdev.pra.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.internousdev.pra.util.DBConnector;

public class DeleteDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();

	public void deleteInfo(String loginId, String itemId, String itemName, String itemStock, String itemPrice,
			String itemPay, String insertDate) throws SQLException{
		String sql = "insert into user_buy_item_transaction";

		try{
			PreparedStatement ps = con.prepareStatement(sql);

		}catch(Exception e){
			e.printStackTrace();
		}


	}

	public boolean getdeleteFlg() {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

}
