<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
	
	int commentID = 0;
	if (request.getParameter("commentID") != null) {
		commentID = Integer.parseInt(request.getParameter("commentID"));
	}

	CommentDao commentdao = new CommentDao();
	String commentText = commentdao.getUpdateCommnet(commentID);
%>


<div class="container" align="center">
		<div class="col-lg-10">
			<div class="jumbotron" style="padding-top: 1px;">				
				<h3><br>댓글수정창</h3>
				<form name = c_commentUpdate>
					<input type="text" id="update" style="width:400px;height:50px;" maxlength=1024 value="<%= commentText %>">
					<input type="button" onclick="send(<%=bookID %>, <%=commentID %>)" value="수정">
					<br><br>
				</form>
			</div>
		</div>
	</div>
</body>
<script>
	function send(bbsID, commentID){
		var sb;
		var commentText = document.c_commentUpdate.update.value;
		sb = "function/commentupdatepro.jsp?&bookID="+bookID+"&commentID="+commentID+"&commentText="+commentText;
		window.opener.location.href= sb;
		window.close();
	}
</script>
</html>