package com.Action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.dao.LoginAcountConfirmDAO;
import com.dto.LoginAcountConfirmDTO;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAcountConfirmAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;
	private String result;
	private LoginAcountConfirmDAO dao = new LoginAcountConfirmDAO();
	private LoginAcountConfirmDTO dto = new LoginAcountConfirmDTO();

	public String execute() throws SQLException {
		dto = dao.info(session.get("name1").toString(), session.get("name2").toString());
		session.put("AcountInfo", dto);

		if (((LoginAcountConfirmDTO) session.get("AcountInfo")).getFlg()) {
			session.put("id",dto.getId());
			session.put("birthyear", dto.getBirthYear());
			session.put("birthmonth", dto.getBirthMonth());
			session.put("birthday", dto.getBirthDay());
			if(dto.getSex().equals("1")){
				String sex="男性";
				session.put("sex",sex);
			}else{
				String sex="女性";
				session.put("sex",sex);
			}
			result = SUCCESS;
			return result;
		}

		result = ERROR;
		return result;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
