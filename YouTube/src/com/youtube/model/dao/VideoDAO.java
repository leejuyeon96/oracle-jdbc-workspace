package com.youtube.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.youtube.model.vo.Category;
import com.youtube.model.vo.Video;

import config.ServerInfo;

public class VideoDAO implements VideoDAOTemplate{

	private Properties p = new Properties();

	@Override
	public Connection getConnect() throws SQLException {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			try {
				Class.forName(ServerInfo.DRIVER_NAME);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return null;
	}

	@Override
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();
		conn.close();
	}

	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		rs.close();
		closeAll(st, conn);
		
	}

	@Override
	public int addVideo(Video video) throws SQLException {
		return 0;
	}

	@Override
	public int updateVideo(Video video) throws SQLException {
		return 0;
	}

	@Override
	public ArrayList<Video> videoAllList() throws SQLException {
		return null;
	}

	@Override
	public ArrayList<Video> channelVideoList(int channelCode) throws SQLException {
		return null;
	}

	@Override
	public Video viewVideo(int videoCode) throws SQLException {
		return null;
	}

	@Override
	public ArrayList<Category> categoryList() throws SQLException {
		return null;
	}

}
