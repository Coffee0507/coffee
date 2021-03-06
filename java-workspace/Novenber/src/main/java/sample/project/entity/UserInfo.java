package sample.project.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="userInfo")
public class UserInfo {

	@Id
	@Column(name="id", nullable=false)
	private int loginId;
	@Column(name="name")
	private String loginName;
	@Column(name="password")
	private String loginPass;
//	@Column(name="insdate")
//	private Date insDate;
//	@Column(name="insid")
//	private String insId;
//	@Column(name="upddate")
//	private Date updDate;
//	@Column(name="updid")
//	private String updId;



	public int getLoginId() {
		return loginId;
	}
	public void setLoginId(int loginId) {
		this.loginId = loginId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getLoginPass() {
		return loginPass;
	}
	public void setLoginPass(String loginPass) {
		this.loginPass = loginPass;
	}
//	public Date getInsDate() {
//		return insDate;
//	}
//	public void setInsDate(Date insDate) {
//		this.insDate = insDate;
//	}
//	public String getInsId() {
//		return insId;
//	}
//	public void setInsId(String insId) {
//		this.insId = insId;
//	}
//	public Date getUpdaDate() {
//		return updDate;
//	}
//	public void setUpdaDate(Date updDate) {
//		this.updDate = updDate;
//	}
//	public String getUpdId() {
//		return updId;
//	}
//	public void setUpdId(String updId) {
//		this.updId = updId;
//	}


}
