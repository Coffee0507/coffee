package com.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.dao.AcountUpdateCompleteDAO;
import com.opensymphony.xwork2.ActionSupport;

public class AcountUpdateCompleteAction extends ActionSupport implements SessionAware {

	public Map<String, Object> session;
	private AcountUpdateCompleteDAO dao = new AcountUpdateCompleteDAO();
	private String result;

	public String execute() {

		if(session.get("sex").equals("男性")){
			session.put("sex", "1");
		}else if(session.get("sex").equals("2")){
			session.put("sex","2");
		};
		if(session.get("changeSex").equals("男性")){
			session.put("changeSex", "1");
		}else if(session.get("changeSex").equals("2")){
			session.put("changeSex","2");
		};
		change();


		result = SUCCESS;

		return result;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public void change(){
		dao.getUpdataInfo(session.get("changeName1").toString(), session.get("changeName2").toString(),
				session.get("changeBirthyear").toString(), session.get("changeBirthmonth").toString(),
				session.get("changeBirthday").toString(), session.get("changeSex").toString(),
				Integer.parseInt(session.get("id").toString()));

	}

}
