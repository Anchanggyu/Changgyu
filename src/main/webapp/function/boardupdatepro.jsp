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
<jsp:useBean id = "book" class = "book.BookDto" scope = "page" />
<jsp:setProperty property = "bookTitle" name = "book" />
<jsp:setProperty property = "bookContent" name = "book" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
</head>
<body>
<!-- 게시글 수정 -->
<%
	String id = null;
	if (session.getAttribute("id") != null) {
		id = (String)session.getAttribute("id");
	}
	
	int bookID = 0;
	if (request.getParameter("bookID") != null) {
		bookID = Integer.parseInt(request.getParameter("bookID"));
	}
	
	BookDto bookdto = new BookDao().getBookdto(bookID);
	if(request.getParameter("bookTitle") == null || request.getParameter("bookContent") == null
			|| request.getParameter("bookTitle").equals("") || request.getParameter("bookContent").equals("")) {
			out.println("<script>");
			out.println("alert('빈 칸을 모두 입력해주세요.')");
			out.println("history.back()");
			out.println("</script>");
	} else {
		BookDao bookdao = new BookDao();
		
		int result = bookdao.bookupdate(bookID, request.getParameter("bookTitle"), request.getParameter("bookContent"));
			
		if(result == -1) {
			out.println("<script>");
			out.println("alert('수정 중 오류가 발생하였습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('수정이 완료되었습니다.')");
			out.println("location.href = '../board.jsp'");
			out.println("</script>");
		}
	}
%>
</body>
</html>