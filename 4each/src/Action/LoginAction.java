package Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import DAO.LoginDAO;
import DTO.LoginDTO;

public class LoginAction extends ActionSupport implements SessionAware {

	private Map<String, Object> session;
	private String Id;
	private String Pass;
	private String result;
	private LoginDAO dao = new LoginDAO();
	private LoginDTO dto = new LoginDTO();

	public String execute() {
		String str = "fnacjkbdcn-/ :@`{~";
		if(str.matches("^[a-zA-Z0-9 -/:-@\\[-\\`\\{-\\~]+$")){
		     System.out.println("半角英数記号で入力してください。");
		}

		result = ERROR;

		dto = dao.select(Id, Pass);
		System.out.println(Id+"*");
		System.out.println(dto.getId()+"a");
		System.out.println(Id);

		if(dto.getId().equals(Id)&&dto.getPass().equals(Pass)){
			result = SUCCESS;
		}

		return result;



	}

	public void setSession1(Map<String, Object> session) {
		this.session = session;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}

	public String getPass() {
		return Pass;
	}

	public void setPass(String pass) {
		Pass = pass;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		// TODO 自動生成されたメソッド・スタブ

	}

}
