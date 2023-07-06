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
		return DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		
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
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printBookAll"));
		
		
		ArrayList<Book> bookList = new ArrayList<>();
		ResultSet rs = st.executeQuery();
		
		while(rs.next()) {
			bookList.add(new Book(rs.getInt("bk_no"), rs.getString("bk_title"), rs.getString("bk_author")));
		}
		closeAll(rs,st, conn);
		return bookList;
	}

	@Override
	public int registerBook(Book book) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerBook"));
		
		st.setString(1, book.getBkTitle());
		st.setString(2, book.getBkAuthor());
		
		int result = st.executeUpdate();
		closeAll(st, conn);
				
		return result;
	}

	@Override
	public int sellBook(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("sellBook"));
		st.setInt(1, no);
		int result = st.executeUpdate();
		closeAll(st, conn);
		
		//책 삭제! delete!
		 
		return result;
	}

	@Override
	public int registerMember(Member member) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPwd());
		st.setString(3, member.getMemberName());
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		st.setString(1, id);
		st.setString(2, password);
		
		ResultSet rs = st.executeQuery();
		
		if(rs.next()) {
			Member member = new Member();
			
			member.setMemberNo(rs.getInt("member_no"));
			member.setMemberId(rs.getString("member_id"));
			member.setMemberPwd(rs.getString("member_pwd"));
			member.setMemberName(rs.getString("member_name"));
			member.setStatus(rs.getString("status").charAt(0));
			member.setEnrollDate(rs.getDate("enroll_date"));
			return member;
		}
		closeAll(rs, st, conn);
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
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("rentBook"));
		st.setInt(1, rent.getMember().getMemberNo());
		st.setInt(2, rent.getBook().getBkNo());
		
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public int deleteRent(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteRent"));
		st.setInt(1, no);
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public ArrayList<Rent> printRentBook(String id) throws SQLException {
	//sql문 join 필요! 테이블 다 엮어야 됨 
	//이유 : rent_no, rent_date, bk_title, bk_author
	//where : membe_id 가지고 가져오니까
	//while 문 안에서! Rent rent = new Rent();
	//setter 사용!! 
	//rent.setBook(new Book(rs.getString("bk_title"), rs.getString("bk_author")));
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printRentBook"));
		st.setString(1, id);
		ResultSet rs = st.executeQuery();
		ArrayList<Rent> rentList = new ArrayList<>();
		
		while(rs.next()) {
			Rent rent = new Rent();
			rent.setRentNo(rs.getInt("rent_no"));
			rent.setRentDate(rs.getDate("rent_date"));
			rent.setBook(new Book(rs.getString("bk_title"), rs.getString("bk_author")));
			rentList.add(rent);
			
		}
		closeAll(rs, st, conn);
		
		return rentList;
	}

	
}
