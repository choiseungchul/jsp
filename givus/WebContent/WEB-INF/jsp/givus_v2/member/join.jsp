<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/member.css?noc=<%=System.currentTimeMillis() %>" />
<script type="text/javascript">
$(document).ready(function(){
	if(!Browser.ie7){
		$('.login_input, .btn.login').corner('5px');	
	}
		
	
	$('input[name=sex]').click(function(){
		sex = $(this).val();
	});
	
	$('#birth').change(function(){
		birth = $('#birth option:selected').val();
	});
});

var sex = '';
var birth = '';

function validate(){
	if($('#email').val() == ''){
		return '<%=MessageHandler.getMessage("join.require.message1")%>';
	}
	
	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
	if(regex.test($('#email').val()) === false) { 
		return '<%=MessageHandler.getMessage("join.require.message2")%>'; 
	}
	if($('#nick').val() == ''){
		return '<%=MessageHandler.getMessage("join.require.message3")%>';
	}
	
	var re = /[~!@\#$%^&*\()\-=+_.,']/gi;
	if(re.test($('#nick').val())){
		return '<%=MessageHandler.getMessage("join.require.message3_1")%>';
	}
	
	if($('#pass').val() == ''){
		return '<%=MessageHandler.getMessage("join.require.message4")%>';
	}
	if($('#repass').val() == ''){
		return '<%=MessageHandler.getMessage("join.require.message4_1")%>';
	}
	if($('#pass').val() != $('#repass').val()){
		return '<%=MessageHandler.getMessage("join.require.message6")%>';
	}
	if($('#pass').val().length < 8 || $('#repass').val().length < 8){
		return '<%=MessageHandler.getMessage("join.require.message5")%>';
	}
	
	if(sex == ''){
		return '<%=MessageHandler.getMessage("join.require.message7")%>';
	}
	if(birth == ''){
		return '<%=MessageHandler.getMessage("join.require.message8")%>';
	}
	
	return 'OK';
}

function send_join(){
	var msg = validate();
	if(msg == 'OK'){
		$.ajax({
			url: '${contextPath}/___/renew/joinproc',
			type : 'post',
			data: { email : $('#email').val(), nick : $('#nick').val(), pass : $.base64.encode($('#pass').val()), 
				gender : $('input[name=sex]:checked').val(), birth : $('#birth option:selected').val() },
			success: function(rs){
				var obj = $.parseJSON(rs);
				//console.log(obj);
				
				if(obj.code == 0){
					alert(obj.msg);
					location.replace('${contextPath}/___/renew/main');
				}else{
					alert(obj.msg);
				}
			}
		});
	}else{
		alert(msg);
	}
}

function send_join_fb(){
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
						url: '${contextPath}/___/renew/joinprocfb',
						type : 'post',
						data: { email : email, nick : name, gender : gender, birth : birthday, facebook_id : id },
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
		<div class="left logos">
			<div class="logo_img">
				<img alt="" src="${contextPath }/img/member/join_logo.png">
			</div>
			<div class="logos_text1">
				<p>안녕하세요.</p>
				<p><strong>GIVUS</strong>입니다.</p>
			</div>
			<div class="logos_text2">
				<p>성형외과 선택의 기준</p>
				<p>GIVUS에 오신 걸 환영합니다.</p>
			</div>
		</div>
		
		<form id="join_form">		
		<div class="left input_table">
			<h4>회원가입</h4>
			<div class="join_box">
				<div class="title">이메일</div>
				<div class="input">
					<input type="text" class="login_input" id="email" maxlength="40">
				</div>
				<div class="title">별명 - <span class="nick_alert">별명은 한글,영문 대소문 1-10자,숫자를 사용할수 있습니다(혼용가능)</span></div>
				<div class="input">
					<input type="text" class="login_input" id="nick" maxlength="15">
				</div>
				<div class="title">비밀번호(8글자이상)</div>
				<div class="input">
					<input type="password" class="login_input" id="pass" maxlength="12">
				</div>
				<div class="title">비밀번호확인</div>
				<div class="input">
					<input type="password" class="login_input" id="repass" maxlength="12">
				</div>
				<div class="input_other">
					<table cellpadding="0" cellspacing="0" class="input_other_tb">
						<colgroup>
							<col width="113">
							<col width="148">
						</colgroup>
						<tbody>
						<tr>
							<td>성별</td>
							<td>
								<label><input type="radio" name="sex" value="M"> 남자</label>	
								<label><input type="radio" name="sex" value="F"> 여자</label>							
							</td>
						</tr>
						<tr>
							<td>태어난해</td>
							<td>
								<select class="birthday_sct" id="birth">
								</select>
								<script type="text/javascript">
									$(function(){
										<%
											Date date = new Date();
											int year = date.getYear();
										%>
										var curr_year = <%=year+1900%>;
										for(var i = curr_year ; i > 1930 ; i--){											
											$('.birthday_sct').append($('<option value="'+i+'">' + i + '년</option>'));											
										}
									});
									
								</script>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
				
				<div class="login_btns">
					<a href="javascript:send_join()" class="btn login skyblue">가입하기</a>				
				</div>
				<div class="login_btn_line"></div>
				<div class="login_btns">
					<a href="javascript:send_join_fb()" class="btn login darkblue">facebook 으로 가입하기</a>								
				</div>	
			</div><!-- join_box -->
			
			<div class="join_btns">
				<a href="${contextPath }/___/renew/login">로그인</a> /
				<a href="${contextPath }/___/renew/privacy-policy" target="_blank">개인정보 취급 방침</a>	
			</div>			
		</div><!-- input_table -->
		</form>
		<div class="clear"></div>
		<div class="member_alert"></div>
	</div><!-- content -->
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>