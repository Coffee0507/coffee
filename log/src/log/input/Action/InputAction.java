package log.input.Action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class InputAction extends ActionSupport implements SessionAware {

	private Map<String,Object> session;
	private String log;


	public String execute(){
		System.out.println(log);
	String result = ERROR;
	result = SUCCESS;
	return result;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String getLog() {
		return log;
	}

	public void setLog(String log) {
		this.log = log;
	}


}
