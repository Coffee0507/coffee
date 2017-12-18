package com.internousdev.practice.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.practice.DAO.LoginDAO;
import com.internousdev.practice.DTO.LoginDTO;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements SessionAware{
	private String loginuserId;
	private String loginuserPass;
	public Map<String,Object>session;
	private LoginDAO loginDAO = new LoginDAO();
	private LoginDTO loginDTO = new LoginDTO();
	public String result;

	public String execute(){
		result = ERROR;

		loginDTO = loginDAO.getLoginUserInfo(loginuserId, loginuserPass);
		session.put("loginUser", loginDTO);

		if(((LoginDTO)session.get("loginUser")).getLoginFlg()){
			result = SUCCESS;

			session.put("login_user_id",loginDTO.getLoginId());

			return result;
		}
		return result;
	}
	public String getLoginUserID(){
		return loginuserId;
	}
	public void setLoginUserID(String loginuserId){
		this.loginuserId = loginuserId;
	}
	public String setLoginUserPass(){
		return loginuserPass;
	}
	public void setLoginUserPass(String loginuserPass){
		this.loginuserPass = loginuserPass;
	}
	public void setSession(Map<String,Object>session){
		this.session = session;
	}
}