<%@page import="book.BookDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>
<%@ page import = "book.BookDao" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
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

	int bookID = 0;
	if (request.getParameter("bookID") != null) {
		bookID = Integer.parseInt(request.getParameter("bookID"));
	}
	
	BookDao bookdao = new BookDao();
	
	int result = bookdao.bookdelete(bookID); 
	
	if (result == -1) {
		out.println("<script>");
		out.println("alert('글 삭제중 오류가 발생했습니다.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('정상적으로 삭제 되었습니다.')");
		out.println("location.href = '../board.jsp'");
		out.println("</script>");
	}
%>
</body>
</html>