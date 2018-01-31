package com.internousdev.service;

import java.sql.SQLException;

import com.internousdev.dao.SecondDAO;
import com.internousdev.dto.SecondDTO;

public class SecondService {

	private SecondDAO dao = new SecondDAO();
	private SecondDTO dto = new SecondDTO();
	boolean flg = false;

	public boolean action(String id, String pass) throws SQLException {
		System.out.println(id);
		System.out.println(pass);
		dto = dao.info(id, pass);
		if (id.equals(dto.getId())) {
			if (pass.equals(dto.getPass())) {
				flg = true;
			}
		}
		return flg;
	}
}
