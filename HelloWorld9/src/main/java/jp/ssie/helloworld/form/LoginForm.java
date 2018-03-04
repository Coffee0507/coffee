package jp.ssie.helloworld.form;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import jp.ssie.helloworld.validation.GroupOrder1;
import jp.ssie.helloworld.validation.GroupOrder2;

public class LoginForm {

	@NotEmpty(groups = { GroupOrder1.class }, message = "ユーザーIDを入力してください。")
	@Pattern(regexp = "[0-9]*", groups = { GroupOrder2.class }, message = "パスワードは数である必要があります。")
	private int userId;

	@NotEmpty(groups = { GroupOrder1.class }, message = "パスワードを入力してください。")
	@Size(min = 8, max = 16, groups = { GroupOrder2.class }, message = "パスワードは{min}文字以上{max}文字以下です。")
	@Pattern(regexp = "[a-zA-Z0-9]*", groups = { GroupOrder2.class }, message = "パスワードは英数である必要があります。")
	private String loginPassword;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getLoginPassword() {
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}
}