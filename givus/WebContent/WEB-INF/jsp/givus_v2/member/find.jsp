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
	
});
</script>
<title></title>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="content">
		<div class="find_pass_input">
			<h3>비밀번호찾기</h3>
			<div class="find_pass_box">
				<div class="title">이메일로 비밀번호 재설정</div>
				<div class="input">
					<input type="text" class="login_input">
				</div>
			</div>
		</div>
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>