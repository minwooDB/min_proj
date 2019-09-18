<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page session="true" %>
 <%@ page import="vo.UsersVO, java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta charset="utf-8" />
    
    <title>Groupth</title>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
	
	<link rel="shortcut icon" href="/mini/resources/file/img/s_img/favicon.ico" type="image/x-icon" />
	
    <link rel="stylesheet" type="text/css" href="./resources/file/css/style.css" />
    <link rel="stylesheet" type="text/css" href="./resources/file/css/respond.css" />

    <!--[if lt IE 9]>
       <script src="./resources/file/js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
<%
if(session.getAttribute("loginUser")!=null){
%>
<script>
	window.location.href="/mini/";
</script>
<%} %>
<dl class="skip">
	<dt class="blind"><strong>skip navigation</strong></dt>
    <dd><a href="#content">skip to content</a></dd>
</dl>
<div id="wrap">
	<%@ include file="../header.jsp" %>

	<div id="content">
	<div class="sub_title"><div class="container">로그인</div></div>
	
	<div id="loginBox">
		<div class="login_logo"><img src="./resources/file/img/s_img/logo.png" alt="Groupth" /></div>
		<div class="padding">
		<form method="post" action="/mini/loginProcess">
			<div class="input_box">
				<input type="text" name="idVal" placeholder="아이디를 입력하세요." required />
			</div>
			<div class="input_box">
				<input type="password" name="pwdVal" placeholder="비밀번호를 입력하세요." required />
			</div>
			<div class="button">
				<input type="submit" value="로그인" />
			</div>
		</form>
		</div>
	</div>

	</div><!-- content End -->

	<%@ include file="../footer.jsp" %>
</div>

</body>
</html>
