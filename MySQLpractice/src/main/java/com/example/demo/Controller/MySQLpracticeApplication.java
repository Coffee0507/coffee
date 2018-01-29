package com.example.demo.Controller;

import org.springframework.boot.SpringApplication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MySQLpracticeApplication {

	@RequestMapping("/hello")
	public String hello(Model model) {
		model.addAttribute("hello", "Helloworld!");
		return "home";
	}

	public static void main(String[] args) {
		SpringApplication.run(MySQLpracticeApplication.class, args);
	}
}
