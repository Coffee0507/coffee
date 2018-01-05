package com.internousdev.pra.action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class BuyItemCompleteAction extends ActionSupport implements SessionAware {

	private String result;

	public Map<String,Object>session;

	public String execute() {
		result = SUCCESS;

		return result;
	}
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}
