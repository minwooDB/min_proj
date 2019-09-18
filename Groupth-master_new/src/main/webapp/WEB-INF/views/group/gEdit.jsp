<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.FieldVO, java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta charset="utf-8" />
    
    <title>Groupth</title>
	
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
				<h3>그룹 생성하기</h3>

				<form method="post" action="/mini/group" enctype="multipart/form-data">
					<input type="hidden" name ="action" value="insert">
					<div class="input_box double">
						<div class="box">
							<div class="title">그룹분야</div>
							<div class="input">
								<select name="fid">
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

						<div class="box right">
							<div class="title">인원 수</div>
							<div class="input"><input type="number" name="limit_mem" value="5" min="2" max="50" /></div>
						</div>
					</div>
					<div class="input_box">
						<div class="title">그룹명</div>
						<div class="input">
							<input type="text" name="g_name" placeholder="그룹 이름을 입력해주세요." required />
							<input type="hidden" name="leader" value="${ sessionScope.loginUser.user}" />
						</div>
					</div>
					<div class="input_box">
						<div class="title">그룹설명</div>
						<div class="input">
							<textarea cols="50" rows="8" name="g_content" placeholder="그룹 설명을 입력해주세요." required /></textarea>
						</div>
					</div>
					<div class="file_box">
						<div class="title">대표이미지</div>
						<div class="input">
							<input type="file" name="image" accept="image/*" required />
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
