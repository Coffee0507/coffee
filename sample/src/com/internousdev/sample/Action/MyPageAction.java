package com.internousdev.sample.Action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class MyPageAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;

	private String result;

	public String execute() throws SQLException {
		result = SUCCESS;

		return result;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}