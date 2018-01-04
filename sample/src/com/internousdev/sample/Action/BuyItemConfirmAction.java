package com.internousdev.sample.Action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.sample.DAO.BuyItemConfirmDAO;
import com.opensymphony.xwork2.ActionSupport;

public class BuyItemConfirmAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;

	private String result;

	private BuyItemConfirmDAO buyItemConfirmDAO = new BuyItemConfirmDAO();

	public String execute() throws SQLException {
		result = SUCCESS;

		buyItemConfirmDAO.buyItemInfo(session.get("buyItemid").toString(), session.get("buyItemPrice").toString(),
				session.get("stock").toString(), session.get("loginId").toString(), session.get("pay").toString());

		return result;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}