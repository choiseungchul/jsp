<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/intro.css?noc=<%=System.currentTimeMillis() %>" />
<script type="text/javascript">
$( document ).click(function() {
  $( ".bottom_arrow" ).toggle( "bounce", { times: 3 }, "slow" );
});
</script>
<title>순위방식</title>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top_nofix.jsp"%>
<div class="wrapper clear">	
	<div class="about_container">
		<div class="about_bg bg1">
			<div class="text_title">
				<p><img src="${contextPath }/img/intro/about_text_1_1.png"></p>
				<p><img src="${contextPath }/img/intro/about_text_1_2.png"></p>
			</div>
			<div class="bottom_arrow">
				<img alt="" src="${contextPath }/img/intro/down_arrow.png">
			</div>
		</div>
	</div>
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>