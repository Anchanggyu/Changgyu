<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*" %>
<%@ page import = "member.MemberDao" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 자바빈 사용 -->
<jsp:useBean id="member" class="member.MemberDto" scope="page"/>
<jsp:setProperty property="id" name="member"/>
<jsp:setProperty property="pw" name="member"/>
<jsp:setProperty property="name" name="member"/>
<jsp:setProperty property="email" name="member"/>
<jsp:setProperty property="tel" name="member"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here </title>
</head>
<body>
<%
	//회원가입 폼에서 빈칸이 하나라도 존재할시 나오는 알림창
	if(member.getId() == null || member.getPw() == null || member.getName() == null || 
			member.getEmail() == null || member.getTel() == null) {
		out.println("<script>");
		out.println("alert('빠짐 없이 입력해주세요.')");
		out.println("history.back()");
		out.println("</script>");
	} else { // 빈칸이 없다면 else 부분 실행
		MemberDao memberdao = new MemberDao(); 
		int result = memberdao.join(member);
		
		if (result == -1) { // MemberDAO 에서 -1이 넘어온다면 INSERT에 값중 ID부분이 중복이면 나오는 알림창
			out.println("<script>");
			out.println("alert('이미 존재하는 아이디입니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else { // 정삭적으로 회원가입하게되면 나오는 알림창 가입을 하고나면 홈페이지에 첫화면으로 넘어간다
			out.println("<script>");
			out.println("alert('회워가입을 축하드립니다.')");
			out.println("location.href = '../login.jsp'");
			out.println("</script>");
		}
	}
%>
</body>
</html>