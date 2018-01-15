package com.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class CalculatorAction extends ActionSupport implements SessionAware {

	private String result;
	private String number1="5";
	private String number2 ="2";
	private String method="1";
	public Map<String, Object> session;

	public String execute() {
		getCalculatedOutput(number1,number2,method);
		result = SUCCESS;
		return result;
	}

	public void getCalculatedOutput(String number1, String number2, String method) {
		if (method.equals("1")) {
			int total1 = Integer.parseInt(number1);
			int total2 = Integer.parseInt(number2);
			session.put("total", (total1 + total2));
		} else if (method.equals("2")) {
			int total1 = Integer.parseInt(number1);
			int total2 = Integer.parseInt(number2);
			session.put("total", (total1 - total2));
		} else if (method.equals("3")) {
			int total1 = Integer.parseInt(number1);
			int total2 = Integer.parseInt(number2);
			session.put("total", (total1 * total2));
		} else if (method.equals("4")) {
			int total1 = Integer.parseInt(number1);
			int total2 = Integer.parseInt(number2);
			session.put("total", (total1 / total2));
		}
	}

	public String getNumber1() {
		return number1;
	}

	public void setNumber1(String number1) {
		this.number1 = number1;
	}

	public String getNumber2() {
		return number2;
	}

	public void setNumber2(String number2) {
		this.number2 = number2;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}