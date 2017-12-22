package com.internousdev.practice.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.practice.DAO.BuyItemDAO;
import com.internousdev.practice.DAO.LoginDAO;
import com.internousdev.practice.DTO.BuyItemDTO;
import com.internousdev.practice.DTO.LoginActionDTO;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements SessionAware {
	private String loginUserId;
	private String loginPassword;

//	private String user_name;
//	private String login_password;


	private String result;
	public Map<String,Object> session;
	private LoginDAO loginActionDAO = new LoginDAO();
	private LoginActionDTO loginActionDTO = new LoginActionDTO();
	private BuyItemDAO buyItemDAO = new BuyItemDAO();


	public String execute() {

		session.put("buyItemName","NoteBook");
		session.put("buyItemPrice","100");

		BuyItemDTO buyItemDTO = buyItemDAO.getBuyItemInfo();
		session.put("login_user_id",loginActionDTO.getLoginId());
		session.put("buyItemId",buyItemDTO.getItemId());
		session.put("buyItemName",buyItemDTO.getItemName());
		session.put("buyItemPrice",buyItemDTO.getItemPrice());
		session.put("butItemStock",buyItemDTO.getItemStock());

		return SUCCESS;

//		result = ERROR;
//		loginActionDTO = loginActionDAO.getLoginUserInfo(loginUserId,loginPassword);
//		session.put("loginUser",loginActionDTO);
//		if(((LoginActionDTO)session.get("loginUser")).getLoginFlg()){
//			result = SUCCESS;
//
//			BuyItemDTO buyItemDTO = buyItemDAO.getBuyItemInfo();
//			session.put("login_user_id",loginActionDTO.getLoginId());
//			session.put("buyItemId",buyItemDTO.getId());
//			session.put("buyItemName",buyItemDTO.getItemName());
//			session.put("buyItemPrice",buyItemDTO.getItemPrice());
//			session.put("butItemStock",buyItemDTO.getItemStock());
//			return result;
//		}
//		return result;
	}

//	public String getUser_name() {
//		return user_name;
//	}
//
//	public void setUser_name(String user_name) {
//		this.user_name = user_name;
//	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
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