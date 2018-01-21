package com.internousdev.pra.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.internousdev.pra.DTO.BuyItemDTO;
import com.internousdev.pra.util.DBConnector;

public class BuyItemDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private BuyItemDTO buyItemDTO = new BuyItemDTO();

	public BuyItemDTO getItemInfo() throws SQLException {
		String sql = "select*from item_info_transaction";

		try{
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			if(rs.next()){
				buyItemDTO.setItemName(rs.getString("item_name"));
				buyItemDTO.setItemId(rs.getInt("id"));
				buyItemDTO.setItemPrice(rs.getString("item_price"));
			}

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			con.close();
		}
		return buyItemDTO;
	}
}
