package app.web.developmentDiary;

import java.util.List;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import app.web.base.Message;
import app.web.mapper.DevelopmentDiaryMapper;

@Service
@Transactional
public class DevelopmentService {

	@Autowired
	private DevelopmentDiaryMapper mapper;

	@Autowired
	private Message mes;

//	@Autowired
//	private final Logger logger = LoggerFactory.getLogger(DevelopmentService.class);

	public DevelopmentDiaryModel login(DevelopmentDiaryModel model) {

		DevelopmentDiaryModel returnModel = new DevelopmentDiaryModel();


		List<DevelopmentDiaryModel> list = mapper.login(model.getId(), model.getPass());

		if(list.size() == 0) {
			System.out.println("DevelopmentServiceのデータベース接続失敗");
			returnModel.setInfoMessage(mes.message1("ログインID", "ログインパスワード"));
		}else {
			System.out.println("DevelopmentServiceのデータベース接続成功");
			returnModel.setFlg(true);
		}

		return returnModel;
	}
}
