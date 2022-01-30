package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDao {
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//DB연결
	public MemberDao() {
		
		try {
			
			String dbURL = "jdbc:mysql://localhost:3306/crud?serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPW = "951753aa";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//회원 가입
	public int join(MemberDto member) {
		
		int result = -1;
		
		String sql = "insert into member values(?, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel()); //회원가입 정상작동 처리 부분
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return result; // db오류 or id중복
	}
	
	//로그인을 하는 메소드
	public int login(String id, String pw) {
		
		String sql = "select pw from member where id = ?";
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getString(1).equals(pw)) {
					return 1; //로그인 성공
				} else {
					return 0; //비밀번호 불일치
				}
			}
			return -1; // 아이디 존재x
			
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return -2;
	}
	
	//로그인 한 회원정보
	public MemberDto getMem(String id) {
		
		String sql = "select * from member where id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				MemberDto memberdto = new MemberDto();
				memberdto.setId(rs.getString(1));
				memberdto.setPw(rs.getString(2));
				memberdto.setName(rs.getString(3));
				memberdto.setEmail(rs.getString(4));
				memberdto.setTel(rs.getString(5));
				
				return memberdto;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//회원 정보수정
	public int userupdate(MemberDto member) {
		
		String sql = "update member set pw = ?, email = ?, tel = ? where id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getEmail());
			pstmt.setString(3, member.getTel());
			pstmt.setString(4, member.getId());
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
		
	}
	
	//회원탈퇴
	public int userdelete(String id, String pw) {
		
		String sql1 = "select pw from member where id = ?";
		String sql2 = "delete from member where id = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			conn.setAutoCommit(false);
			
			if(rs.next()) {
				if(rs.getString(1).equals(pw)) {
					pstmt = conn.prepareStatement(sql2);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					conn.commit();
					return 1; // 삭제 성공
				} else {
					return 0; // 비밀번호 다름
				}
			} else {
				return -1; // 아이디 불일치
			}
			
		} catch (Exception sqle) {
			try {
				conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {
				try{
					if ( pstmt != null ){ pstmt.close(); pstmt=null; }
					if ( conn != null ){ conn.close(); conn=null;    }
				}catch(Exception e){
					throw new RuntimeException(e.getMessage());
				}
			}
		}
		
		return -2; // DB오류
	}
}
