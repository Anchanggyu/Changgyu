package book;

public class BookDto {

	private int bookID; // 글번호
	private String bookTitle; // 제목
	private String userID; // 작성자
	private String bookDate; // 작성일
	private String bookContent; // 내용  
	private int bookAvailable; // 글 존재유무
	
	public int getBookID() {
		return bookID;
	}
	public void setBookID(int bookID) {
		this.bookID = bookID;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public String getBookContent() {
		return bookContent;
	}
	public void setBookContent(String bookContent) {
		this.bookContent = bookContent;
	}
	public int getBookAvailable() {
		return bookAvailable;
	}
	public void setBookAvailable(int bookAvailable) {
		this.bookAvailable = bookAvailable;
	}
	
	
}
