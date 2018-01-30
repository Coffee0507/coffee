package com.internousdev.form;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.internousdev.validation.GroupOrder1;
import com.internousdev.validation.GroupOrder2;

public class FirstForm {

	@NotEmpty(groups={GroupOrder1.class},message="ユーザー名を入力してください")
	private String loginName;

	@NotEmpty(groups={GroupOrder1.class},message="パスワードを入力してください")
	@Size(min=8,max=16,groups={GroupOrder2.class},message="パスワードは{min}以上、{max}以下です")
	@Pattern(regexp="[a-zA-Z0-9]*",groups={GroupOrder2.class},message="パスは英数である必要があります")
	private String loginPassword;

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName){
		this.loginName = loginName;
	}

	public String getLoginPassword(){
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword){
		this.loginPassword = loginPassword;
	}

}