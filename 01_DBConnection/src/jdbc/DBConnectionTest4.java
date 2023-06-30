package jdbc;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import config.ServerInfo;

public class DBConnectionTest4 {
	
	public static final String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	public static final String USER = "kh";
	public static final String PASSWORD = "kh";
	
	/*
	 * 디비 서버에 대한 정보가 프로그램상에 하드코딩 되어져 있음!
	 * --> 해결책 : 별도의 모듈에 디비서버에 대한 정보를 뽑아내서 별도 처리
	 * */

	public static void main(String[] args) {

		//1. 드라이버 로딩
		try {
			
			Properties p = new Properties();
			try {
				p.load(new FileInputStream("src/config/jdbc.properties"));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
		//2. 디비 연결
		try {
			Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
			
			System.out.println("Connection...!!");
			Properties p = new Properties();
		
		//3. Statement 객체 생성 - UPDATE
			String query = p.getProperty("jdbc.sql.delete");
			PreparedStatement st = conn.prepareStatement(query);
			
		//4. 쿼리문 실행
			st.setString(1, "디자인팀");
			st.setInt(2, 1);
			
			int result = st.executeUpdate();
			System.out.println(result + "명 수정!");
		
		//결과가 잘 나오는지 확인 - SELECT
			query = p.getProperty("jdbc.sql.select");
			st = conn.prepareStatement(query);
			
			ResultSet rs = st.executeQuery();
			
			while(rs.next()) {
				String empId = rs.getString("emp_id");
				String empName = rs.getString("emp_name");
				String deptTitle = rs.getString("dept_title");
				
				System.out.println(empId + "/" + empName + "/" + deptTitle);	
						
			}
					
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
