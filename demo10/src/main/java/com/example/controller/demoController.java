package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class demoController {

	@Autowired
	demoInterface fa;

	@RequestMapping("/action")
	String action() {
		fa.getRun();
		fa.getWalk();
		fa.getJog();
		return fa.getRun() + "\r\n" + fa.getWalk() + "\r\n" + fa.getJog();
	}


}