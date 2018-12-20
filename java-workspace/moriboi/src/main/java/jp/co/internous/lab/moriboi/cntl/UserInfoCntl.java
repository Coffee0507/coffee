package jp.co.internous.lab.moriboi.cntl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jp.co.internous.lab.moriboi.response.UserInfoResponse;
import jp.co.internous.lab.moriboi.service.UserInfoServiceInterface;

@RestController
@RequestMapping("/loginApi/")
@CrossOrigin("http://localhost:3000")
public class UserInfoCntl {

	@Autowired
	private UserInfoServiceInterface service;

	@GetMapping(value="/login/{loginId}/{loginPassword}")
	public List<UserInfoResponse> doGetUserInfo(@PathVariable("loginId") String loginId, @PathVariable("loginPassword") String loginPassword) {
		return service.getUserInfo(loginId, loginPassword);
	}

}
