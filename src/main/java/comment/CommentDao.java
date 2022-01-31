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
}
