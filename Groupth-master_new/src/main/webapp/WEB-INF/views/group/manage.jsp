<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.UsersVO, vo.Login_InfoVO, vo.NoticeVO, vo.Group_InfoVO, java.util.ArrayList"%>
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
		<div id="myPageBox">
			<h3 class="s_title">&lt;<%=content.getG_name() %>&gt;</h3>
			<div id="myGroupInfo">
				<div class="group_cty"><%=content.getType() %></div>
				<div class="group_img"><img src="../resources/Gimg/<%=content.getImg()%>" alt="그룹이미지" /></div>
			
				<div class="padding">	
					<div class="group_leader">그룹리더 : <%=content.getLeader() %></div>
					<p><%=content.getG_content() %></p>

					<a href="javascript: void(0);" class="group_remove" onclick="deleteGroup();">그룹삭제</a>
				</div>
			</div>
		<%
			}
		%>
			<div id="groupAdmin">
				<h4>그룹 멤버</h4>
				<div class="padding">

					<div class="stand">
						<div class="table">
							<table>
								<caption class="hide">가입대기자 목록</caption>
								<colgroup>
									<col width="*" />
									<col width="20%" />
									<col width="20%" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="3" class="title">가입대기자</th>
									</tr>
									<tr>
										<th>아이디</th>
										<th>수락</th>
										<th>거부</th>
									</tr>
								</thead>
								<tbody>
									
	<%
		ArrayList<UsersVO> tempMember = (ArrayList<UsersVO>) request.getAttribute("tempMember");

		if(!tempMember.isEmpty()){
			for(UsersVO mem : tempMember){	
	%>
									<tr>
										<td><%=mem.getUsers_id()%></td>
										<td><div class="check"><a href='/mini/group/manage?gid=<%=request.getParameter("gid")%>&uid=<%=mem.getUsers_id()%>&action=welcomeApplicant'><img src="/mini/resources/file/img/s_img/mem_check.png" alt="수락"></a></div></td>
										<td><div class="check"><a href='/mini/group/manage?gid=<%=request.getParameter("gid") %>&uid=<%=mem.getUsers_id()%>&action=rejectApplicant'><img src="/mini/resources/file/img/s_img/mem_cancel.png" alt="거부"></a></div></td>
									</tr>
	<%
			}}
		else{%>
									<tr>
										<td colspan="3">신청자가 없습니다.</td>
									</tr>
		<%}
	%>
								</tbody>
							</table>
						</div>
					</div><!-- 가입대기자 End -->

					<div class="member">

						<div class="table">
							<table>
								<caption class="hide">그룸멤버 목록</caption>
								<colgroup>
									<col width="20%" />
									<col width="*" />
									<col width="20%" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="3" class="title">그룹멤버</th>
									</tr>
									<tr>
										<th>프로필</th>
										<th>아이디</th>
										<th>추방</th>
									</tr>
								</thead>
								<tbody>

	<%
		ArrayList<UsersVO> currentMember = (ArrayList<UsersVO>) request.getAttribute("currentMember");
		if(!currentMember.isEmpty()){
			for(UsersVO mem : currentMember){	
			if (session.getAttribute("loginUser") != null) {
				Login_InfoVO user = (Login_InfoVO) session.getAttribute("loginUser");
				if (user.getUser().equals(mem.getUsers_id())) {
		%>

									<tr>
										<td><div class="icon"><img src="/mini/resources/file/img/s_img/crown.png" alt="프로필"></div></td>
										<td><%=mem.getUsers_id()%></td>
										<td><div class="check"></td>
									</tr>

		<%}else {%>
									<tr>
										<td><div class="icon"><img src="/mini/resources/file/img/s_img/people.png" alt="프로필"></div></td>
										<td><%=mem.getUsers_id()%></td>
										<td><div class="check"><a href='/mini/group/manage?gid=<%=request.getParameter("gid") %>&uid=<%=mem.getUsers_id()%>&action=dropApplicant'><img src="/mini/resources/file/img/s_img/mem_cancel.png" alt="거부"></a></div></td>
									</tr>

		<%}}%> 
		
		<%}}else{%>
			멤버가 없습니다.
	<%}%>
									

									<!-- <tr>
										<td><div class="icon"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4Wg6L7hMsjleF51zW575bNjK1dCZovVz2xJ7luMsXQkTF1Qxz" alt="프로필"></div></td>
										<td>usong2</td>
										<td><div class="check"><a href="#"><img src="./file/img/s_img/mem_cancel.png" alt="거부"></a></div></td>
									</tr> -->
								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div><!-- settingGroup End -->
			
			<div id="groupAdmin">
				<h4>공지사항</h4>
				<div class="padding">
					<div id="boardList">
						<div class="table_wrap">
						<table border="0" cellpadding="0" cellspacing="0">
							<caption>게시판</caption>
							<colgroup>
								<col width="*" />
								<col width="15%" />
								<col width="20%" />
								<col width="13%" />
							</colgroup>

							<thead>
								<tr>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">관리</th>
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
									<td><div class="check"><a href='/mini/group/noticeDelete?nid=<%=nList.getNid()%>&gid=<%=request.getParameter("gid")%>'><img src="/mini/resources/file/img/s_img/delete.png" alt="거부"></a></div></td>
								</tr>
								<tr class="con">
									<td colspan="4">
										<p><%=nList.getContent()%></p>
										<div class="download"><a href="/mini/resources/files/<%=nList.getFiles()%>" download>다운로드 : <%=nList.getFiles()%></a></div>
									</td>
								</tr>
		<%
			}
		%>
	<%} %>
							</tbody>

						</table>	

						<script>
							$(document).ready(function(){
								$("#boardList table td.title").click(function(){
									if($(this).hasClass("on")){
										$(this).parent("tr").next().slideUp();
										$(this).removeClass("on");
									}else{
										$(this).parent("tr").next().slideDown();
										$(this).addClass("on");
									}
									

								});
							});
						</script>
						</div> 

					</div><!-- boardList End -->

					<div class="write_btn"><button onclick="writeNotice()">공지 작성하기</button></div>
				</div>
				

			</div><!-- settingGroup End -->
			
			<div id="groupAdmin">
				<h4>장소공지</h4>
				<div class="padding">
					
	<span id="chkMsg"></span>
	<form>
		<input type="hidden" name="gid" id="gid" value='<%=request.getParameter("gid")%>'>
		<input type="hidden" name="lat" id="mapLat" />
		<input type="hidden" name="lng" id="mapLng" />
		<div class="loc_box">
		<input type="text" name ="location" id="location" placeholder="서울시 강남구 역삼동" />
		<input type="button" id="findloc" value="위치찾기" />
		<input type="button" id="storeLocation" value="저장하기" />
		</div>
	</form>
	<div id="mapid"></div>

	<script>



		$(document).ready(function(){
			
			var mymap =L.map('mapid').setView([37.566, 126.978], 13);
			L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
				maxZoom: 18,
				attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
					'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
					'Imagery <a href="https://www.m/* apbox.com/">Mapbox</a>',
				id: 'mapbox.streets'
			}).addTo(mymap);
			
			function onMapClick(e) {
				$(".leaflet-marker-pane img").remove();
				$(".leaflet-popup-pane").remove();
				$(".leaflet-shadow-pane").remove();
				var lat = (e.latlng.lat);
			    var lng = (e.latlng.lng);
			    L.marker([lat, lng]).addTo(mymap);	
			    
			    $("input#mapLng").val(lng);
			    $("input#mapLat").val(lat);
			    
			    var latlng = encodeURIComponent(lat+","+lng);
			    $.getJSON("https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY&latlng="+latlng, function(data) {
					$("input#location").val(data.results[0].formatted_address);				
											
				});
			    
			}
			
			$("#findloc").click(function(){
			
				var address = $("#location").val();
				var lat;
				var lng;
				
				if (address) {			
					$.getJSON("https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY&address="+encodeURIComponent(address), function(data) {
						lat = data.results[0].geometry.location.lat;
						lng = data.results[0].geometry.location.lng;
						
						$("input#mapLng").val(lng);
					    $("input#mapLat").val(lat);
					    
						if(mymap)
							mymap.remove();
						mymap = L.map('mapid').setView([lat, lng], 16)
						L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
							maxZoom: 18,
							attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
								'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
								'Imagery <a href="https://www.mapbox.com/">Mapbox</a>',
							id: 'mapbox.streets'
						}).addTo(mymap);
		
						 L.marker([lat, lng]).addTo(mymap);

						 mymap.on('click', onMapClick);
					
					});
				}		 
			
			});
			
			mymap.on('click', onMapClick);
			
			
		});
		
		$("#storeLocation").click(function(){
		    var gid = $('#gid').val();
		    var lat = $('#mapLat').val();
		    var lng = $('#mapLng').val();
		    var location = $('#location').val();
		    console.log(gid);
		    console.log(lat);
		    console.log(lng);
		    console.log(location);
		    $.ajax({
		        url:'/mini/group/manage/storeLocation?gid='+gid+'&lat='+lat+'&lng='+lng+'&location='+location,
		        type:'get',
		        success:function(data){
		            if($.trim(data)==1){
		                $('#chkMsg').html("위치를 저장하였습니다.").attr("style","color:black");                
		            }else{
		                $('#chkMsg').html("저장하지 못하였습니다.").attr("style","color:red");
		            }
		        },
		        error:function(){
		                alert("에러입니다");
		        }
		    });
		});
	</script>
	


				</div>
			</div><!-- settingGroup End -->
			
			
		</div><!-- myPageBox End -->

	</div><!-- content End -->

	<script>
			<%
			if (request.getAttribute("content") != null) {
				Group_InfoVO content = (Group_InfoVO) request.getAttribute("content");
			%>
		function writeNotice(){
			location.href="/mini/group/content/write?gid=<%=content.getGid()%>";
		}
			<%}%>
			
		function deleteGroup(){
			location.href='/mini/group/manage?action=deleteGroup&gid=<%=request.getParameter("gid")%>';
		}
	</script>

	<%@ include file="/WEB-INF/views/footer.jsp" %>
	
</div>

</body>
</html>
