package com.youtube.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.youtube.model.vo.CommentLike;
import com.youtube.model.vo.VideoComment;
import com.youtube.model.vo.VideoLike;

public interface CommentLikeDAOTemplate {

	Connection getConnect() throws SQLException;
	void closeAll(PreparedStatement st, Connection conn) throws SQLException;
	void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException;
	
	int addLike(VideoLike like) throws SQLException;
	int deleteLike(int likeCode) throws SQLException;
	
	int addComment(VideoComment comment) throws SQLException;
	int updateComment(VideoComment comment) throws SQLException;
	int deleteComment(int commentCode) throws SQLException;
	ArrayList<VideoComment> videocommentList(int videoCode) throws SQLException;
	
	//CommentLike
	//댓글 좋아요 추가, 댓글 좋아요 취소
	int addCommentLike(CommentLike like) throws SQLException;
	int deleteCommentLike(int likeCode) throws SQLException;
	
}




