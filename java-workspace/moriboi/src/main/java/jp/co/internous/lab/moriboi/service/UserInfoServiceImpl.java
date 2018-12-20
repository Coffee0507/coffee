package jp.co.internous.lab.moriboi.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jp.co.internous.lab.moriboi.entity.UserInfoEntity;
import jp.co.internous.lab.moriboi.repository.UserInfoRepository;
import jp.co.internous.lab.moriboi.response.UserInfoResponse;

@Service
public class UserInfoServiceImpl implements UserInfoServiceInterface {
	
	@Autowired
	private UserInfoRepository repository;
	
	private List<UserInfoResponse> userInfoList = new ArrayList<>();
	
	public List<UserInfoResponse> getUserInfo(String loginId, String loginPassword) {
		List<UserInfoEntity> entityList = repository.findByLoginIdAndLoginPassword(loginId, loginPassword);
		
		for (int i=0; entityList.size() > i; i++) {
			userInfoList.add(UserInfoResponse.builder()
					.id(entityList.get(i).getId())
					.loginId(entityList.get(i).getLoginId())
					.loginPassword(entityList.get(i).getLoginPassword())
					.userName(entityList.get(i).getUserName())
					.build());
		}
		
		return userInfoList;
	}

}
