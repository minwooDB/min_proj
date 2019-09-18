<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.Login_InfoVO, vo.UsersVO, vo.FieldVO, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

<link rel="shortcut icon" href="/mini/resources/file/img/s_img/favicon.ico" type="image/x-icon" />
	

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
	<div class="sub_visual" id="matching">
			<div class="cover"></div>
			<h3>매칭</h3>
		</div>
	<%
		Login_InfoVO user = (Login_InfoVO)session.getAttribute("loginUser");
		if(user!=null){
	%>
	<%}%>

	<%
		UsersVO userInfo = (UsersVO) request.getAttribute("matchInfo");
		if((userInfo.getLat()==null)&&(userInfo.getField()==0)){
	%>
		<div class="match_message">
			<div class="padding">
			<p>※ 매칭 서비스를 사용하시려면 반드시 마이페이지에서 추가정보를 입력하셔야 합니다. </p>
			<a href="/mini/mypage">추가정보 입력 바로가기</a>
			</div>
		</div>
	<%} %>


		<div id="matchBox">
			<div class="padding">
				<form method="post" action="/mini/match" onsubmit="return check()">
					<input type="hidden" name="lat" id="mapLat" />
					<input type="hidden" name="lng" id="mapLng" />
					
					<div class="input_box">
						<div class="title">스터디 매칭 분야 : </div>
						<div class="input">
							<select name="field">
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
					</div>
					<div class="input_box">
						<div class="title">범위 설정(반지름 km기준) :</div>
						<div class="input"><input type="number" name="range" value="3" min="1" max="10" required /></div>
					</div>
					<div class="input_box triple">
						<div class="title">원하는 스터디 지역 검색 : </div>
						<div class="input"><input type="text" name ="location" id="location" placeholder="서울시 강남구 역삼동" required /></div>
						<div class="find"><input type="button" id="findloc" value="위치찾기" /></div>
					</div>
					
					
					<div id="mapid" style="width: 100%; height: 400px;"></div><br>
					<div class="save"><input type="submit" value="매칭하기" /></div>
				</form>
			</div>
		</div><!-- matchBox End -->	
			
			
		<script>
		function check() {
				<%
				if((userInfo.getLat()==null)&&(userInfo.getField()==0)){
				%>
				alert("마이페이지에서 추가정보를 입력해야 이용하실수 있습니다.");
				return false;
				<%}else{%>
				return true;
				<%}%>
			}
			
				
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
	</div><!-- content End -->
	
	<%@ include file="/WEB-INF/views/footer.jsp" %>
	
</div>
	
</body>
</html>