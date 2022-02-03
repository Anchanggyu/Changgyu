<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*" %>
<%@ page import = "member.MemberDao" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="member.MemberDto" scope="page"/>
<jsp:setProperty property="id" name="member"/>
<jsp:setProperty property="pw" name="member"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 처리</title>
</head>
<body>
<!-- 회원 탈퇴 기능 -->
<%
	String id = null;
	if (session.getAttribute("id") != null) {
		id = (String)session.getAttribute("id");
	}
	
	if(member.getId() == null || member.getPw() == null) {
		out.println("<script>");
		out.println("alert('빠짐 없이 입력해주세요.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		MemberDao memberdao = new MemberDao();
		
		int result = memberdao.userdelete(member.getId(), member.getPw());
		
		if (result == 1) {
			out.println("<script>");
			out.println("alert('탈퇴가 완료되었습니다.')");
			out.println("location.href = 'logout.jsp'");
			out.println("</script>");
		} else if (result == 0) {
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지않습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else if (result == -1) {
			out.println("<script>");
			out.println("alert('아이디가 일치하지 않습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else if (result == -2) {
			out.println("<script>");
			out.println("alert('DB오류가 발생하였습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
%>
</body>
</html>