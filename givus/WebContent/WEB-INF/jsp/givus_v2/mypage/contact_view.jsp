<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<%

	HashMap<String, Object> contact = (HashMap<String, Object>)request.getAttribute("contact");

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
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/mypage.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	$('.m7').addClass('sub on');
});
</script>
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
			<h2>나의문의 내역</h2>
			
			<div class="board_write">
				<table cellpadding="0" cellspacing="0" class="board_write_tb">
					<colgroup>
						<col width="140">
						<col width="820">			
					</colgroup>
					<tbody>
					<tr>
						<td class="tit">제목</td>
						<td>
							<div><%=contact.get("subject") %></div>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="input_editor">
					<div class="view_content"><%=contact.get("contents") %></div>
				</div>	
				<div class="input_submit">
					<a href="javascript:history.back();" class="btn_bg3">목록으로</a>
				</div>
			</div>

		</div>
		
		
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>