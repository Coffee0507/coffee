package com.dto;

public class LoginAcountConfirmDTO {

	private int id;
	private String name1;
	private String name2;
	private String birthyear;
	private String birthmonth;
	private String birthday;
	private String sex;
	private boolean Flg;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getBirthYear() {
		return birthyear;
	}

	public void setBirthYear(String birthyear) {
		this.birthyear = birthyear;
	}

	public String getBirthMonth() {
		return birthmonth;
	}

	public void setBirthMonth(String birthmonth) {
		this.birthmonth = birthmonth;
	}

	public String getBirthDay() {
		return birthday;
	}

	public void setBirthDay(String birthday) {
		this.birthday = birthday;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public boolean getFlg() {
		return Flg;
	}

	public void setFlg(boolean Flg) {
		this.Flg = Flg;
	}

}