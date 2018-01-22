package com.example.demo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController // (1)
public class Demo1Application {
	@RequestMapping("/hello") // (2)
	public String hello() {
		return "Hello World !!";
	}
}