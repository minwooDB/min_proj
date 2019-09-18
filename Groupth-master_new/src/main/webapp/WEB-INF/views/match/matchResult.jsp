<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.UsersVO, java.util.ArrayList"%>
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
			<h3>매칭 결과</h3>
		</div>
		<div id="matchBox">
			<div class="padding">
	<% UsersVO userInfo = (UsersVO) request.getAttribute("matchInfo");
		ArrayList<UsersVO> allUsersLocation =(ArrayList<UsersVO>) request.getAttribute("allUsersLocation");
	%>
<div id="mapid" style="width: 100%; height: 400px;"></div><br>
<script>
	$(document).ready(function(){
		var mymap =L.map('mapid').setView([<%=request.getParameter("lat")%>, <%=request.getParameter("lng")%>], 12);
		var content = "<h3>나</h3><hr> <img src='/mini/resources/users/<%=userInfo.getImg()%>' width='50' hegith='50'>";
		
		L.marker([<%=request.getParameter("lat")%>, <%=request.getParameter("lng")%>]).addTo(mymap)
		.bindPopup(content).openPopup(); 
		
		var myIcon = L.icon({
		    iconUrl: '/mini/resources/static/user.png',
		    iconSize: [30, 30]
		});
		var matchUserContent;
		<%for(UsersVO matchUser : allUsersLocation){%>
			matchUserContent="<h3><%=matchUser.getUsers_id()%></h3><hr>이메일 : <%=matchUser.getEmail()%><br><img src='/mini/resources/users/<%=matchUser.getImg()%>' width='50' hegith='50'>";
			L.marker([<%=matchUser.getLat()%>,<%=matchUser.getLng()%>], {icon: myIcon}).addTo(mymap).bindPopup(matchUserContent);
		<%}%>
		
		L.circle([<%=request.getParameter("lat")%>, <%=request.getParameter("lng")%>], <%=Integer.parseInt(request.getParameter("range"))*1000%>, {
			fillColor: 'blue',
			fillOpacity: 0.1
		}).addTo(mymap);
		
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

		<div class="list_btn"><a href="/mini/match">목록</a></div>
	</div><!-- content End -->
	
	<%@ include file="/WEB-INF/views/footer.jsp" %>
	
</div>
	
</body>
</html>