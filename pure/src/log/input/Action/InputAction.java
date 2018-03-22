package log.input.Action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import log.input.DAO.InputDAO;
import log.input.DTO.InputDTO;

public class InputAction{

	private Map<String, Object> session;
	private String log = null;
	private InputDAO dao = new InputDAO();
	private InputDTO dto = new InputDTO();
	private List<InputDTO> dtoList = new ArrayList<InputDTO>();
	private HttpServletRequest request;
	private HttpServletResponse response;

	public void execute(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{

		if (log==null) {
			request.setAttribute("log","エラーです");

		}else{
			dao.logInsert(log);
			dtoList = dao.selectLog();

			request.setAttribute("log",dtoList);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/logOutput.jsp");

				dispatcher.forward(request, response);

		}

	}

	public String getLog() {
		return log;
	}

	public void setLog(String log) {
		this.log = log;
	}

}
