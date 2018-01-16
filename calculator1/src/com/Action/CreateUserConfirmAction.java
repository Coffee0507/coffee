package com.Action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.dao.CreateUserConfirmActionDAO;
import com.opensymphony.xwork2.ActionSupport;

public class CreateUserConfirmAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;
	private String result;
	private String name1;
	private String name2;
	private String birthyear;
	private String birthmonth;
	private String birthday;
	private String sex;
	private CreateUserConfirmActionDAO dao = new CreateUserConfirmActionDAO();

	public String execute() throws SQLException {
		result = ERROR;

		dao.getCreateInfo(name1, name2, birthyear, birthmonth, birthday, sex);

		if (!(name1.equals("")) && !(name2.equals(""))) {

			if(sex.equals("1")){
				sex = "男性";
				session.put("sex", sex);
			}else{
				sex="女性";
				session.put("sex", sex);
			}

			session.put("name1", name1);
			session.put("name2", name2);
			session.put("birthyear", birthyear);
			session.put("birthmonth", birthmonth);
			session.put("birthday", birthday);

			result = SUCCESS;
			return result;
		}
		return result;
	}

	public String getName1() {
		return name1;
	}

	public void setName1(String name1) {
		this.name1 = name1;
	}

	public String getName2() {
		return name2;
	}

	public void setName2(String name2) {
		this.name2 = name2;
	}

	public String getBirthyear() {
		return birthyear;
	}

	public void setBirthyear(String birthyear) {
		this.birthyear = birthyear;
	}

	public String getBirthmonth() {
		return birthmonth;
	}

	public void setBirthmonth(String birthmonth) {
		this.birthmonth = birthmonth;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}
