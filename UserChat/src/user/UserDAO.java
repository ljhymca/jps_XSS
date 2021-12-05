package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;




public class UserDAO {
	
	DataSource dataSource;
	
	public UserDAO() { //DB 접근
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/UserChat");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public int login(String userID, String userPassword) { //로그인 용 함수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // 결과값
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString("userPassword").equals(userPassword)) { //입력한 비밀번호와 DB 비밀번호 일치시
					return 1; //로그인 성공
				}
				return 2; //비밀번호 틀렸을때
			} else {
				return 0; //해당 사용자가 존재하지 않음
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally { //모든 리소스 종료
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
	public int registerCheck(String userID) { //회원가입 아이디  중복체크
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // 결과값
			rs = pstmt.executeQuery();
			if (rs.next() || userID.equals("")) { // 겹치거나 공백일 때
				return 0; //이미 존재하는 회원
			} else {
				return 1; // 가입 가능
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally { //모든 리소스 종료
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
	
	public int register(String userID, String userPassword, String userName, String userAge, String userGender, String userEmail, String userProfile) { //회원가입 아이디  중복체크
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setInt(4, Integer.parseInt(userAge));
			pstmt.setString(5, userGender);
			pstmt.setString(6, userEmail);
			pstmt.setString(7, userProfile);
			rs = pstmt.executeQuery();
			if (rs.next() || userID.equals("")) { // 겹치거나 공백일 때
				return 0; //이미 존재하는 회원
			} else {
				return 1; // 가입 가능
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally { //모든 리소스 종료
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}

}






