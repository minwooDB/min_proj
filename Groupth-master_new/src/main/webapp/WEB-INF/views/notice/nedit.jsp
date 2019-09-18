<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta charset="utf-8" />
    
    <title>Groupth</title>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
	
	<link rel="shortcut icon" href="/mini/resources/file/img/s_img/favicon.ico" type="image/x-icon" />
	
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
		
		<div class="sub_visual" id="group">
			<div class="cover"></div>
			<h3>그룹</h3>
		</div>
	<div id="boardWrite">
		<div class="padding">
			<h3>공지사항 작성하기</h3>

			<form method="post" action="/mini/group/content/write" enctype="multipart/form-data">
				<input type="hidden" name="gid" value='<%=request.getParameter("gid")%>'>
			<input type="hidden" name="writer" value="${sessionScope.loginUser.user}">
				<div class="input_box"> 
					<div class="title">제목</div>
					<div class="input"><input type="text" name="title" placeholder="제목을 입력하세요." required /></div>
				</div>
				<div class="input_box">
					<div class="title">내용</div>
					<div class="input">
						<textarea cols="50" rows="8" name="content" placeholder="내용을 입력해주세요." required /></textarea>
					</div>
				</div>
				<div class="file_box">
					<div class="title">첨부파일</div>
					<div class="input">
						<input type="file" name="file" />
					</div>
				</div>
				
				<div class="button">
					<ul>
						<li><input type="submit" value="저장" /></li>
						<li><input type="reset" value="초기화" class="gray" /></li>
						<li class="last"><input type="button" value="뒤로가기" class="gray" onclick="goBack(); return false;" /></li>
					</ul>
				</div>
			
			</form>
		</div>
	</div><!-- boardWrite-->

	</div><!-- content End -->

	<script>
		function goBack(){
			location.href="<%=request.getHeader("referer") %>";
		}
	</script>


	<%@ include file="/WEB-INF/views/footer.jsp" %>

</div>

</body>
</html>
