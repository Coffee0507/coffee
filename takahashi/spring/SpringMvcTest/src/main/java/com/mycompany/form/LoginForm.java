package com.mycompany.form;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.mycompany.validation.GroupOrder1;
import com.mycompany.validation.GroupOrder2;

public class LoginForm {

	@NotEmpty(groups = { GroupOrder1.class }, message = "nameを入力してください")
	@Pattern(regexp = "^[a-z]*", groups = { GroupOrder2.class }, message = "nameは半角英数")
	private String name;

	@NotEmpty(groups = { GroupOrder1.class }, message = "passを入力してください")
	@Size(min = 8, max = 16, groups = { GroupOrder2.class }, message = "入力する文字は{min}以上{max}以上です")
	@Pattern(regexp = "^[0-9a-zA-Z]*", groups = { GroupOrder2.class }, message = "半角英数字を入力してください")
	private String pass;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

}