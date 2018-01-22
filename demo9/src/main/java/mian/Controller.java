package mian;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



@RestController
public class Controller {

	@Autowired
	Inter face;

	@RequestMapping("/action")
		String action() {
		face.getJog();
		face.getRun();
		face.getWalk();

		return face.getRun() + face.getJog() + face.getWalk();
	}


}
