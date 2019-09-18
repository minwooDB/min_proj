<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.BoardVO, java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta charset="utf-8" />
    
    <title>Groupth</title>
	
	<link rel="shortcut icon" href="/mini/resources/file/img/s_img/favicon.ico" type="image/x-icon" />
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

    <link rel="stylesheet" type="text/css" href="./resources/file/css/style.css" />
    <link rel="stylesheet" type="text/css" href="./resources/file/css/respond.css" />

    <!--[if lt IE 9]>
       <script src="./resources/file/js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
<dl class="skip">
	<dt class="blind"><strong>skip navigation</strong></dt>
    <dd><a href="#content">skip to content</a></dd>
</dl>
<div id="wrap">
	
	<%@ include file="../header.jsp" %>

	<div id="content">
		<div class="sub_visual" id="community">
			<div class="cover"></div>
			<h3>커뮤니티</h3>
		</div>
		<div id="boardList">
			
			<%
				ArrayList<BoardVO> list = (ArrayList<BoardVO>) request.getAttribute("list");
				if (!list.isEmpty()) {
			%>
			<div class="table_wrap">
			<table border="0" cellpadding="0" cellspacing="0">
				<caption>커뮤니티</caption>
				<colgroup>
					<col width="12%" />
					<col width="*" />
					<col width="15%" />
					<col width="20%" />
					<col width="12%" />
				</colgroup>

				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>

				<tbody>
					<%
						for (BoardVO vo : list) {
					%>
					<tr>
						<td><%=vo.getBid()%></td>
						<td class="title">
						<% if(vo.getCnt() >= 50){
						%>	
							<img src="/mini/resources/file/img/s_img/hot.gif" style="width: 20px;" alt="인기글" />
						<%
						}
						%>
						<a href='/mini/board/content?bid=<%=vo.getBid()%>&writer=<%=vo.getWriter()%>&action=read'><%=vo.getTitle()%></a></td>
						<td><a href='/mini/board?action=listwriter&writer=<%=vo.getWriter()%>'><%=vo.getWriter()%></a></td>
						<td><%=vo.getWritedate()%></td>
						<td><%=vo.getCnt()%></td>
					</tr>

					<%
						}
					%>
				</tbody>

			</table>	
			</div>
			<%
				} else {
			%>
			<script>
				alert("찾는 내용이 없습니다.");
				document.location.href="/mini/board";
			</script>
			<%
				}
			%>
			<div class="search_box">
				<form method="get" action="/mini/board">
					<div class="select">
						<select name="searchType" id="cty">
							<option value="title">제목</option>
							<option value="bid">글번호</option>
							<option value="writer">작성자</option>
						</select>
					</div>
					<input type="hidden" name="action" value="search"> 
					<div class="search"><input type="text" name="key" /></div>
					<div class="btn"><input type="submit" value="검색" /></div>
				</form>
			</div>

			<div class="b_btn">
				<a href="/mini" class="color">홈으로</a>
				<%
					if(session.getAttribute("loginUser")!=null){
				%>
				<a href="/mini/board/content/edit?action=insert">게시물작성</a>
				<%
				}
				%>
			</div>
		</div>

	</div><!-- content End -->
	
	<%@ include file="../footer.jsp" %>

</div>

</body>
</html>
