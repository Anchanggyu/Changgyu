<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="en">
<!-- 회원 정보 수정 화면 -->
<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>회원 수정</title>
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
</head>

<body>
	<%
		String id = null;
		
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
		}
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
          <li><a class="nav-link scrollto" href="board.jsp">자유게시판</a></li>
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
  
  <!-- ======= infoupdate Section ======= -->
  <section id="hero" class="clearfix">
  	<div class = "container w-50">
  	<div class = "shadow-lg p-3 mb-5 bg-body rounded position-absolute top-50 start-50 translate-middle">
		<a href = "memberupdate.jsp"><h3 style = "text-align: center;"><code>정보수정</code></h3></a><br/>
		<form class = "row g-3" method = "post" action = "function/memberupdatepro.jsp">
		  <div class="col-12">
		    <label for = "inputID" class = "form-label">아이디</label>
		    <input type = "text" class = "form-control" name = "id" maxLength = "20" value = <%= id %> readonly>
		  </div>
		  <div class="col-12">
		    <label for="inputPassword" class="form-label">비밀번호</label>
		    <input type="password" class = "form-control" name = "pw" maxLength = "20">
		  </div>
		  <div class="col-12">
		    <label for = "inputPasswordCheck" class = "form-label">이메일</label>
		    <input type = "text" class = "form-control" name = "email" maxLength = "20">
		  </div>
		  <div class="col-12">
		    <label for = "inputEmail" class="form-label">전화번호</label>
		    <input type = "text" class = "form-control" name = "tel" maxLength = "20" placeholder = "전화번호(-를 포함해주세요)">
		  </div>
		  <div class="col-lg-12 text-lg-end">
		  	<button class = "btn btn-info" type = "submit">확인</button>
			<a href = "logininfo.jsp"><button class = "btn btn-info" type = "button">취소</button></a>
			<input type = "reset" class = "btn btn-info" value = "다시입력">
		  </div>
		</form>
	</div>
	</div>
  </section>
  <!-- End infoupdate -->

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