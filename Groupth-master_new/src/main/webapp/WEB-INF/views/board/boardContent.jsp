<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.Login_InfoVO, vo.CommentVO"%>
<%@ page import="vo.BoardVO,java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta charset="utf-8" />
    
    <title>Groupth</title>
	
	<link rel="shortcut icon" href="/mini/resources/file/img/s_img/favicon.ico" type="image/x-icon" />
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

    <link rel="stylesheet" type="text/css" href="/mini/resources/file/css/style.css" />
    <link rel="stylesheet" type="text/css" href="/mini/resources/file/css/respond.css" />

    <!--[if lt IE 9]>
       <script src="/mini/resources/file/js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
<dl class="skip">
	<dt class="blind"><strong>skip navigation</strong></dt>
    <dd><a href="#content">skip to content</a></dd>
</dl>
<div id="wrap">

	<%@ include file="/WEB-INF/views/header.jsp" %>
	
	<div id="content">
	<div class="sub_visual" id="community">
			<div class="cover"></div>
			<h3>커뮤니티</h3>
		</div>
	<%
		if (request.getAttribute("listone") != null) {
			BoardVO one = (BoardVO) request.getAttribute("listone");
	%>
	<form method="get" action="/mini/board/content/edit">

		<div id="boardView">
			<div class="view_top">
				<div class="title"><%= one.getTitle() %></div>
				<p><%= one.getWriter() %> / <%= one.getWritedate() %></p>
			</div>
			
			<div class="view_bottom">
				<%= one.getContent() %>
			</div>
			
			<input type="hidden" name="action" value="update"> 
			<input type="hidden" name="bid" value="<%= one.getBid() %>"> 
			<input type="hidden" name="title" value="<%= one.getTitle() %>"> 
			<input type="hidden" name="content" value="<%= one.getContent() %>"> 

			<%
			if (session.getAttribute("loginUser") != null) {
				Login_InfoVO user = (Login_InfoVO) session.getAttribute("loginUser");
				if (user.getUser().equals(request.getParameter("writer"))) {
			%>
			<div class="b_btn">
				<input type="submit" value="수정" class="color" />
				<a href='/mini/board/content?action=delete&bid=<%=request.getParameter("bid")%>'>삭제</a>
			</div>
			<%}}
			%>
			</form>
			
			<!--*********************************************************************************************  -->
			<div id="kyunghyun" style="padding: 30px 0; text-align:center;">
			<% if(session.getAttribute("loginUser")!=null){ %>
				<div>
					<form method="post" action="/mini/board/content">
						<input type="hidden" name = "bid" value="<%=request.getParameter("bid")%>" >
						<input type="hidden" name = "writer" value="<%=request.getParameter("writer")%>" >
						<input type="hidden" name = "action" value="<%=request.getParameter("action")%>" >
						<textarea cols="50" rows="3" name="content" placeholder="내용을 입력해주세요." /></textarea>
						<input type="submit" style="height:50px; width:100px;"  value="댓글 등록하기"> 
					</form>
				</div><br>
				<%} %>
				<%
					ArrayList<CommentVO> list = (ArrayList<CommentVO>) request.getAttribute("listComments");
					if (!list.isEmpty()) {
						for (CommentVO vo : list) {
				%>
				<br>
				<div style=" border-bottom: 1px solid silver; text-align:center;">
					<p style="font-size: 20px;margin-bottom: 10px;font-weight: 500;"><%=vo.getContent() %></p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					작성일 : <span style="color:#5D5D5D; font-weight:lighter"><%=vo.getWritedate()%></span><br>
					작성자 : <span style="font-weight:bold"><%=vo.getWriter() %></span><br>
				</div>
				<%}} %>
			</div>
	<!--*********************************************************************************************  -->

			<div class="list_btn">
				<a href="/mini/board">목록</a>
			</div>
		</div>
	<%
		}
	%>
	
	

	</div><!-- content End -->

	<%@ include file="/WEB-INF/views/footer.jsp" %>

</div>

</body>
</html>
