package jp.ssie.syakyou.form;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import jp.ssie.syakyou.validation.GroupOrder1;
import jp.ssie.syakyou.validation.GroupOrder2;

public class LoginForm {

	@NotEmpty(groups= {GroupOrder1.class},message="ユーザーIDを入力してください")
	@Pattern(regexp="^[0-9]*",groups={GroupOrder2.class},message="IDは数字です")
	private String userId;

	@NotEmpty(groups= {GroupOrder1.class},message="パスワードを入力してください")
	@Size(min=8,max=16,groups= {GroupOrder2.class},message="パスワードは{min}以上{max}以下です")
	@Pattern(regexp="^[a-z-A-Z0-9]*",groups= {GroupOrder2.class},message="パスワードは英数です")
	private String loginPassword;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getLoginPassword() {
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}

}
