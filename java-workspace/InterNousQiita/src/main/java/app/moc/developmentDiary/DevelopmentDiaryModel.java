package app.moc.developmentDiary;

import java.util.List;

import app.web.base.BaseModel;

public class DevelopmentDiaryModel extends BaseModel{

	private int id;
	private String pass;
	private boolean flg;
	private List<DevelopmentDiaryModel> list;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public boolean isFlg() {
		return flg;
	}
	public void setFlg(boolean flg) {
		this.flg = flg;
	}
	public List<DevelopmentDiaryModel> getList() {
		return list;
	}
	public void setList(List<DevelopmentDiaryModel> list) {
		this.list = list;
	}

}
