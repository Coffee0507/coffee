package com.internousdev.sample.Action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.sample.DAO.MyPageDAO;
import com.internousdev.sample.DTO.MyPageDTO;
import com.opensymphony.xwork2.ActionSupport;

public class MyPageAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;
	private String result;

	private MyPageDTO myPageDTO = new MyPageDTO();
	private MyPageDAO myPageDAO = new MyPageDAO();


	public String execute() throws SQLException {
		result = SUCCESS;

		myPageDTO = myPageDAO.BuyItemHistoryInfo(session.get("loginId").toString());
		session.put("itemInfo", myPageDTO);

		if(((MyPageDTO)session.get("itemInfo")).getMyPageFlg()){

			session.put("myItemName",myPageDTO.getItemName());
			session.put("myItemPrice",myPageDTO.getItemPrice());
			session.put("myItemStock",myPageDTO.getItemStock());
			session.put("myItemPay",myPageDTO.getItemPay());
			session.put("myItemId",myPageDTO.getItemId().toString());
		}else{
			delete();
		}
		return result;
	}
	private void delete() throws SQLException{

		String itemId = session.get("myItemId").toString();
		int res = myPageDAO.buyItemHistoryDelete(itemId);
		session.put("deleteInfo", myPageDTO);

		if(res>0){
			session.put("message","商品の削除に成功しました");
		}else if(res == 0){
			session.put("message","商品の削除に成功しました");
		}
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}