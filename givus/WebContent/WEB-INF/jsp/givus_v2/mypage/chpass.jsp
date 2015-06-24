<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@page import="kr.co.zadusoft.givus.util.GivusUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>

<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/mypage.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
<%

%>
$(document).ready(function(){
	$('.m7').addClass('sub on');
});


function validate(){
	
	var pass = $('#new_pass').val();
	var re_pass = $('#new_pass_re').val();
	
	if(pass == re_pass){
		return true;
	}else{
		return false;
	}
}

function send_chpass(){
	if(validate()){
		var old_pass = $('#old_pass').val();
		var pass = $('#new_pass').val();
		
		if(old_pass != '' && pass != ''){
			
			$.ajax({
				url : '${contextPath}/___/renew/mypage/chpassproc',
				data : { old_pass : $.base64.encode(old_pass), pass : $.base64.encode(pass)  },
				dataType : 'json',
				success: function(data){
					if(data.code == 0){
						alert(msg);
						location.reload();
					}else{
						alert(msg);
					}
				}
			});
			
		}else{
			alert('<%=MessageHandler.getMessage("join.require.message4_1")%>');
		}
	}else{
		alert('<%=MessageHandler.getMessage("join.require.message6")%>');
	}
}

</script>
<%
	if(um != null){
		if(um.getEmail() == null){
			// 로그인안됨
			
%>
<script>
alert('로그인 후 사용해주세요!');
history.back();
</script>
<%
		}
	}
	
%>
<%
	
	
	

%>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	
	<div class="content">
		<div class="left_menu">
			<%@include file="inc/left.jsp" %>		
		</div>
		<div class="right_content">
			<h2>기본정보 변경</h2>
			<div class="myinfo_tb">
				<h3>기존 비밀번호</h3>
				<div class="myinfo_addr">
					<input type="password" class="addr_input" id="old_pass"> 
				</div>
				<div class="myinfo_line mt13"></div>
				<h3 class="pt21">새 비밀번호</h3>
				<div class="myinfo_addr">
					<input type="password" class="addr_input" id="new_pass"> 
				</div>
				<h3 class="pt13">비밀번호 확인</h3>
				<div class="myinfo_addr">
					<input type="password" class="addr_input" id="new_pass_re"> 
				</div>
				
				<div class="pass_alert">- 비밀번호는 최소 8글자 이상으로 작성하세요.</div>
				
			</div><!-- myinfo_tb -->
			<div class="myinfo_btns">
				<a href="javascript:send_chpass();" class="btn_myinfo_send on">변경</a>
				<a href="" class="btn_myinfo_send">취소</a>
			</div>
		</div><!-- right_content -->
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>