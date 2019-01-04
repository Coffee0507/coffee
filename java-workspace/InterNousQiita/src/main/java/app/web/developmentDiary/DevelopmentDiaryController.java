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
@CrossOrigin
@ResponseBody
public class DevelopmentDiaryController {

	@Autowired
	private DevelopmentService service;

	@RequestMapping(value="/login", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	public DevelopmentDiaryModel shop(@RequestBody DevelopmentDiaryModel model) {

		//serviceからuserNameとpassを取得
		DevelopmentDiaryModel returnModel =  service.login(model);

		return returnModel;
	}
}
