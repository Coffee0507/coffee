package com.internousdev.pra.DTO;

public class LoginDTO {

	public String loginUserId;
	public String loginUserName;
	public String loginUserPass;
	public boolean loginFlg = false;


	public String getLoginUserId() {
		return loginUserId;
	}

	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}

	public String getLoginUserName() {
		return loginUserName;
	}

	public void setLoginUserName(String loginUserName) {
		this.loginUserName = loginUserName;
	}

	public String getLoginUserPass() {
		return loginUserName;
	}

	public void setLoginUserPass(String loginUserPass) {
		this.loginUserPass = loginUserPass;
	}

	public boolean getLoginFlg() {
		return loginFlg;
	}

	public void setLoginFlg(boolean loginFlg) {
		this.loginFlg = loginFlg;
	}



}
