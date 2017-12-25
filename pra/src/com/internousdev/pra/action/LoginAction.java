package com.internousdev.pra.action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.pra.DAO.BuyItemDAO;
import com.internousdev.pra.DAO.LoginDAO;
import com.internousdev.pra.DTO.BuyItemDTO;
import com.internousdev.pra.DTO.LoginDTO;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements SessionAware {
	public Map<String, Object> session;
	private String result;
	private String loginUserId;
	private String loginPassword;
	private LoginDTO loginDTO = new LoginDTO();
	private LoginDAO loginDAO = new LoginDAO();
	private BuyItemDAO buyItemDAO = new BuyItemDAO();

	public String execcute() throws SQLException {

		result = ERROR;
		loginDTO = loginDAO.getLoginUserInfo(loginUserId, loginPassword);
		session.put("loginUser", loginDTO);

		if (((LoginDTO) session.get("loginUser")).getLoginFlg()) {
			result = SUCCESS;

			BuyItemDTO buyItemDTO = buyItemDAO.getBuyItemInfo();
			session.put("loginUser_Id", loginDTO);
			session.put("id", buyItemDTO.getItemId());
			session.put("buyItem_name", buyItemDTO.getItemName());
			session.put("buyItem_price", buyItemDTO.getItemPrice());

			return result;

		}
		return result;

	}
	public String getLoginUserId(){
		return loginUserId;
	}
	public void setLoginuserId(String loginUserId){
		this.loginUserId = loginUserId;
	}
	public String getLoginPassword(){
		return loginPassword;
	}
	public void setLoginPassword(String loginPassword){
		this.loginPassword = loginPassword;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}
