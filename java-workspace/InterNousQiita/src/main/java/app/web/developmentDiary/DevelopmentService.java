package app.web.developmentDiary;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import app.message.Message;
import app.web.mapper.DevelopmentDiaryMapper;

@Service
@Transactional
public class DevelopmentService {

	@Autowired
	private DevelopmentDiaryMapper mapper;

	@Autowired
	private Message mes;

	public DevelopmentDiaryModel login(DevelopmentDiaryModel model) {

		List<DevelopmentDiaryModel> list = mapper.login(model.getId(), model.getPass());

		if(list.size() == 0) {
			model.setInfoMessage(mes.message1("ログインID", "ログインパスワード"));
		}else if(list.size() == 1 && list.get(0).getId() == model.getId() && list.get(0).getPass().equals(model.getPass())) {
			model.setFlg(true);
		}

		return model;
	}
}
