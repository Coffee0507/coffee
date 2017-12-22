package com.internousdev.practice.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.practice.DAO.BuyItemDAO;
import com.internousdev.practice.DAO.LoginActionDAO;
import com.internousdev.practice.DTO.BuyItemDTO;
import com.internousdev.practice.DTO.LoginActionDTO;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements SessionAware {
	public Map<String, Object> session;
	private String result;
	private LoginActionDAO loginActionDAO = new LoginActionDAO();
	private LoginActionDTO loginActionDTO = new LoginActionDTO();
	private String loginUserId;
	private String loginPassword;
	private BuyItemDAO buyItemDAO = new BuyItemDAO();


	public String execute() {
		result = ERROR;
		loginActionDTO = loginActionDAO.getLoginUserInfo(loginUserId,loginPassword);
		session.put("loginUser",loginActionDTO);
		if(((LoginActionDTO)session.get("loginUser")).getLoginFlg()){
			result = SUCCESS;

			BuyItemDTO buyItemDTO = buyItemDAO.getBuyItemInfo();
			session.put("login_user_id",loginActionDTO.getLoginId());
			session.put("buyItemId",buyItemDTO.getId());
			session.put("buyItemName",buyItemDTO.getItemName());
			session.put("buyItemPrice",buyItemDTO.getItemPrice());
			session.put("butItemStock",buyItemDTO.getItemStock());
			return result;
		}
		return result;
	}
	public String getLoginUserId(){
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId){
		this.loginUserId = loginUserId;
	}
	public String getLoginPassword(){
		return loginPassword;
	}
	public void setPassword(String loginPassword){
		this.loginPassword = loginPassword;
	}
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}