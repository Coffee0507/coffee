package com.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class AcountUpdateConfirmAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;
	private String result;
	private String changeName1;
	private String changeName2;
	private String changeBirthyear;
	private String changeBirthmonth;
	private String changeBirthday;
	private String changeSex;

	public String execute() {
		result = SUCCESS;
		if (!(changeName1.equals(""))) {
			session.put("changeName1", changeName1);
		} else {
			session.put("changeName1", session.get("name1"));
		}
		;
		if (!(changeName2.equals(""))) {
			session.put("changeName2", changeName2);
		} else {
			session.put("changeName2", session.get("name2"));
		}
		;
		if (changeBirthyear.equals("1989")) {
			session.put("changeBirthyear", "1989");
		} else if (changeBirthyear.equals("1990")) {
			session.put("changeBirthyear", "1990");
		}
		;
		if (changeBirthmonth.equals("1")) {
			session.put("changeBirthmonth", "1");
		} else if (changeBirthmonth.equals("2")) {
			session.put("changeBirthmonth", "2");
		} else if (changeBirthmonth.equals("3")) {
			session.put("changeBirthmonth", "3");
		} else if (changeBirthmonth.equals("4")) {
			session.put("changeBirthmonth", "4");
		} else if (changeBirthmonth.equals("5")) {
			session.put("changeBirthmonth", "5");
		} else if (changeBirthmonth.equals("6")) {
			session.put("changeBirthmonth", "6");
		} else if (changeBirthmonth.equals("7")) {
			session.put("changeBirthmonth", "7");
		} else if (changeBirthmonth.equals("8")) {
			session.put("changeBirthmonth", "8");
		} else if (changeBirthmonth.equals("9")) {
			session.put("changeBirthmonth", "9");
		} else if (changeBirthmonth.equals("10")) {
			session.put("changeBirthmonth", "10");
		} else if (changeBirthmonth.equals("11")) {
			session.put("changeBirthmonth", "11");
		} else if (changeBirthmonth.equals("12")) {
			session.put("changeBirthmonth", "12");
		}
		;
		if (changeBirthday.equals("1")) {
			session.put("changeBirthday", "1");
		} else if (changeBirthmonth.equals("2")) {
			session.put("changeBirthday", "2");
		} else if (changeBirthmonth.equals("3")) {
			session.put("changeBirthday", "3");
		} else if (changeBirthmonth.equals("4")) {
			session.put("changeBirthday", "4");
		} else if (changeBirthmonth.equals("5")) {
			session.put("changeBirthday", "5");
		} else if (changeBirthmonth.equals("6")) {
			session.put("changeBirthday", "6");
		} else if (changeBirthmonth.equals("7")) {
			session.put("changeBirthday", "7");
		} else if (changeBirthmonth.equals("8")) {
			session.put("changeBirthday", "8");
		} else if (changeBirthmonth.equals("9")) {
			session.put("changeBirthday", "9");
		} else if (changeBirthmonth.equals("10")) {
			session.put("changeBirthday", "10");
		} else if (changeBirthmonth.equals("11")) {
			session.put("changeBirthday", "11");
		} else if (changeBirthmonth.equals("12")) {
			session.put("changeBirthday", "12");
		} else if (changeBirthmonth.equals("13")) {
			session.put("changeBirthday", "13");
		} else if (changeBirthmonth.equals("14")) {
			session.put("changeBirthday", "14");
		} else if (changeBirthmonth.equals("15")) {
			session.put("changeBirthday", "15");
		} else if (changeBirthmonth.equals("16")) {
			session.put("changeBirthday", "16");
		} else if (changeBirthmonth.equals("17")) {
			session.put("changeBirthday", "17");
		} else if (changeBirthmonth.equals("18")) {
			session.put("changeBirthday", "18");
		} else if (changeBirthmonth.equals("19")) {
			session.put("changeBirthday", "19");
		} else if (changeBirthmonth.equals("20")) {
			session.put("changeBirthday", "20");
		} else if (changeBirthmonth.equals("21")) {
			session.put("changeBirthday", "21");
		} else if (changeBirthmonth.equals("22")) {
			session.put("changeBirthday", "22");
		} else if (changeBirthmonth.equals("23")) {
			session.put("changeBirthday", "23");
		} else if (changeBirthmonth.equals("24")) {
			session.put("changeBirthday", "24");
		} else if (changeBirthmonth.equals("25")) {
			session.put("changeBirthday", "25");
		} else if (changeBirthmonth.equals("26")) {
			session.put("changeBirthday", "26");
		} else if (changeBirthmonth.equals("27")) {
			session.put("changeBirthday", "27");
		} else if (changeBirthmonth.equals("28")) {
			session.put("changeBirthday", "28");
		} else if (changeBirthmonth.equals("29")) {
			session.put("changeBirthday", "29");
		} else if (changeBirthmonth.equals("30")) {
			session.put("changeBirthday", "30");
		} else if (changeBirthmonth.equals("31")) {
			session.put("changeBirthday", "31");
		}
		;
		if (changeSex.equals("1")) {
			session.put("changeSex", "男性");
		} else {
			session.put("changeSex", "女性");
		}
		;

		return result;
	}

	public String getChangeName1() {
		return changeName1;
	}

	public void setChangeName1(String changeName1) {
		this.changeName1 = changeName1;
	}

	public String getChangeName2() {
		return changeName2;
	}

	public void setChangeName2(String changeName2) {
		this.changeName2 = changeName2;
	}

	public String getChangeBirthyear() {
		return changeBirthyear;
	}

	public void setChangeBirthyear(String changeBirthyear) {
		this.changeBirthyear = changeBirthyear;
	}

	public String getChangeBirthmonth() {
		return changeBirthmonth;
	}

	public void setChangeBirthmonth(String changeBirthmonth) {
		this.changeBirthmonth = changeBirthmonth;
	}

	public String getChangeBirthday() {
		return changeBirthday;
	}

	public void setChangeBirthday(String changeBirthday) {
		this.changeBirthday = changeBirthday;
	}

	public String getChangeSex() {
		return changeSex;
	}

	public void setChangeSex(String changeSex) {
		this.changeSex = changeSex;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
