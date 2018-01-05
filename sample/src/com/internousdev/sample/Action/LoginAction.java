package com.internousdev.sample.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.sample.DAO.BuyItemDAO;
import com.internousdev.sample.DAO.LoginDAO;
import com.internousdev.sample.DTO.BuyItemDTO;
import com.internousdev.sample.DTO.LoginDTO;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements SessionAware {
	private String result;
	public Map<String, Object> session;
	private LoginDAO loginDAO = new LoginDAO();
	private LoginDTO loginDTO = new LoginDTO();
	private BuyItemDAO buyItemDAO = new BuyItemDAO();
	private String loginUserId;
	private String loginPass;

	public String execute(){
		result = ERROR;

		loginDTO = loginDAO.getloginUserInfo(loginUserId, loginPass);
		session.put("loginUserInfo", loginDTO);

		if (((LoginDTO)session.get("loginUserInfo")).getLoginFlg()) {
			result = SUCCESS;

			BuyItemDTO buyItemDTO = buyItemDAO.getBuyItemInfo();
			session.put("loginId", loginDTO.getLoginUserId());
			session.put("buyItemName", buyItemDTO.getBuyItemName());
			session.put("buyItemPrice", buyItemDTO.getBuyItemPrice());
			session.put("buyItemid", buyItemDTO.getBuyItemId());

			return result;
		}

		return result;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	public String getLoginUserId(){
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId){
		this.loginUserId = loginUserId;
	}
	public String getLoginPassword(){
		return loginPass;
	}
	public void setLoginPass(String loginPass){
		this.loginPass = loginPass;
	}

}