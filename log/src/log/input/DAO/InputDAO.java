package log.input.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import log.input.DTO.InputDTO;
import log.input.Util.DBConnector;

public class InputDAO {

	private DBConnector db = new DBConnector();
	private Connection con = db.getConnection();
	private ArrayList<InputDTO> dtoList = new ArrayList<InputDTO>();

	public void logInsert(String log) {

		String sql = "insert into log(log) value(?)";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, log);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public ArrayList<InputDTO> selectLog() {

		String sql = "select * from log";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				InputDTO dto = new InputDTO();
				dto.setLog("log");
				dtoList.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dtoList;
	}

}
