package jp.ssie.helloworld.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jp.ssie.helloworld.form.LoginForm;
import jp.ssie.helloworld.model.User;
import jp.ssie.helloworld.repository.UserRepository;
import jp.ssie.helloworld.validation.GroupOrder;

@Controller
public class LoginController {
	@Autowired
	private UserRepository userRep;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		return "index";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model, @Validated(GroupOrder.class) @ModelAttribute("loginForm") LoginForm loginForm,
			BindingResult result) {
		if (result.hasErrors()) {
			return "index";
		}


		List<User> userList = userRep.findAll();

		for (User user : userList) {
			if (user.getName().equals(loginForm.getLoginName())) {
				model.addAttribute("loginName", loginForm.getLoginName());
				return "top";
			}
		}
		return "index";
	}
}