package jp.co.internous.lab.moriboi.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="user_info")
@Getter
@Setter
public class UserInfoEntity {
	
	@Id
	@Column(name="id", columnDefinition="auto_increment")
	private int id;
	
	@Column(name="login_id", columnDefinition="varchar(16)", nullable=false)
	private String loginId;
	
	@Column(name="login_password", columnDefinition="varchar(16)", nullable=false)
	private String loginPassword;
	
	@Column(name="user_name", columnDefinition="varchar(50)", nullable=false)
	private String userName;

}
