package com.internousdev.practice.DTO;

public class LoginDTO {
	private String loginuserId;
	private String loginPassword;
	private String userName;
	public boolean loginFlg = false;

	public String getLoginId() {
		return loginuserId;
	}

	public void setLoginId(String loginuserId) {
		this.loginuserId = loginuserId;
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

	public boolean getLoginFlg() {
		return loginFlg;

	}

	public void setLoginFlg(boolean loginFlg) {
		this.loginFlg = loginFlg;
	}

}
