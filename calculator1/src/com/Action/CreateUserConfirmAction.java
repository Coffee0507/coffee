package com.Action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class CreateUserConfirmAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;
	private String result;
	private String name1;
	private String name2;
	private int birth_year;
	private int birth_month;
	private int birth_day;
	private String sex;

	public String execute() throws SQLException {
		result = ERROR;

		if (!(name1.equals("")) && !(name2.equals(""))) {

			session.put("name1", name1);
			session.put("name2", name2);
			session.put("birth_year", birth_year);
			session.put("birth_month", birth_month);
			session.put("birth_day", birth_day);
			session.put("sex", sex);

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

	public int getBirthyear() {
		return birth_year;
	}

	public void setBirthyear(int birth_year) {
		this.birth_year = birth_year;
	}

	public int getBirthmonth() {
		return birth_month;
	}

	public void setBirthmonth(int birth_month) {
		this.birth_month = birth_month;
	}

	public int getBirthday() {
		return birth_day;
	}

	public void setBirthday(int birth_day) {
		this.birth_day = birth_day;
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