<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">

$(document).ready(function(){
	
});

</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title pt25">
		<h1>병원등록</h1>
	</div>
	<div class="content">
	
		<div class="hospital_tab add_form">
			<ul>
				<li class="divide"><span>STEP 01.</span><strong>기본정보등록</strong></li>
				<li class="divide"><span>STEP 02.</span><strong>병원소개등록</strong></li>
				<li class="on white"><span>STEP 03.</span><strong>등록완료</strong></li>
			</ul>
		</div>
		
		<div class="hos_add_complete">
			<div class="left hos_add_comp_img">
				<img alt="" src="${contextPath }/img/hospital/hos_complete_img.png">
			</div>
			<div class="left hos_add_comp_desc">
				<h3>등록이 완료되었습니다.</h3>
				<div class="hos_add_cp_text1">
					<p>전화 확인 후</p>
					<p>서비스를 이용하실 수 있습니다.</p>
				</div>
				<div class="hos_add_cp_text2">
					<p>전화확인 후 가입승인 처리기간은 1~2일 정도 소요됩니다.</p>
					<p>가입승인은 등록하신 이메일로 확인 하실 수 있습니다.</p>
				</div>
			</div>
		</div>
		
		<div class="add_hos_btns clear">
			<a href="${contextPath }/___/renew/main" class="btn_myinfo_send on">GIVUS 홈</a>			
		</div>
		
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>