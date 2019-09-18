<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.Group_InfoVO, vo.Login_InfoVO, vo.NoticeVO, vo.GroupVO, java.util.ArrayList"%>
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

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/dist/leaflet.css"
   integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ=="
   crossorigin=""/>
	<script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js"
   integrity="sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og=="
   crossorigin=""></script>
</head>
<body>
<dl class="skip">
	<dt class="blind"><strong>skip navigation</strong></dt>
    <dd><a href="#content">skip to content</a></dd>
</dl>
<div id="wrap">
	
	<%@ include file="/WEB-INF/views/header.jsp" %>

	<div id="content">
		<div class="sub_visual" id="group">
			<div class="cover"></div>
			<h3>그룹</h3>
		</div>
		<%
		if (request.getAttribute("content") != null) {
			Group_InfoVO content = (Group_InfoVO) request.getAttribute("content");
		%>
		<div id="groupView">
			<div class="group_info">
				<div class="info">
					<div class="cty"><%=content.getType() %></div>
					<div class="title"><%=content.getG_name() %></div>
					<div class="leader">그룹리더 : <%=content.getLeader() %></div>
					<div class="number">인원 : <%=content.getCount_mem() %>/<%=content.getLimit_mem() %></div>

					<p><%=content.getG_content() %></p>

					<div class="join">
						
	<%
		
		if (session.getAttribute("loginUser") != null) {
			Login_InfoVO user = (Login_InfoVO) session.getAttribute("loginUser");
			if (user.getUser().equals(content.getLeader())) {
	%>
	
	<!-- 다시 post로 바꾸어주기 -->
	<form action="/mini/group/manage" method="get">
		<input type="hidden" name ="gid" value="<%=content.getGid()%>">
		<input type="submit" value ="그룹관리">
	</form>
	<%}
			else{
			%>
			<form action="/mini/group/content" method="get">
				<input type="hidden" name="action" value="apply">
				<input type="hidden" name="gid" value="<%=content.getGid()%>">
				<input type="hidden" name="uid" value="<%=user.getUser()%>">
				<%
				if (request.getAttribute("confirm") != null) {
				%>
				<h3>${confirm}</h3>
				<%} else{%>
				<input type="submit" value ="그룹 가입하기" />
				<% }%>
			</form>
			<%
			}
		}else{%>
			<a href="/mini/login" class="long">로그인하고 가입하기</a>
		<%
		}
		%>
		
		<%
		if (request.getAttribute("msg") != null) {%>
			<script>
			alert("${msg}");
			</script>
		<%}%>
					</div>

				</div>
				<div class="img"><img src="../resources/Gimg/<%=content.getImg()%>" alt="<%=content.getG_name() %>" /></div>
			</div>

			
			<div class="group_info bottom">	
				<div class="board">	
					<div id="boardList">
						<div class="subject">공지사항</div>
						<%if (request.getAttribute("confirm") != null) { %>
						<div class="w_btn"><button onclick ="writeNotice()">공지 작성하기</button></div>
						<%}%>
						<div class="table_wrap">
						<table border="0" cellpadding="0" cellspacing="0">
							<caption>커뮤니티</caption>
							<colgroup>
								<col width="*" />
								<col width="15%" />
								<col width="20%" />
							</colgroup>

							<thead>
								<tr>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
								</tr>
							</thead>

							<tbody>
	<%
		ArrayList<NoticeVO> noticelist = (ArrayList<NoticeVO>) request.getAttribute("noticelist");
		if (!noticelist.isEmpty()) {
	%>
		<% for (NoticeVO nList : noticelist) {%>
								<tr class="click">
									<td class="title"><%=nList.getTitle()%></td>
									<td><%=nList.getWriter()%></td>
									<td><%=nList.getWritedate()%></td>
								</tr>
								<tr class="con">
									<td colspan="3">
										<%=nList.getContent()%>
										<%if(nList.getFiles()!=null){ %>
										<div class="download"><a href="/mini/resources/files/<%=nList.getFiles()%>" download>다운로드 : <%=nList.getFiles()%></a></div>
										<%} %>
									</td>
								</tr>
	<%
			}
		}else{%>
								<tr>
									<td colspan="3">게시글이 없습니다.</td>
								</tr>
		<%
		}
	%>
							</tbody>

						</table>	

						<script>
							$(document).ready(function(){
								$("#boardList table td.title").click(function(){

								<%
									if (request.getAttribute("confirm") != null) {
								%>
									if($(this).hasClass("on")){
										$(this).parent("tr").next().slideUp();
										$(this).removeClass("on");
									}else{
										$(this).parent("tr").next().slideDown();
										$(this).addClass("on");
									}
								<%}else {%>
									alert("그룹 멤버에게만 글을 공개합니다.");
								<%}%>

								});
							});
						</script>
						</div> 

					</div><!-- boardList End -->
				</div>

				<div class="map">
					<div class="subject">모임장소</div>
					<div id="mapid" style="width: 100%; height: 300px;"></div>
				</div>
				<script>
				$(document).ready(function(){
					<% GroupVO location = (GroupVO) request.getAttribute("findLoc");
						System.out.println(location);
						if(location.getLat()!=null){
					%>
					var mymap =L.map('mapid').setView([<%=location.getLat()%>, <%=location.getLng()%>], 15);
					L.marker([<%=location.getLat()%>, <%=location.getLng()%>]).addTo(mymap)
					.bindPopup("<%=location.getLocation()%>").openPopup(); 
					<%}else{%>
					var mymap =L.map('mapid').setView([37.566, 126.978], 13);
					<%}%>
					L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
						maxZoom: 18,
						attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
							'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
							'Imagery <a href="https://www.m/* apbox.com/">Mapbox</a>',
						id: 'mapbox.streets'
					}).addTo(mymap);
				});
				</script>
			</div>
		</div>

		<div class="list_btn">
			<a href="/mini/group">목록</a>
		</div>

		<%
		}
		%>

		<%
			if (request.getAttribute("content") != null) {
				Group_InfoVO content = (Group_InfoVO) request.getAttribute("content");
			%>
		<script>
		function writeNotice(){
			location.href="/mini/group/content/write?gid=<%=content.getGid()%>";
		}
		</script>
		<% } %>
	</div><!-- content End -->

	<%@ include file="/WEB-INF/views/footer.jsp" %>
</div>

</body>
</html>
