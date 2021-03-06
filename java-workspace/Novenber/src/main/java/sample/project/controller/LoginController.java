package sample.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import sample.project.entity.UserInfo;
import sample.project.form.LoginForm;
import sample.project.service.SelectService;

@Controller
public class LoginController {

	@Autowired
	SelectService selectService;

	@RequestMapping(value="/")
	public String nothing() {
		return "index";
	}

	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@ModelAttribute("loginForm")LoginForm loginForm, BindingResult result, Model model) {

		if(result.hasErrors()) {
			model.addAttribute("errorMessage","入力値にエラーがあります");
			return "index";
		}

		List<UserInfo> list = selectService.login(loginForm.getLoginId(), loginForm.getLoginName(), loginForm.getLoginPass());

		if(list.size() != 0) {
			model.addAttribute("resultList",list);
		}
		return "index";
	}
}
