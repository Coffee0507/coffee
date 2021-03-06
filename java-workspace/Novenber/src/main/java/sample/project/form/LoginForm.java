package sample.project.form;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class LoginForm {

	@NotNull
	@Size(min=5, max=20)
	@Pattern(regexp="[0-9a-zA-Z]")
	private int loginId;

	@Size(min=5, max=20)
	@Pattern(regexp="[0-9a-zA-Z]")
	private String loginName;

	@Size(min=5, max=10)
	@Pattern(regexp="[0-9a-zA-Z]")
	private String loginPass;

	public int getLoginId() {
		return loginId;
	}

	public void setLoginId(int loginId) {
		this.loginId = loginId;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginPass() {
		return loginPass;
	}

	public void setLoginPass(String loginPass) {
		this.loginPass = loginPass;
	}
}
