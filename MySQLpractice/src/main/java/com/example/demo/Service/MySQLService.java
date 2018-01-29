package com.example.demo.Service;

import org.springframework.stereotype.Component;

import com.example.demo.Interface.MySQLInterface;

@Component
public class MySQLService implements MySQLInterface {

	@Override
	public void getAction(String name1, String age1) {
		System.out.println("MySQLService");
	}

}
