package jp.ssie.syakyou.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jp.ssie.syakyou.form.LoginForm;
import jp.ssie.syakyou.model.User;
import jp.ssie.syakyou.repository.UserRepository;
import jp.ssie.syakyou.validation.GroupOrder;

@Controller
public class LoginController {

	@Autowired
	private UserRepository userRep;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		return "index";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model,@Validated(GroupOrder.class) @ModelAttribute("loginForm") LoginForm loginForm,BindingResult result) {
		if(result.hasErrors()) {
			return "index";
		}

		List<User> userList = userRep.findById(loginForm.getUserId());

		if(userList.size()>0) {
			model.addAttribute("username",userList.get(0).getName());
			model.addAttribute("departmentName",userList.get(0).getDepartment().getName());
			System.out.println(userList.get(0).getName());
			return "top";
		}else {
			return "index";
		}
	}
}
