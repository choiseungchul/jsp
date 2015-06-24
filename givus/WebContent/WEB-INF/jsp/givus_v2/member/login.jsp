<%@page import="dynamic.web.util.MessageHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	String referer = request.getHeader("referer");
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/member.css?noc=<%=System.currentTimeMillis() %>" />
<script type="text/javascript">
$(document).ready(function(){
	if(!Browser.ie7){
		$('.login_input, .btn.login').corner('5px');	
	}
	
	
	$('#pass').keyup(function(e){
		if(e.which === 13){
			send_login();
		}
	});
});

function send_login(){
	
	if($('#email').val() == ''){
		alert('<%=MessageHandler.getMessage("join.require.message1")%>');
		return;
	}
	if($('#pass').val() == ''){
		alert('<%=MessageHandler.getMessage("join.require.message4")%>');
		return;
	}
	
	var isAutoLogin = 'N';
	if($('#autoLogin').is(':checked')){
		isAutoLogin = 'Y';
	}
	
	$.ajax({			
		url: '${contextPath}/___/renew/loginproc',
		type : 'post',
		data: { email : $('#email').val(), pass : $.base64.encode($('#pass').val()), auto : isAutoLogin},
		success: function(rs){
			var obj = $.parseJSON(rs);
			//console.log(obj);
			
			if(obj.code == 0){
				if(isAutoLogin == 'Y'){
					setCookie("alogin", "Y");
				}
				
				location.href = '<%=referer%>';				
			}else{
				alert(obj.msg);
			}
		}
	});
	
}

function send_login_fb(){
	FB.login(function(response) {
		   if (response.authResponse) {			   
			   FB.api('/me', function(data){
				   
				   var email = data.email;
				   var gender = data.gender;
				   var id = data.id;
				   var birthday = data.birthday;
				   var name = data.name;
				   
				   if(gender == 'male'){ gender = 'M'; }
				   if(gender == 'female'){ gender = 'F'; }
				   
				   birthday =  birthday.split('/')[2];
				   
				   
				   $.ajax({			
						url: '${contextPath}/___/renew/loginprocfb',
						type : 'post',
						data: { email : email, facebook_id : id },
						success: function(rs){
							var obj = $.parseJSON(rs);
							
							if(obj.code == 0){
								alert(obj.msg);
							}else{
								alert(obj.msg);
							}
						}
					});
				   
			   });
		   }else{
			   //location.href = 'https://graph.facebook.com/oauth/authorize?client_id=1427018384229922&scope=email,user_birthday&redirect_uri=http://givus.co.kr/___/renew/join&display=popup';
			   window.open('https://www.facebook.com/login.php?skip_api_login=1&api_key=724203754269433&signed_next=1&next=https%3A%2F%2Fwww.facebook.com%2Fv2.0%2Fdialog%2Foauth%3Fredirect_uri%3Dhttp%253A%252F%252Fstatic.ak.facebook.com%252Fconnect%252Fxd_arbiter%252FDhmkJ2TR0QN.js%253Fversion%253D41%2523cb%253Df23b3059b%2526domain%253Dgivus.co.kr%2526origin%253Dhttp%25253A%25252F%25252Fgivus.co.kr%25252Ff16922b864%2526relation%253Dopener%2526frame%253Df216dec7cc%26display%3Dpopup%26scope%3Dpublic_profile%252C%2Bfriends_birthday%252Cuser_birthday%26response_type%3Dtoken%252Csigned_request%26domain%3Dgivus.co.kr%26client_id%3D724203754269433%26ret%3Dlogin%26sdk%3Djoey&cancel_uri=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter%2FDhmkJ2TR0QN.js%3Fversion%3D41%23cb%3Df23b3059b%26domain%3Dgivus.co.kr%26origin%3Dhttp%253A%252F%252Fgivus.co.kr%252Ff16922b864%26relation%3Dopener%26frame%3Df216dec7cc%26error%3Daccess_denied%26error_code%3D200%26error_description%3DPermissions%2Berror%26error_reason%3Duser_denied%26e2e%3D%257B%257D&display=popup'
				,'fb_login_pop'	   
			    ,'width=600,height=400'
			   );
		   }
	 },{ scope : 'email, user_birthday' });
}

</script>
<%@include file="../inc/fbsdk.jsp" %>
<title></title>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="content">
		<div class="login_container">
			<h4 class="login_title">로그인</h4>
			<form method="post" name="login" id="login">
				<div class="login_box">		
					<div class="title">이메일로 로그인하기</div>
					<div class="input">
						<input type="text" class="login_input" id="email">
					</div>
					<div class="title">비밀번호</div>
					<div class="input">
						<input type="password" class="login_input" id="pass">
					</div>
					<div class="auto_login">
						<input type="checkbox" class="autoLoginchk" id="autoLogin">
						<label for="autoLogin">자동 로그인</label>
					</div>
					<div class="login_btns">
						<a href="javascript:send_login();" class="btn login skyblue">GIVUS 로그인</a>								
					</div>
					<div class="login_btn_line"></div>
					<div class="login_btns">
						<a href="javascript:send_login_fb();" class="btn login darkblue">facebook 로그인</a>								
					</div>			
				</div>
			</form>
			<div class="member_btns">
				<a href="${contextPath }/___/renew/find" class="first">비밀번호 찾기</a>
				<a href="${contextPath }/___/renew/join">회원가입하기</a>
			</div>
			<div class="clear"></div>
		</div>
		
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>