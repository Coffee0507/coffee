package app.web.developmentDiary;

import java.util.List;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.authentication.AuthenticationManager;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
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

//	@Autowired
//	private AuthenticationManager authManager;

//	@Autowired
//	private final Logger logger = LoggerFactory.getLogger(DevelopmentService.class);

	public DevelopmentDiaryModel login(DevelopmentDiaryModel model) {

		DevelopmentDiaryModel returnModel = new DevelopmentDiaryModel();

//		Authentication authentication = null;
//		try {
//			Authentication request = new UsernamePasswordAuthenticationToken(model.getId(), model.getPass());
//			authentication = authManager.authenticate(request);
//			SecurityContextHolder.getContext().setAuthentication(authentication);
//			DevelopmentDiaryModel sessionModel = (DevelopmentDiaryModel)authentication.getPrincipal();
//			returnModel.setId(sessionModel.getId());
//			returnModel.setPass(sessionModel.getPass());
//			returnModel.setFlg(true);
//		}catch(Exception e) {
//			logger.error(e.toString());
			returnModel.setInfoMessage(mes.message1("ログインID", "ログインパスワード"));
			returnModel.setId(model.getId());
			returnModel.setPass(model.getPass());
			returnModel.setFlg(false);
//		}


		List<DevelopmentDiaryModel> list = mapper.login(model.getId(), model.getPass());

		if(list.size() == 0) {
			model.setInfoMessage(mes.message1("ログインID", "ログインパスワード"));
		}else if(list.size() == 1 && list.get(0).getId() == model.getId() && list.get(0).getPass().equals(model.getPass())) {
			model.setFlg(true);
		}

		return model;
	}
}
