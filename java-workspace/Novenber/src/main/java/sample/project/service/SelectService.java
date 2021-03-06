package sample.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sample.project.entity.UserInfo;
import sample.project.repository.UserInfoRepository;

@Service
public class SelectService {
	@Autowired
	private UserInfoRepository userInfoRepository;

	public List<UserInfo> login(int loginId, String loginName, String loginPass) {
		List<UserInfo> list = userInfoRepository.login(loginId, loginName, loginPass);
		System.out.println(list);
		return list;
	}



}
