<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<div id="joinBox">
		<div class="padding">
		<h3>회원가입</h3>
 		<form name="fun" method="post" action="/mini/register">
			<div class="input_box">
				<div class="title">아이디</div>
				<div class="input"><input type="text" name="users_id"  id="users_id" placeholder="영문자로 시작 숫자 및 영문자 끝나는 5~19자리 문자" required /></div>
				<input type="button" id="idCheck" value="중복확인" />
				<span id = "chkMsg"></span>	
			</div>
			<div class="input_box">
				<div class="title">패스워드</div>
				<div class="input"><input type="password" name="password"  id="password" placeholder="특수문자,숫자를 각각 1개 이상 포함한 8~15개의 문자열" required /></div>		
			</div>
			<div class="input_box">
				<div class="title">패스워드 확인</div>
				<div class="input"><input type="password" name="password_confirm" id="passwordConfirm" placeholder="패스워드를 입력하세요." /></div>
			</div>
			<div class="input_box">
				<div class="title">이름</div>
				<div class="input"><input type="text" name="name"   placeholder="이름을 입력하세요." required /></div>
			</div>
			<div class="input_box">
				<div class="title">이메일</div>
				<div class="input"><input type="text" name="email"  id="email" placeholder="dl_als-dn.@example.com" required /></div>
			</div>
			<!-- <div class="input_box">
				<div class="title">닉네임</div>
				<div class="input"><input type="text" name="nickname" placeholder="닉네임을 입력하세요." /></div>
			</div> -->
			<div class="button">
				<ul>
					<li><input OnClick = "GoToEnroll(); " type="button"  value="회원가입" /></li>
					<li class="last"><input type="reset" value="재작성" /></li>
				</ul>
				
			</div>
		</form>
		</div>
	</div>

	</div><!-- content End -->


	<%@ include file="../footer.jsp" %>

</div>
<script type="text/javascript">
function Checkid(users_id){                                                 
    var reg_users_id =/^[a-z]+[a-z0-9]{5,10}$/g;
    if(users_id.length == 0) {                             
       return false;         
    }
    else if(users_id.length > 10){
    	return false;
    }
    else if(!users_id.match(reg_users_id)) {                             
        return false;         
   }     
    else {                       
         return true;         
    }
}
function Checkpassword(pwd){                                                 
     var reg_password = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
     if(pwd.length == 0) {                             
        return false;         
     }
     else if(!pwd.match(reg_password)) {                             
         return false;         
    }     
     else {                       
          return true;         
     }
}
function CheckEmail(str){                                                 
     var reg_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
     if(str.length == 0) {                            
          return false;         
     }                            
     if(!str.match(reg_email)) {                            
         return false;         
    }
    else
    	return true;                            
}
function GoToEnroll(){   
	var obId  = document.getElementById("users_id");
	var obPassword  = document.getElementById("password");
	var obEmail  = document.getElementById("email");
	var obPasswordConfirm = document.getElementById("passwordConfirm");

	if (!obId.value) {
		alert("아이디를 입력하세요!");
		obId.focus();	
		return false;	
	}          
	if(!Checkid(obId.value)){
		alert("아이디 에러! 영문자로 시작, 숫자 또는 영어로 끝나는 5~10자리");
		obId.focus();
		return false;              
	}
	if (!obPassword.value) {
		alert("비번을 입력하세요!");
		obPassword.focus();	
		return false;	
	}
	if(!Checkpassword(obPassword.value)){
		alert("영문, 특수 1,숫자 1을 포함한 8~15개의 문자로 작성!");
		obPassword.focus();
		return false;              
	}
	if(obPasswordConfirm.value != obPassword.value){
		window.alert("비밀번호가 다릅니다!");
		obPasswordConfirm.focus();
		return false;
	}
	if (!obEmail.value) {             
		alert("이메일을 입력하세요!");
		obEmail.focus();	
		return false;
	}          
	if(!CheckEmail(obEmail.value)){
		alert("특수문자-_. ,영어 및 숫자@example");
		obEmail.focus();
		return false;
	}else{
	alert("성공적으로 가입되었습니다.");
	fun.submit();
}
}
$("#idCheck").click(function(){
    var id = $('#users_id').val();
    console.log(id);
    $.ajax({
        url:'/mini/idDuplChk?users_id='+id,
        type:'get',
        success:function(data){
            if($.trim(data)==0){
                $('#chkMsg').html("사용가능").attr("style","color:black");                
            }else{
                $('#chkMsg').html("사용불가").attr("style","color:red");
            }
        },
        error:function(){
                alert("에러입니다");
        }
    });
});
</script>          
</body>
</html>
