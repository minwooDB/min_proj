<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.UsersVO,vo.GroupVO, vo.FieldVO, java.util.ArrayList"%>
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
	
	<script>
		function myInfo(){
			document.getElementById("myInfo").style.display="block";
			document.getElementById("settingGroup").style.display="none";
			document.getElementById("addInfo").style.display="none";
			$(".info").addClass("on");
			$(".group").removeClass("on");
			$(".add").removeClass("on");
		}
		function myGroup(){
			document.getElementById("settingGroup").style.display="block";
			document.getElementById("myInfo").style.display="none";
			document.getElementById("addInfo").style.display="none";
			$(".group").addClass("on");
			$(".info").removeClass("on");
			$(".add").removeClass("on");
		}
		function addInfo(){
			document.getElementById("addInfo").style.display="block";
			document.getElementById("settingGroup").style.display="none";
			document.getElementById("myInfo").style.display="none";
			$(".add").addClass("on");
			$(".group").removeClass("on");
			$(".info").removeClass("on");
		}
	</script>
	<div id="content">
		<div class="sub_visual" id="mypage">
			<div class="cover"></div>
			<h3>마이페이지</h3>
		</div>
		<div id="myPageBox">
			<div id="myPageNav">
				<h3>마이페이지</h3>
				<ul>
					<li class="add on"><a onclick="addInfo()">추가정보 입력</a></li>
					<li class="group"><a onclick="myGroup()">내 그룹 관리</a></li>
					<li class="info"><a onclick="myInfo()">내 정보 수정</a></li> 
				</ul>
			</div>

			<div id="addInfo">
				<h4>추가정보 입력</h4>
				<%
					UsersVO vo = (UsersVO)request.getAttribute("showUser");
				%>
				<form method="post" action="/mini/mypage/myInfo" enctype="multipart/form-data">
				<div class="padding">
					<div class="profile">
						<div class="subject">프로필 이미지 관리</div>
						<div class="img"><img src="/mini/resources/users/<%=vo.getImg()%>" /></div>
							<input type="hidden" name="action" value="addInfo" />
							<input type="hidden" name="lat" id="mapLat" />
							<input type="hidden" name="lng" id="mapLng" />
							<input type="file" name = "image" accept="image/*" />

					</div><!-- profile End -->

					<div class="interest">
						<div class="subject">관심 그룹 분야</div>
						<select id="field" name="field">
							<%
								ArrayList<FieldVO> field = (ArrayList<FieldVO>) request.getAttribute("field");
								if (!field.isEmpty()) {
									for (FieldVO type : field) {
							%>
							<option value="<%=type.getFid()%>"><%=type.getType()%></option>
							<%
								}}
							%>
						</select>
					</div>

					<div class="map_wrap">
						<div class="subject">나의 위치 등록</div>
						
						<div class="loc_box">
							<span class="txt">주소 입력 : </span>
							<input type="text" name ="location" id="location" placeholder="서울시 강남구 역삼동" />
							<input type="button" id="findloc" value="위치찾기" />
						</div>
						<div id="mapid" style="width: 100%; height: 400px;"></div>
					</div>
					
					<div class="save">
						<input type="submit" value="저장하기" />
					</div>
					<script>
						<%if(vo.getField()!=0){%>
							$("#field option:eq("+(<%=vo.getField()%>-1)+")").attr("selected","selected");
						<%}if(vo.getLat()!=null){%>
						var latlng = encodeURIComponent(<%=vo.getLat()%>+","+<%=vo.getLng()%>);
						$.getJSON("https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY&latlng="+latlng, function(data) {
							$("input#location").val(data.results[0].formatted_address);				
													
						});
						<%}%>
					</script>
				</div>	
				</form>
			</div><!-- addInfo End -->

			<div id="myInfo" style="display: none;">
				<h4>내 정보 수정</h4>
				<div class="padding">
					<form method="post" action="/mini/mypage/myInfo">
						<input type="hidden" name="action" value="change" />
						<div class="input_box">
							<div class="title">아이디</div>
							<div class="input id_value"><%= vo.getUsers_id() %></div>
						</div>
						<div class="input_box">
							<div class="title">패스워드</div>
							<div class="input"><input type="password" name="password" value="<%= vo.getPassword() %>" placeholder="패스워드를 입력하세요." required /></div>
						</div>
						<!-- <div class="input_box">
							<div class="title">패스워드 확인</div>
							<div class="input"><input type="text" name="password_confirm" placeholder="패스워드를 입력하세요." /></div>
						</div> -->
						<div class="input_box">
							<div class="title">이름</div>
							<div class="input"><input type="text" name="name" value="<%= vo.getName() %>" placeholder="이름을 입력하세요." required /></div>
						</div>
						<div class="input_box">
							<div class="title">이메일</div>
							<div class="input"><input type="text" name="email" value="<%= vo.getEmail() %>" placeholder="이메일을 입력하세요." required /></div>
						</div>
						<!-- <div class="input_box">
							<div class="title">닉네임</div>
							<div class="input"><input type="text" name="nickname" placeholder="닉네임을 입력하세요." /></div>
						</div> -->
						<div class="button">
							<ul>
								<li><input type="submit" value="수정" /></li>
								<li class="last"><input type="reset" value="취소" /></li>
							</ul>
							
						</div>
					</form>
					
				</div><!-- padding End -->
			</div><!-- settingGroup End -->
			<div id="settingGroup" style="display: none;">
				<h4>내 그룹 관리</h4>
				<div class="padding">
					<ul>
						<%
						if(request.getAttribute("myGroup") != null){
							ArrayList<GroupVO> group = (ArrayList<GroupVO>) request.getAttribute("myGroup");
							for(GroupVO myGroup : group){
						%>
						<li>
							<div class="padding">
								<div class="img"><a href="/mini/group/content?gid=<%=myGroup.getGid()%>"><img src="/mini/resources/Gimg/<%=myGroup.getImg()%>" alt="<%=myGroup.getG_name()%>" /></a></div>
								<div class="title"><a href="/mini/group/content?gid=<%=myGroup.getGid()%>"><%=myGroup.getG_name()%></a></div>
								<a href="/mini/mypage/deleteGroup?gid=<%=myGroup.getGid()%>" class="out">탈퇴하기</a>
							</div>
						</li>
						<%}}%> 
					</ul>


				</div>
			</div><!-- settingGroup End -->
		</div><!-- myPageBox End -->
	</div><!-- content End -->

	<%@ include file="/WEB-INF/views/footer.jsp" %>


</div>
		<script>
		<%if(request.getParameter("msg")!=null){%>
		alert("<%=request.getParameter("msg")%>");
		<%}%>
		</script>
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
	</script>
</body>
</html>