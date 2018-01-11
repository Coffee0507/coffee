package com.Action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.dao.AcountConfirmDAO;
import com.dto.AcountConfirmDTO;
import com.opensymphony.xwork2.ActionSupport;

public class AcountConfirm extends ActionSupport implements SessionAware {

	private String age;
	private String name1;
	private String name2;
	private String sex;

	private String result;
	public Map<String, Object> session;
	public AcountConfirmDAO dao = new AcountConfirmDAO();
	public AcountConfirmDTO dto = new AcountConfirmDTO();

	public String excute() throws SQLException {
		result = "SUCCESS";

		dto = dao.getAcountInfo(age, name1, name2, sex);
		session.put("Acount", dto);

		if (true) {
			session.put("name1", dto.getName1());
			session.put("name2", dto.getName2());
			session.put("age", dto.getAge());
			session.put("sex", dto.getSex());
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

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}
