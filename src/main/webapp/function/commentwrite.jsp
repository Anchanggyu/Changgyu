<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>
<%@ page import = "comment.CommentDao" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="comment" class = "comment.CommentDto" scope = "page" />
<jsp:setProperty property = "commentText" name = "comment" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 댓글 작성 기능-->
<%
	String id = null;
	if (session.getAttribute("id") != null) {
		id = (String)session.getAttribute("id");
	}
	
	if (id == null) {
		out.println("<script>");
		out.println("alert('로그인후 이용해주세요')");
		out.println("history.back()");
		out.println("</script>");
	}
	
	else {
		int bookID = 0;
		if(request.getParameter("bookID") != null) {
			bookID = Integer.parseInt(request.getParameter("bookID"));
		}
		
		if(comment.getCommentText() == null) {
			out.println("<script>");
			out.println("alert('빠짐 없이 작성해주세요.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			CommentDao commentdao = new CommentDao();
			int commentID = commentdao.write(bookID, id, comment.getCommentText());
			if (commentID == -1) {
				out.println("<script>");
				out.println("alert('글쓰기에 실패하였습니다.')");
				out.println("history.back()");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('댓글이 작성되었습니다.')");
				out.println("location.href=document.referrer;");
				out.println("</script>");
			}
		} 
		
		
	}
%>
</body>
</html>