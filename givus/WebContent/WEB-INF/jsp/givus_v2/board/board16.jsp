<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	List<HashMap<String, Object>> cate = (List<HashMap<String, Object>>)request.getAttribute("cate");

	int bid = (Integer)request.getAttribute("bid");
	int totalCnt = (Integer)request.getAttribute("total");
	int pnum = (Integer)request.getAttribute("pnum");
	int pageCount = 30;
	int pagePerCount = 10;
	
	List<HashMap<String, Object>> get_board_list = (List<HashMap<String, Object>>)request.getAttribute("list");
	String categoryId = request.getAttribute("cateid").toString();
	String query = request.getAttribute("query").toString();

%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/board.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	$('td.n_slide_btn').click(function(){
		var idx = $('td.n_slide_btn').index(this);
		
		if($('.n_sd_btn').eq(idx).hasClass('down')){
			$('.n_sd_btn').eq(idx).removeClass('down').addClass('up');
			
			$(this).parent('tr').next().show();
		}else{
			$('.n_sd_btn').eq(idx).removeClass('up').addClass('down');
			
			$(this).parent('tr').next().hide();
		}
	});
	
	$('.m4').addClass('sub on');
});

function loginRequire(){
	alert('<%=MessageHandler.getMessage("posting.msg.recommend_needlogin")%>');
	location.href='${contextPath}/___/renew/login';
}
</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title pt25">
		<h1>자주묻는 질문</h1>
	</div>
	<div class="content">
		<div class="hospital_tab">
			<ul>
				<li class="divide"><a href="${contextPath}/___/renew/board/list/15">공지사항</a></li>
				<li class="on"><a href="${contextPath}/___/renew/board/list/16">자주묻는 질문</a></li>
				<%
					if(um.getEmail() != null){
				%>
				<li class=""><a href="${contextPath}/___/renew/board/contact">1:1문의</a></li>
				<% }else{ %>
				<li class=""><a href="javascript:loginRequire()">1:1문의</a></li>
				<% } %>
			</ul>
		</div><!-- hospital_tab -->
		
		<div class="notice_board">
			<table cellpadding="0" cellspacing="0" class="notice_board_tb">
				<colgroup>
					<col width="43">
					<col width="719">
					<col width="143">
					<col width="55">
				</colgroup>
				<tbody>
				<%
					for( int i = 0 ; i < get_board_list.size(); i++){
						HashMap<String, Object> data = get_board_list.get(i);
						
						String dateStr = DateUtil.formatDate((Date)data.get("createDate"), "yyyy.MM.dd");
				%>
				<tr>
					<td class="n_icon">Q.</td>
					<td class="n_subject"><%=data.get("subject") %></td>
					<td class="n_date"><%=dateStr %></td>
					<td class="n_slide_btn">
						<span class="n_sd_btn down"></span>
					</td>
				</tr>
				<tr style="display: none;">	
					<td class="n_icon red">A.</td>
					<td class="n_content" colspan="3"><%=data.get("contents") %></td>
				</tr>
				<% } %>
				</tbody>
			</table>
		</div>
		
		<%--페이징 처리 --%>
			<%
				if(totalCnt > pageCount){
					int pcount = (int)(totalCnt / pageCount) + 1;
					
					int startIdx = pnum - ( pnum % pageCount);
					
					if(totalCnt %pageCount == 0) pcount--;
					
					int ppcount = (int)(totalCnt / pageCount) / pagePerCount;			
			%>	
			<div class="page_navi">
				<% if(startIdx+1 > pagePerCount) {
					int ltPnum = startIdx - pagePerCount;
					
					%>
				<a href="${contextPath }/___/renew/board/list/16?PN=<%=ltPnum %>&QR=<%=query %>" class="btn">&lt;&lt;</a>
				<% }
					int loop = pcount;
					if(loop > pagePerCount) loop = pagePerCount;
					
					for( int a=startIdx ; a < startIdx+loop; a++){					
				%>	
				<%if(pnum == a){ %>	
				<a href="${contextPath }/___/renew/board/list/16?PN=<%=pnum %>&QR=<%=query %>" class="on"><%=a+1 %></a>
				<%}else{ %>
				<a href="${contextPath }/___/renew/board/list/16?PN=<%=a %>&QR=<%=query %>"><%=a+1 %></a>
				<%}//else %>
				<% } %>
				<% if( startIdx+pagePerCount < pcount ) {
					int gtPnum = startIdx + pagePerCount;
				%>
				<a href="${contextPath }/___/renew/board/list/16?PN=<%=gtPnum %>&QR=<%=query %>" class="btn">&gt;&gt;</a>
				<%} %>
			</div>
			<%} else { %>
			<div class="page_navi">
				<a href="#" class="on">1</a>
			</div>
			<%} %>
		
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>