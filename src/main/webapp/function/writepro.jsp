<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>
<%@ page import = "book.BookDao" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id = "book" class = "book.BookDto" scope = "page" />
<jsp:setProperty property = "bookTitle" name = "book" />
<jsp:setProperty property = "bookContent" name = "book" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = null;
	if (session.getAttribute("id") != null) {
		id = (String)session.getAttribute("id");
	}
	if (book.getBookTitle() == null || book.getBookContent() == null) {
		out.println("<script>");
		out.println("alert('빠짐 없이 작성 해주세요')");
		out.println("history.back()");
		out.println("</script>");
	} else { //정상 작동
		BookDao bookdao = new BookDao();
	
		int result = bookdao.write(book.getBookTitle(), id, book.getBookContent());
			
		if (result == -1) {
			out.println("<script>");
			out.println("alert('글쓰기에 실패하였습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('글이 작성되었습니다.')");
			out.println("location.href = '../board.jsp'");
			out.println("</script>");
			}
		}
%>
</body>
</html>