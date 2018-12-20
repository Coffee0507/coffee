package jp.co.internous.lab.moriboi.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class UserInfoResponse {
	
	private int id;
	
	private String loginId;
	
	private String loginPassword;
	
	private String userName;

}
