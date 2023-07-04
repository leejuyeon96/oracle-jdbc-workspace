package com.kh.model.vo;

/* 모델로 썼던게 VO 로 간다
 * VO(VALUE OBJECT) / DTO(DATA TRANSFER OBJECT)
 * 
 * */

public class Member {

	private String id;
	private String password;
	private String name;
	
	public Member() {}
	public Member(String id, String password, String name) {
		this.id = id;
		this.password = password;
		this.name = name;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "Member [id=" + id + ", password=" + password + ", name=" + name + "]";
	}

}