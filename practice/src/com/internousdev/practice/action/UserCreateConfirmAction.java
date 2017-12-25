package com.internousdev.practice.action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class UserCreateConfirmAction extends ActionSupport implements SessionAware {
	public Map<String, Object> session;
	private String result;
	private String loginUserId;
	private String loginPassword;
	private String userName;
	private String errorMessage;

	public String execute() throws SQLException {
		result = SUCCESS;
		if (!(loginUserId.equals("")) && !(loginPassword.equals("")) && !(userName.equals(""))) {
			session.put("loginUserId", loginUserId);
			session.put("loginPassword", loginPassword);
			session.put("userName", userName);
		} else {
			setErrorMessage("未入力の項目があります");
			result = ERROR;
		}

		return result;

	}

	public String getLoginUserId() {
		return loginUserId;
	}

	public void getLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}

	public String getLoginPassword() {
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getErrorMessege() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
		;
	}
}