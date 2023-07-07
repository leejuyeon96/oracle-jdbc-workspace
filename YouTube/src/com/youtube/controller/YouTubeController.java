package com.youtube.controller;

import java.sql.SQLException;

import com.youtube.model.dao.ChannelDAO;
import com.youtube.model.dao.MemberDAO;
import com.youtube.model.vo.Channel;
import com.youtube.model.vo.Member;

public class YouTubeController {
	private Member member = new Member();
	private MemberDAO memberDao = new MemberDAO();
	private ChannelDAO channelDao = new ChannelDAO();

	public boolean register(Member member) {
		try {
			if(memberDao.register(member)==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public Member login(String id, String password) {
		try {
			member = memberDao.login(id, password);
			if(member != null) return member;
			else {
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
}
	public boolean addChannel(Channel channel) {
		
		
		channel.setMember(member);
		try {
			if(channelDao.addChannel(channel)==1) return true;
			else {}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return false;
	}






}

