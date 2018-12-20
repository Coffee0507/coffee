package user;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

	@RequestMapping("/")
	public String user(Model model) {
		model.addAttribute("hello", "hello");
		return "world";
	}

}
