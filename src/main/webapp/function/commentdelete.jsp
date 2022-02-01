<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "comment.CommentDto" %>
<%@ page import = "comment.CommentDao" %>
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
	
	int commentID = 0;
	if (request.getParameter("commentID") != null) {
		commentID = Integer.parseInt(request.getParameter("commentID"));
	}
	
	CommentDao commentdao = new CommentDao();
	
	int result = commentdao.delete(commentID);
	
	if (result == -1) {
		out.println("<script>");
		out.println("alert('댓글 삭제에 실패하였습니다.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('댓글이 삭제되었습니다.')");
		out.println("location.href=document.referrer;"); //이전페이지의 url 값으로 이동
		out.println("</script>");
	}
%>
</body>
</html>