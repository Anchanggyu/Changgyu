<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ page import = "book.BookDto" %>
<%@ page import = "book.BookDao" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>게시글 내용</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Montserrat:300,400,500,600,700" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Rapid - v4.7.0
  * Template URL: https://bootstrapmade.com/rapid-multipurpose-bootstrap-business-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  <style>
	a, a:hover {
		color : #000000;
		text-decoration: none;
	}
	</style>
  
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
	
	BookDto bookdto = new BookDao().getBookdto(bookID);
%>
	
  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center header-transparent">
    <div class="container d-flex align-items-center">

      <h1 class="logo me-auto"><a href="index.jsp">JSP 게시판</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto" href="index.jsp">Home</a></li>
          <li><a class="nav-link scrollto" href="index.jsp#about">About</a></li>
          <li><a class="nav-link scrollto active" href="board.jsp">자유게시판</a></li>
          <%
          		if(id != null) {
          			out.println("<script>");
					out.println("menu.style.display = 'visible'");
					out.println("</script>");
		   %>
          <li class="dropdown"><a href="#"><span>내 정보</span> <i class="bi bi-chevron-down"></i></a>
               <ul>
                 <li><a href="function/logout.jsp">로그아웃</a></li>
                 <li><a href="logininfo.jsp">회원정보</a></li>
                 <li><a href="memberdelete.jsp">회원탈퇴</a></li>
               </ul>
           </li>
          <%	
          		} else {
          			out.println("<script>");
    				out.println("menu.style.display = 'hidden'");
    				out.println("</script>");
    			}
       	  %>
       	  
       	  <%
        	if(id == null) {
          %>
          	<li class="dropdown"><a href="#"><span>더 보기</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
                  <li><a href="login.jsp">로그인</a></li>
                  <li><a href="signup.jsp">회원가입</a></li>
             </ul>
          </li>
          <%
        	} 
          %>
          
        </ul>
        
        
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->
    </div>
  </header><!-- End Header -->
 
  <!-- ======= freeBoard Section ======= -->
  <section id="hero" class="clearfix">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
	</script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous">
	</script> 
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous">
	</script> <br/><br/><br/>
	<div class = "container">
    	<div class = "row">
  			<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd;">
  				<thead>
  					<tr>
  						<th colspan = "3" style = "background-color : #eeeeee; text-align : center;">글 확인</th>
  					</tr>
  				</thead>
  				<tbody>
  					<tr>
  						<td style = "width : 20%;">제목</td>
  						<td colspan = "2"><%= bookdto.getBookTitle() %></td>	
  					</tr>
  					<tr>
  						<td>작성자</td>
  						<td colspan = "2"><%= bookdto.getUserID() %></td>	
  					</tr>
  					<tr>
  						<td>작성일</td>
  						<td colspan = "2"><%= bookdto.getBookDate().substring(0, 11) + bookdto.getBookDate().substring(11, 13) + "시" + bookdto.getBookDate().substring(14, 16)  + "분" %></td>	
  					</tr>
  					<tr>
  						<td>내용</td>
  						<td colspan = "2" style = "min-height : 200px; text-align : left;"><%= bookdto.getBookContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>	
  					</tr>
  				</tbody>
  			</table>	
  			<div class = "row">
  				<%
  					if (id != null && id.equals(bookdto.getUserID())){
  				%>
  				<div class="form-group col-lg-6 col-sm-12 text-lg-start" >
			  		<a href="boardupdate.jsp?bookID=<%= bookID %>"><button class = "btn btn-info" type = "button">수정</button></a>
	  				<a onclick = "return confirm('삭제하시겠습니까?')" href = "function/boarddeletepro.jsp?bookID=<%= bookID %>"><button class = "btn btn-danger float-right mr-1" type = "button">삭제</button></a>
			 	</div>
  				<div class="form-group col-lg-6 col-sm-12 text-lg-end">
					<a href="board.jsp"><button class = "btn btn-info" type = "button">목록</button></a>
			 	</div>
			 	<%
  					} else {
			 	%>
	  			<div class="form-group col-lg-12 text-lg-end">
	  				<a href="board.jsp"><button class = "btn btn-info" type = "button">목록</button></a>
	  			<%
	  				}
	  			%>
				</div>
			</div>
		</div>
	</div>
	
	<div class = "container">
		<form method="post" action="replyAction.jsp?bookID=<%= bookID %>">
			<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd;">
				<%-- 홀,짝 행 구분 --%>
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeeee; text-align: center;">댓글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align: left;">d</td>
						<td style="text-align: right;">
						<a href="update.jsp?bbsID=d" class="btn">수정</a>
						<a href="update.jsp?bbsID=d" class="btn ">삭제</a>
						</td>
					</tr>
						<td><textarea type="text" class="form-control"
								placeholder="댓글을 입력하세요." name="replyContent" maxlength="2048"></textarea></td>
						<td style="text-align: left; "></td>
				</tbody>
			</table>
			<input type="submit" class="btn" value="댓글입력">
		</form>	
	</div>
  </section> 
  
 <!-- ======= Footer ======= -->
  <footer id="footer" class="section-bg">
    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong>ITformation</strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!--
        All the links in the footer should remain intact.
        You can delete the links only if you purchased the pro version.
        Licensing information: https://bootstrapmade.com/license/
        Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=Rapid
      -->
        Designed by <a href="index.jsp">ITformation</a>
      </div>
    </div>
  </footer><!-- End  Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/purecounter/purecounter.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>