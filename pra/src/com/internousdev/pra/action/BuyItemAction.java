package com.internousdev.pra.action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class BuyItemAction extends ActionSupport implements SessionAware {
	public Map<String, Object> session;
	private int stock;
	private String pay;
	private String result;

	public String execute() throws SQLException {
		result = SUCCESS;
		session.put("stock", stock);
		int intStock = Integer.parseInt(session.get("stock").toString());
		int intPrice = Integer.parseInt(session.get("buyItem_price").toString());

		session.put("buyItem_price", intStock * intPrice);
		String payment;

		if (pay.equals("1")) {
			payment = "現金払い";
			session.put("pay", payment);
		} else {
			payment = "クレジットカード払い";
			session.put("pay", payment);
		}

		return result;

	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getPayment() {
		return pay;
	}

	public void setPayment(String pay) {
		this.pay = pay;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}
