package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

import config.ServerInfo;

public class BookDAO implements BookDAOTemplate {
	
	private Properties p = new Properties();
	
	public BookDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			try {
				Class.forName(ServerInfo.DRIVER_NAME);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		 catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}

	@Override
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		if(st!=null) st.close();
		if(conn!=null)conn.close();
	}
	

	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
	if(rs!=null) rs.close();
	closeAll(st, conn);
	}

	@Override
	public ArrayList<Book> printBookAll() throws SQLException {
		//SQL 문 : SELECT, 테이블 : TB_BOOK
		//ArrayList에 추가할 때 add 메서드
		//rs.getString("bk_title"); // bkTitle (X)
		
		return null;
	}

	@Override
	public int registerBook(Book book) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerBook"));
		st.setInt(1, book.getBkNo());
		st.setString(2, book.getBkTitle());
		st.setString(3, book.getBkAuthor());
		
		int result = st.executeUpdate();
		if(result ==1) {
			System.out.println(book.getBkTitle()+ "추가!");
		}
		
		return result;
	}

	@Override
	public int sellBook(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("sellBook"));
		st.setInt(1, no);
		st.executeUpdate();
		
		//책 삭제! delete!
		 
		return 0;
	}

	@Override
	public int registerMember(Member member) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		st.setInt(1, get.MemberNo());
		return 0;
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		st.setString(1, getId());
		return null;
	}

	@Override
	public int deleteMember(String id, String password) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteMember"));
		st.setString(1, id);
		st.setString(2, password);
		int result = st.executeUpdate();
		closeAll(st, conn);
		
		
		//update - status를 Y로!
		//status가 n이면 회원유지 y면 회원 탈퇴 n이 기본값!<--회원유지
		return result;
	}

	@Override
	public int rentBook(Rent rent) throws SQLException {
		// 책 대여 INSERT ~~TB_RENT
		return 0;
	}

	@Override
	public int deleteRent(int no) throws SQLException {
		return 0;
	}

	@Override
	public ArrayList<Rent> printRentBook(String id) throws SQLException {
	//sql문 join 필요! 테이블 다 엮어야 됨 
	//이유 : rent_no, rent_date, bk_title, bk_author
	//where : membe_id 가지고 가져오니까
	//while 문 안에서! Rent rent = new Rent();
	//setter 사용!! 
	//rent.setBook(new Book(rs.getString("bk_title"), rs.getString("bk_author")));
		return null;
	}

	
}
