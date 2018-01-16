package com.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class CalculatorAction extends ActionSupport implements SessionAware {

	private String result;
	private String number1;
	private String number2;
	private String method;
	public Map<String, Object> session;

	public String execute() {
		if (!(number1.equals(""))) {
			if (!(number2.equals(""))) {
				if (method.equals("1")) {
					int total1 = Integer.parseInt(number1);
					int total2 = Integer.parseInt(number2);
					session.put("total", (total1 + total2));
					result = SUCCESS;
					return result;

				} else if (method.equals("2")) {
					int total1 = Integer.parseInt(number1);
					int total2 = Integer.parseInt(number2);
					session.put("total", (total1 - total2));
					result = SUCCESS;
					return result;

				} else if (method.equals("3")) {
					int total1 = Integer.parseInt(number1);
					int total2 = Integer.parseInt(number2);
					session.put("total", (total1 * total2));
					result = SUCCESS;
					return result;

				} else if (method.equals("4")) {
					int total1 = Integer.parseInt(number1);
					int total2 = Integer.parseInt(number2);
					session.put("total", (total1 / total2));
					result = SUCCESS;
					return result;

				}
			}
		}
		result = ERROR;
		return result;
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
