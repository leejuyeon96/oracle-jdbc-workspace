package com.youtube.model.vo;

import java.util.Date;

public class VideoComment {
	private int commentCode;
    private String commentDesc;
    private Date commentDate;
    private VideoComment videoComment;
    private Video video;
    private Member member;
	public VideoComment() {
		
	}
	public VideoComment(int commentCode, String commentDesc, Date commentDate, VideoComment videoComment, Video video,
			Member member) {
		
		this.commentCode = commentCode;
		this.commentDesc = commentDesc;
		this.commentDate = commentDate;
		this.videoComment = videoComment;
		this.video = video;
		this.member = member;
	}
	@Override
	public String toString() {
		return "VideoComment [commentCode=" + commentCode + ", commentDesc=" + commentDesc + ", commentDate="
				+ commentDate + ", videoComment=" + videoComment + ", video=" + video + ", member=" + member + "]";
	}

}
