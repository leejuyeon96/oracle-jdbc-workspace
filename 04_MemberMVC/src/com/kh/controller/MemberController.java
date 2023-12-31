package com.kh.controller;

import java.sql.SQLException;

import com.kh.model.dao.MemberDAO;
import com.kh.model.vo.Member;

public class MemberController {

	private MemberDAO dao = new MemberDAO();
	
	public boolean joinMembership(Member m) {

		// id가 없다면 회원가입 후 true 반환
		// 없다면 false 값 반환
		try {
			if (dao.getMember(m.getId()) == null) {
				dao.registerMember(m);
				return true;
} 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public String login(String id, String password) {

		// 로그인 성공하면 이름 반환
		// 실패하면 null 반환
		Member m = new Member();
		m.setId(id);
		m.setPassword(password);
		try {
			Member result = dao.login(m);
			if (result!=null) {
	            return result.getName();}
		 
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
						
		return null;		
	}
		
	public boolean changePassword(String id, String oldPw, String newPw) {

		// 로그인 했을 때 null이 아닌 경우
		// 비밀번호 변경 후 true 반환, 아니라면 false 반환
		Member m = new Member();
		m.setId(id);
		m.setPassword(oldPw);
		
		Member result;
		
		
		try {
			result = dao.login(m);
			
			if (result !=null) {
				result.setPassword(newPw);
	            dao.updatePassword(result);
	            return true;
	        } 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	    }
	
	public void changeName(String id, String name) {

		// 이름 변경!
		Member m = new Member();
		m.setId(id);
		m.setName(name);
		
		try {
			dao.updateName(m);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	  }

	
		
	}


