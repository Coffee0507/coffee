package com.internousdev.sample.DTO;

public class LoginDTO {
	private String loginUserId;
	private String UserName;
	private String loginPass;
	public boolean loginFlg = false;


	public String getLoginUserId(){
		return loginUserId;
	}

	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}

	public String getLoginUserName(){
		return UserName;
	}

	public void setLoginUserName(String UserName) {
		this.UserName = UserName;
				}

	public String getLoginPassword(){
		return loginPass;
	}

	public void setLoginPassword(String loginPass) {
		this.loginPass = loginPass;
	}

	public boolean getLoginFlg(){
		return loginFlg;
	}

	public void setLoginFlg(boolean loginFlg) {
		this.loginFlg = loginFlg;
	}


}
