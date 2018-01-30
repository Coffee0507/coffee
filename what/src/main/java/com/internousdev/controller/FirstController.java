package com.internousdev.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.internousdev.form.FirstForm;
import com.internousdev.form.SecondForm;
import com.internousdev.validation.GroupOrder;

@Controller
public class FirstController {

	@RequestMapping(value="/",method=RequestMethod.GET)
	public String index(Model model){
		return "index";
	}

	@RequestMapping(value = "/second", method = RequestMethod.POST)
	public String action(Model model, @Validated(GroupOrder.class)@ModelAttribute("firstForm") FirstForm firstForm,BindingResult result) {
		if(result.hasErrors()){
			return "index";
		}
		model.addAttribute("loginName",firstForm.getLoginName());
		model.addAttribute("loginPassword",firstForm.getLoginPassword());
		return "second";
	}

	@RequestMapping(value = "/third", method = RequestMethod.POST)
	public String action(Model model, @ModelAttribute("secondForm") SecondForm secondForm) {
		model.addAttribute("loginId",secondForm.getLoginId());
		return "third";
	}
}