package com.example.controller;

import org.springframework.stereotype.Service;

@Service
public class demoService implements demoInterface {


	@Override
	public String getRun() {
		String msg = "走る";
		System.out.println(msg);
		return msg;
	}

	@Override
	public String getWalk() {
		String msg = "歩く";
		System.out.println(msg);
		return msg;

	}

	@Override
	public String getJog() {
		String msg = "ジョギング";
		System.out.println(msg);
		return msg;

	}

}
