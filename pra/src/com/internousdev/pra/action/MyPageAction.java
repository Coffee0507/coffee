package com.internousdev.pra.action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.pra.DAO.MyPageDAO;
import com.internousdev.pra.DTO.MyPageDTO;
import com.opensymphony.xwork2.ActionSupport;

public class MyPageAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;
	public String result;
	public String deleteFlg;
	public MyPageDAO myPageDAO = new MyPageDAO();
	public MyPageDTO myPageDTO = new MyPageDTO();

	public String execute() throws SQLException {
		// 商品を削除しない場合
		if (deleteFlg == null) {
			String item_transaction_id = session.get("id").toString();
			String user_master_id = session.get("loginUser_Id").toString();

			myPageDTO = myPageDAO.getMyPageUserInfo(item_transaction_id, user_master_id);

			session.put("total_price", myPageDTO.getTotalPrice());
			session.put("total_count", myPageDTO.getTotalCount());
			session.put("pay", myPageDTO.getTotalPayment());
			session.put("message", "");

		} else if (deleteFlg.equals("1")) {
			delete();
		}

		result = SUCCESS;
		return result;

	}

	public void delete() throws SQLException {

		String item_transaction_id = session.get("id").toString();
		String user_master_id = session.get("loginUser_Id").toString();

		int res = myPageDAO.buyItemHistoryDelete(item_transaction_id, user_master_id);

		if (res > 0) {
			session.put("message", "商品情報を正しく削除しました");
		} else if (res == 0) {
			session.put("message", "商品情報の削除に失敗しました");
		}
	}

	public String getDeleteFlg() {
		return deleteFlg;
	}

	public void setDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
