<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div id="header">
		<div class="container">
			<h1 id="logo"><a href="/mini"><img src="/mini/resources/file/img/s_img/logo.png" /></a></h1>
			
			<div class="menu mobile">MENU</div>
			<div id="navBg"></div>
			<div id="nav">
				<ul class="gnb">
<%
if(session.getAttribute("loginUser")!=null){
%>
					<li><a href="/mini/match">매칭</a></li>
<%
}
%>
					<li><a href="/mini/group">그룹</a></li>
					<li><a href="/mini/board">커뮤니티</a></li>
				</ul>
				<ul class="nav_bar">
					<ul>
<%
if(session.getAttribute("loginUser")!=null){
%>
						<li class="last"><a href="/mini/logout">로그아웃</a></li>
						<li class="long"><a href="/mini/mypage">
						<% if (session.getAttribute("loginUser") != null) { %>
						<strong>${sessionScope.loginUser.user}</strong>
						<%}%>님의 마이페이지</a></li>
<%
}else{
%>
						<li class="last"><a href="/mini/register">회원가입</a></li>
						<li><a href="/mini/login">로그인</a></li>
<%
}
%>
					</ul>
				</ul>
			</div><!-- nav End -->
			

		</div><!-- container End -->
	</div><!-- header End -->

	<script>		
	$(document).ready(function(e){
		$(".menu").click(function(){
			if($(this).hasClass("on")){
				$(this).removeClass("on");
				$("#nav").css({"display": "none"});
				$("#navBg").css({"display": "none"});

			}else{
				$(this).addClass("on");
				$("#nav").css({"display": "block"});
				$("#navBg").css({"display": "block"});
			}
		});

	});
	</script>