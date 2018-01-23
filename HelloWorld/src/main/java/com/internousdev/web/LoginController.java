package com.internousdev.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.internousdev.validation.GroupOrder;

@Controller
public class LoginController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		return "index";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model,@Validated(GroupOrder.class)@ModelAttribute("loginForm") LoginForm loginForm,BindingResult result) {
		if(result.hasErrors()){
			return "index";
		}
		System.out.println(loginForm.getLoginName());

		model.addAttribute("loginName", loginForm.getLoginName());
		return "top";
	}


}
