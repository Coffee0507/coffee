package com.internousdev.practice.Action;

import com.opensymphony.xwork2.ActionSupport;

public class HomeAction extends ActionSupport{
	public String result;
	public String execute(){
		result = SUCCESS;
		return result;
	}
}