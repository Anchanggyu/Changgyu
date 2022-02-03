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
<title>Insert title here</title>
</head>
<body>
<!-- 로그인 처리 기능 -->
<%
	//로그인을 처리하는 화면
	String id = null;
	if (session.getAttribute("id") != null) {
		id = (String)session.getAttribute("id");
	}
	MemberDao memberdao = new MemberDao();
	int result = memberdao.login(member.getId(), member.getPw());
	
	if (result == 1) { // result에는 login메소드에서 반환한 값에 의해 결정된다 result가 1이면 성공적으로 로그인이 됫다는 정보
					   //로그인이 성공한다면 알림창이나오면 site첫화면으로 이동
		session.setAttribute("id", member.getId());
		out.println("<script>");
		out.println("location.href = '../index.jsp'");
		out.println("</script>");
	}
	else if (result == 0) {
		out.println("<script>");
		out.println("alert('비밀번호가 일치하지 않습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}
	else if (result == -1) {
		out.println("<script>");
		out.println("alert('아이디가 존재하지 않습니다.')");
		out.println("history.back()");
		out.println("</script>");
	} 
	else {
		out.println("<script>");
		out.println("alert('DB오류가 발생하였습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}
%>
</body>
</html>