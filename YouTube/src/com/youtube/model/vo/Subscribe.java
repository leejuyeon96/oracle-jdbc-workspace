package com.youtube.model.vo;

import java.util.Date;

public class Subscribe {
	private int subsCode;
    private Date subsDate;
    private Member member;
    private Channel channel;
	public Subscribe() {
		
	}
	public Subscribe(int subsCode, Date subsDate, Member member, Channel channel) {
		this.subsCode = subsCode;
		this.subsDate = subsDate;
		this.member = member;
		this.channel = channel;
	}
	@Override
	public String toString() {
		return "Subscribe [subsCode=" + subsCode + ", subsDate=" + subsDate + ", member=" + member + ", channel="
				+ channel + "]";
	}

    
}
