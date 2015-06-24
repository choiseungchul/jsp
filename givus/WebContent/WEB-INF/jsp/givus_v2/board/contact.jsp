<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@page import="kr.co.zadusoft.givus.util.GivusUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>

<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/board.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	$('.m4').addClass('sub on');
});

function loginRequire(){
	alert('<%=MessageHandler.getMessage("posting.msg.recommend_needlogin")%>');
	location.href='${contextPath}/___/renew/login';
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
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title pt25">
		<h1>1:1 문의</h1>
	</div>
	<%
		
		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)request.getAttribute("list");
	
		int total = (Integer)request.getAttribute("total");
		int pnum = (Integer)request.getAttribute("pnum");
		int pageCount = 30;
		int pagePerCount = 10;
	
	%>
	<div class="content">
		<div class="hospital_tab">
			<ul>
				<li class="divide"><a href="${contextPath}/___/renew/board/list/15">공지사항</a></li>
				<li class="divide"><a href="${contextPath}/___/renew/board/list/16">자주묻는 질문</a></li>
				<%
					if(um.getEmail() != null){
				%>
				<li class="on"><a href="${contextPath}/___/renew/board/contact">1:1문의</a></li>
				<% }else{ %>
				<li class="on"><a href="javascript:loginRequire()">1:1문의</a></li>
				<% } %>
			</ul>
		</div><!-- hospital_tab -->
		
		<div class="notice_board pt45">				
			<table cellpadding="0" cellspacing="0" class="contact_board_tb">
				<colgroup>
					<col width="100">
					<col width="743">
					<col width="117">
				</colgroup>
				<thead>
				<tr>
					<th>번호</th>
					<th class="subject">제목</th>							
					<th>날짜</th>					
				</tr>
				</thead>
				<tbody>
				<% 
					for(int i = 0 ; i < list.size(); i++){
						HashMap<String, Object> data = list.get(i);
						
						int num = total  - (pnum * 30) - i;
						String dateStr = DateUtil.formatDate((Date)data.get("createDate"), "yyyy.MM.dd");
				%>
				<tr>
					<td><%=num %></td>
					<td class="subject">
						<a href="${contextPath }/___/renew/mypage/contact/view/<%=data.get("id")%>">
						<%=data.get("subject").toString() %>							
						</a>
					</td>
					<td><%=dateStr %></td>						
				</tr>					
				<% } %>
				</tbody>
			</table>
		</div>
		
		<div class="review_write">
			<a href="${contextPath }/___/renew/mypage/contact/write" class="btn_bg2">글 작성하기</a>		
		</div>
			
		<%--페이징 처리 --%>
		<%
			int totalCnt = total;
		
			if(totalCnt > pageCount){
				int pcount = (int)(totalCnt / pageCount) + 1;
				
				int startIdx = pnum - ( pnum % pageCount);
				
				if(totalCnt %pageCount == 0) pcount--;
				
				int ppcount = (int)(totalCnt / pageCount) / pagePerCount;			
		%>	
		<div class="page_navi clear">
			<% if(startIdx+1 > pagePerCount) {
				int ltPnum = startIdx - pagePerCount;
				
				%>
			<a href="${contextPath }/___/renew/board/contact?PN=<%=ltPnum %>" class="btn">&lt;&lt;</a>
			<% }
				int loop = pcount;
				if(loop > pagePerCount) loop = pagePerCount;
				
				for( int a=startIdx ; a < startIdx+loop; a++){					
			%>	
			<%if(pnum == a){ %>	
			<a href="${contextPath }/___/renew/board/contact?PN=<%=pnum %>" class="on"><%=a+1 %></a>
			<%}else{ %>
			<a href="${contextPath }/___/renew/board/contact?PN=<%=a %>"><%=a+1 %></a>
			<%}//else %>
			<% } %>
			<% if( startIdx+pagePerCount < pcount ) {
				int gtPnum = startIdx + pagePerCount;
			%>
			<a href="${contextPath }/___/renew/board/contact?PN=<%=gtPnum %>" class="btn">&gt;&gt;</a>
			<%} %>
		</div>
		<%} else { %>
		<div class="page_navi clear">
			<a href="javascript:" class="on">1</a>
		</div>
		<%} %>
			
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>