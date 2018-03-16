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

	@Override
	public void setSession(Map<String, Object> session) {
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

}