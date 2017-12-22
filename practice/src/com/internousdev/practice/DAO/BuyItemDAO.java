package com.internousdev.practice.DAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.internousdev.practice.DTO.BuyItemDTO;
import com.internousdev.practice.util.DBConnector;

public class BuyItemDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();

	public BuyItemDTO getBuyItemInfo() {

		BuyItemDTO buyItemDTO = new BuyItemDTO();
		String sql = "select * from item_info_transaction";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				buyItemDTO.setItemId(rs.getString("id"));
				buyItemDTO.setItemName(rs.getString("item_name"));
				buyItemDTO.setItemPrice(rs.getString("item_price"));
				buyItemDTO.setItemStock(rs.getString("item_stock"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return buyItemDTO;

	}

}