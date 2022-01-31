package book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


//Resultset = select 결과저장
//PreparedStatment = statement를 상속받는 인터페이스로 SQL구문을 실행시키는 기능을 갖는 객체
public class BookDao {

	private Connection conn; //mysql 연결을 위한 Connection
	private ResultSet rs;
	
	public BookDao() {
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
	
	//현재 시간을 구하는 메소드
	public String getDate() {
		
		String sql = "select now()";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return ""; //DB 오류
	}
	
	//게시글 번호 얻어오는 메소드
	public int getNum() {
		
		String sql = "select bookID from book order by bookID desc";
		
		try { 
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1; //첫번째 게시글이 아니면 마지막 게시글 + 1
			}
			return 1;
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return -1;
	}
	
	//게시글 수 구하는 메소드
	public int getCount() {
		String SQL = "select count(*) from book";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {	
				return rs.getInt(1);
			}
		}catch(Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		return -1;
	}
	
	//글쓰기 메소드
	public int write(String bookTitle, String userID, String bookContent) {
		
		String sql = "insert into book values(?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNum());
			pstmt.setString(2, bookTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bookContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate(); // 반영된 레코드의 건수 = 1
			
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return -1;
	}
	
	//글목록 메소드
	public ArrayList<BookDto> getList(int pageNum){
		
		String sql = "select * from book where bookAvailable = 1 order by bookID desc limit 10 offset ?";
		
		ArrayList<BookDto> list = new ArrayList<BookDto>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (pageNum - 1) * 10);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BookDto book = new BookDto();
				book.setBookID(rs.getInt(1));
				book.setBookTitle(rs.getString(2));
				book.setUserID(rs.getString(3));
				book.setBookDate(rs.getString(4));
				book.setBookContent(rs.getString(5));
				book.setBookAvailable(rs.getInt(6));
				list.add(book);
			}
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return list;
	}
	
	//글목록 검색 메소드
	public ArrayList<BookDto> searchList(int pageNum, String search) {
		
		String sql = "select * from book where (bookTitle like ? or bookContent like ?) and bookAvailable = 1 order by bookID desc limit 10 offset ?";
		
		ArrayList<BookDto> list = new ArrayList<BookDto>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2, "%"+search+"%");
			pstmt.setInt(3, (pageNum - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BookDto book = new BookDto();
				book.setBookID(rs.getInt(1));
				book.setBookTitle(rs.getString(2));
				book.setUserID(rs.getString(3));
				book.setBookDate(rs.getString(4));
				book.setBookContent(rs.getString(5));
				book.setBookAvailable(rs.getInt(6));
				list.add(book);
			}
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return list;
	}
	
	//페이징 처리 메소드
	public boolean nextPage(int pageNum) {
			
		String sql = "select * from book where bookAvailable = 1 order by bookID desc limit 10 offset ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (pageNum - 1) * 10);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				return true;
			}
				
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
			
		return false; //DB오류
	}
	
	public boolean searchnextPage(int pageNum, String search) {
		
		String sql = "select * from book where (bookTitle like ? or bookContent like ?) and bookAvailable = 1 order by bookID desc limit 10 offset ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2, "%"+search+"%");
			pstmt.setInt(3, (pageNum - 1) * 10);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return false;
	}
	
	//글내용 메소드
	public BookDto getBookdto(int bookID) {
		
		String sql = "select * from book where bookID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bookID);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BookDto book = new BookDto();
				book.setBookID(rs.getInt(1));
				book.setBookTitle(rs.getString(2));
				book.setUserID(rs.getString(3));
				book.setBookDate(rs.getString(4));
				book.setBookContent(rs.getString(5));
				book.setBookAvailable(rs.getInt(6));
				return book;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//글수정 메소드
	public int bookupdate(int bookID, String bookTitle, String bookContent) {
		
		String sql = "update book set bookTitle = ?, bookContent = ? where bookID = ?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookTitle);
			pstmt.setString(2, bookContent);
			pstmt.setInt(3, bookID);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	//글삭제 메소드
	public int bookdelete(int bookID) {
		
		String sql = "update book set bookAvailable = 0 where bookID = ?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bookID);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		
		return -1;
	}
	
	
}
