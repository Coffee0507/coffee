package app.web.developmentDiary;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value="developmentDiary")
public class DevelopmentDiaryController {

	@Autowired
	private DevelopmentService service;


	@CrossOrigin
	@RequestMapping(value="/login", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public DevelopmentDiaryModel shop(@RequestBody DevelopmentDiaryModel model) {


			//serviceからidとpassを取得
		service.login(model);

		System.out.println(model.getId() + ":::" + model.getPass());

		return model;
	}
}
