package com.example.demo.Controller;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.Interface.MySQLInterface;
import com.example.demo.dao.ControllerDAO;
import com.example.demo.dto.ControllerDTO;

public class InputMonitor {

	public Map<String, Object> session;

	private String id1 = "id1";
	private String name1 = "name1";
	private String age1 = "age1";
	private ControllerDAO dao;
	private ControllerDTO dto;

	public MySQLInterface MI;

	@RequestMapping("/")
	public void action() {

		dto = dao.getInfo();

		session.put("id", dto.getId());
		session.put("name", dto.getName());
		session.put("age", dto.getAge());

		System.out.println(id1 + name1 + age1);

	}

	public Map<String, Object> getSession(){
		return session;
	}

	public void setSession(Map<String,Object>session){
		this.session = session;
	}
}
