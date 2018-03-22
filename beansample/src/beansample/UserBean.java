/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beansample;

import java.io.Serializable;

/**
 * MVCモデル
 * M (モデル)
 */
public class UserBean implements Serializable {
	private static final long serialVersionUID = 1L;

	private String id_; // ID
	private String name_; // 名前
	private int age_; // 年齢
	private int auth_; // 権限(管理者権限:1 一般権限:0)

	// constructor
	public UserBean() {
		this.id_ = "";
		this.id_ = "";
		this.age_ = -1;
		this.auth_ = -1;
	}

	public UserBean(String id, String name, int age, int auth) {
		this.id_ = id;
		this.name_ = name;
		this.age_ = age;
		this.auth_ = auth;

	}

	// id
	public void setId(String id) {
		this.id_ = id;
	}

	public String getId() {
		return this.id_;
	}

	// name
	public void setName(String name) {
		this.name_ = name;
	}

	public String getName() {
		return this.name_;
	}

	// age
	public void setAge(int age) {
		this.age_ = age;
	}

	public int getAge() {
		return this.age_;
	}

	// auth
	public void setAuth(int auth) {
		this.auth_ = auth;
	}

	public int getAuth() {
		return this.auth_;
	}
}