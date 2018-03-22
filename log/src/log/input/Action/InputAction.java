package log.input.Action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.SessionAware;

import log.input.DAO.InputDAO;
import log.input.DTO.InputDTO;

public class InputAction extends HttpServlet implements SessionAware {

	private Map<String, Object> session;
	private String log = null;
	private InputDAO dao = new InputDAO();
	private ArrayList<InputDTO> dtoList = new ArrayList<InputDTO>();
	private HttpServletRequest request;
	private HttpServletResponse response;


	public String execute() throws ServletException, IOException{

		doPost(request);
		return log;

	}

	public void doPost(HttpServletRequest request) throws ServletException, IOException{

		System.out.println(request);

	if (log==null) {
			request.setAttribute("log","エラーです");

			System.out.println("mmm");
		}else{
			dao.logInsert(log);
			dtoList = dao.selectLog();

			System.out.println(dtoList);


		}
	}

	public List<InputDTO> getDtoList() {
		return dtoList;
	}

	public void setDtoList(ArrayList<InputDTO> dtoList) {
		this.dtoList = dtoList;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
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
