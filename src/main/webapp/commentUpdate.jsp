<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "comment.CommentDto" %>
<%@ page import = "comment.CommentDao" %>
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
		id = (String) session.getAttribute("id");
	}
	
	int bookID = 0;
	if (request.getParameter("bookID") != null) {
		bookID = Integer.parseInt(request.getParameter("bookID"));
	}

%>


<div class="container" align="center">
		<div class="col-lg-10">
			<div class="jumbotron" style="padding-top: 1px;">				
				<h3><br>댓글수정창</h3>
				<form name = c_commentUpdate>
					<input type="text" id="update" style="width:400px;height:50px;" maxlength=1024>
					<input type="button" value="수정">
					<br><br>
				</form>
			</div>
		</div>
	</div>
</body>
</html>