package com.internousdev.practice.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class BuyItemAction extends ActionSupport implements SessionAware {
	private int stock;
	private String pay;
	public Map<String, Object> session;
	private String result;

	public String execute(){

	}

}
