<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "comment.CommentDto"%>
<%@ page import = "comment.CommentDao"%>
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
	
	String commentText = null;
	if (request.getParameter("commentText") != null) {
		commentText = request.getParameter("commentText");
	}
	
	if (commentText == null) {
		out.println("<script>");
		out.println("alert('빈 칸을 모두 입력해주세요.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		CommentDao commentdao = new CommentDao();
		int result = commentdao.update(commentID, commentText);
		
		if (result == -1) {
			out.println("<script>");
			out.println("alert('댓글 수정이 실패하엿습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('댓글이 수정되었습니다.')");
			out.println("location.href=document.referrer;");
			out.println("</script>");
		}
	}
%>
</body>
</html>