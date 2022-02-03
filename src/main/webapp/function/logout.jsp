<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 로그아웃 기능 -->
<%
	//세션에 저장된 정보를 날림
	//그렇게 되면 세션에 저장된 id값이 null이 되면서 로그아웃 기능
	session.invalidate();
%>

<script>
	location.href = '../index.jsp';
</script>

</body>
</html>