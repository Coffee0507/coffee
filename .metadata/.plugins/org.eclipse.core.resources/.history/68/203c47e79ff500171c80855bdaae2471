package com.internousdev.pra.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.pra.DAO.MyPageDAO;
import com.internousdev.pra.DTO.MyPageDTO;
import com.opensymphony.xwork2.ActionSupport;

public class MyPageAction extends ActionSupport implements SessionAware {
	public Map<String, Object> session;
	private MyPageDAO myPageDAO = new MyPageDAO();
	private MyPageDTO myPageDTO = new MyPageDTO();
	private String result;

	public String execute() {
		result = SUCCESS;
		String userLoginId = session.get("userLoginId").toString();
		myPageDTO = myPageDAO.getBuyItemInfo(userLoginId);

		session.put("LoginId",myPageDTO.getLoginId());
		session.put("ItemId", myPageDTO.getItemId());
		session.put("ItemName",myPageDTO.getItemName());
		session.put("ItemPrice",myPageDTO.getItemPrice());
		session.put("ItemPay",myPageDTO.getPay());
		session.put("InsertDate",myPageDTO.getInsertDate());

		return result;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
