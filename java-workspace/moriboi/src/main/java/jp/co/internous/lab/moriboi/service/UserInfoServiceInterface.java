package jp.co.internous.lab.moriboi.service;

import java.util.List;

import jp.co.internous.lab.moriboi.response.UserInfoResponse;

public interface UserInfoServiceInterface {

	public List<UserInfoResponse> getUserInfo(String loginId, String loginPassword);
	
}
