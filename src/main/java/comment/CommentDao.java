package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDao {

	private Connection conn; //mysql 연결을 위한 Connection
	private ResultSet rs;
	
	public CommentDao() {
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
	
	//댓글 번호 구하는 메소드
	public int getNum() {
		
		String sql = "select commentID from comment order by commentID desc";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	//댓글 작성 메소드
	public int write(int bookID, String userID, String commentText) {
		String SQL = "INSERT INTO comment VALUES(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNum());
			pstmt.setInt(2, bookID);
			pstmt.setString(3, userID);
			pstmt.setString(4, commentText);
			pstmt.setInt(5, 1);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//댓글 목록 메소드
	public ArrayList<CommentDto> getList(int bookID) {
		
		String sql = "select * from comment where commentAvailable = 1 and bookID = ?  order by bookID desc";
		
		ArrayList<CommentDto> list = new ArrayList<CommentDto>();
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bookID);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				CommentDto comment = new CommentDto();
				comment.setCommentID(rs.getInt(1));
				comment.setBookID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setCommentText(rs.getString(4));
				comment.setCommentAvailable(rs.getInt(5));
				
				list.add(comment);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	public CommentDto getComment(int commentID) {
		
		String sql = "select * from comment where commentID = ? order by commentID desc";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentID);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				CommentDto commentdto = new CommentDto();
				commentdto.setCommentID(rs.getInt(1));
				commentdto.setBookID(rs.getInt(2));
				commentdto.setUserID(rs.getString(3));
				commentdto.setCommentText(rs.getString(4));
				commentdto.setCommentAvailable(rs.getInt(5));
				
				return commentdto;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String getUpdateCommnet (int commentID) {
		
		String sql = "select commentText from comment where commentID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	//댓글 수정 메소드
	public int update(int commentID, String commentText) {
		
		String sql = "update comment set commentText = ? where commentID like?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commentText);
			pstmt.setInt(2, commentID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	//댓글 삭제 메소드
	public int delete (int commentID) {
		
		String sql = "update comment set commentAvailable = 0 where commentID = ?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentID);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
}
