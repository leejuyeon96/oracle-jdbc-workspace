package com.youtube.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.youtube.model.vo.Channel;

import config.ServerInfo;

public class ChannelDAO implements ChannelDAOTemplate{
	private Properties p = new Properties();

	@Override
	public Connection getConnect() throws SQLException {
		
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (ClassNotFoundException e) {
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
	public int addChannel(Channel channel) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("addChannel"));
		
		st.setString(1, channel.getChannelName());
		st.setString(2, channel.getMember().getMemberId());
		
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public int updateChannel(Channel channel) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("updateChannel"));
		
		st.setString(1, channel.getChannelName());
		st.setString(2, channel.getMember().getMemberId());
		return 0;
	}

	@Override
	public int deleteChannel(int channelCode) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteChannel"));
		
		st.setInt(channelCode, channelCode);
		
		return 0;
	}

	@Override
	public Channel myChannel(String memberId) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("myChannel"));
		
		st.setString(1, memberId);
		ResultSet rs= st.executeQuery();
		Channel channel = null;
		if(rs.next()) {
			channel.setChannelCode(rs.getInt("channel_code"));
			channel.setChannelName(rs.getString("channel_name"));
		}
		closeAll(st, conn);
		return channel;
	}

}
