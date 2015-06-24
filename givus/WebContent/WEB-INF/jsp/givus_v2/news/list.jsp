<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	List<HashMap<String, Object>> newsList = (List<HashMap<String, Object>>)request.getAttribute("newsList");

	int pnum = (Integer)request.getAttribute("p");
	int totalCnt = (Integer)request.getAttribute("total");
	int pageCount = 30;
	int pagePerCount = 10;
	
	String query = request.getAttribute("QR") == null ? "" : request.getAttribute("QR").toString();
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/news.css?noc=<%=System.currentTimeMillis() %>" />
<script type="text/javascript">
$(document).ready(function(){
	$('.ranklist').load('${contextPath}/___/renew/tile/rankbox');
	$('.popular_news').load('${contextPath}/___/renew/tile/newsbox');
	
	$('#search').keyup(function(e){
		if(e.which === 13){
			srch_btn();
		}
	});
	
	$('td.subject a, .rb_rl_name a').live('click',function(){
		var url = $(this).attr('href');
		var bid = $(this).attr('data-id');
		$.ajax({
			url : '${contextPath}/___/renew/news/addcnt/' + bid,
			success:function(rs){							
			}
		});		
	});
	
	$('.m3').addClass('sub on');
});

function srch_btn(){
	var srch = $('#search').val();
	if(srch != ''){
		location.href = '${contextPath}/___/renew/news/list?PN=0&QR=' + encodeURIComponent(srch);
	}else{
		aler('검색어를 입력하세요.');
	}
}

</script>
<title></title>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title pt25">
		<h1>성형뉴스</h1>
	</div>
	<div class="content">
		<div class="hospital_cont left">
			<!-- 
			<div class="hospital_tab">
				<ul>
					<li class="on"><a href="${contextPath}/___/renew/news/list">전체기사</a></li>
					<li class="divide"><a href="javascript:alert_not_ready();">성형외과</a></li>
					<li class="divide"><a href="javascript:alert_not_ready();">인터뷰기사</a></li>
					<li class="divide"><a href="javascript:alert_not_ready();">성형.미용정보</a></li>
					<li><a href="javascript:alert_not_ready();">피해,소송</a></li>
				</ul>
			</div>
			 -->
			<div class="rv_board_sort">
				<a href="${contextPath }/___/renew/news/list?PN=<%=pnum %>&QR=<%=query %>&ST=d">+ 최신순</a>
				<a href="${contextPath }/___/renew/news/list?PN=<%=pnum %>&QR=<%=query %>&ST=v">+ 조회순</a>
			</div>
			
			<div class="news_list">
				<table cellpadding="0" cellspacing="0" class="news_list_tb">
					<colgroup>
						<col width="480">
						<col width="67">
						<col width="110">
					</colgroup>
					<tbody>
					<%
						for(int i = 0 ; i < newsList.size(); i++){

							HashMap<String, Object> data = newsList.get(i);
							Date cdate = (Date)data.get("createDate");
							String dateString = DateUtil.formatDate(cdate, "yyyy.MM.dd HH:mm");
							
							if(data.get("customField1") != null && data.get("referenceURL") != null){
					%>
					<tr>
						<td class="subject"><a href="<%=data.get("referenceURL")%>" data-id="<%=data.get("id") %>" target="_blank"><%=data.get("subject").toString() %></a></td>
						<td class="news_author"><%=data.get("customField1") == null ? "" : data.get("customField1")%></td>
						<td class="date"><%=dateString%></td>
					</tr>
					<% 	} %>
					<% } %>
					</tbody>
				</table>
			</div>
			
			<%--페이징 처리 --%>
			<%
				if(totalCnt > pageCount){
					int pcount = (int)(totalCnt / pageCount) + 1;
					
					int startIdx = (((pnum-1)/pagePerCount)*pagePerCount) + 1;
					
					if(totalCnt %pageCount == 0) pcount--;
					
					int ppcount = (int)(totalCnt / pageCount) / pagePerCount;			
			%>	
			<div class="page_navi">
				<% if(startIdx > pagePerCount) {
					int ltPnum = startIdx - pagePerCount;
					
					%>
				<a href="${contextPath }/___/renew/news/list?PN=<%=ltPnum %>&QR=<%=query %>" class="btn">&lt;&lt;</a>
				<% }
					int loop = pcount;
					if(loop > pagePerCount) loop = pagePerCount;
					
					for( int a=startIdx ; a < startIdx+loop; a++){					
				%>	
				<%if(pnum == a){ %>	
				<a href="${contextPath }/___/renew/news/list?PN=<%=pnum %>&QR=<%=query %>" class="on"><%=a %></a>
				<%}else{ %>
				<a href="${contextPath }/___/renew/news/list?PN=<%=a %>&QR=<%=query %>"><%=a %></a>
				<%}//else %>
				<% } %>
				<% if( startIdx+pagePerCount < pcount ) {
					int gtPnum = startIdx + pagePerCount;
				%>
				<a href="${contextPath }/___/renew/news/list?PN=<%=gtPnum %>&QR=<%=query %>" class="btn">&gt;&gt;</a>
				<%} %>
			</div>
			<%} else { %>
			<div class="page_navi">
				<a href="#" class="on">1</a>
			</div>
			<%} %>
			
			<%-- 검색 --%>
			<div class="board_search">
				<img alt="" src="${contextPath }/img/hospital/cate_search_sq.png">
				<span>기사검색</span>
				<input type="text" id="search" value="<%=query%>">
				<a href="javascript:srch_btn()" class="btn search">검색</a>
			</div>
			
		</div>
		
		
		<div class="hospital_aside left">
			<div class="popular_news"></div>
			<div class="ranklist"></div>
		</div><!-- hospital_aside -->
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>