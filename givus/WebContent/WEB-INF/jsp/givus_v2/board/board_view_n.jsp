<%@page import="dynamic.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	
	int bid = (Integer)request.getAttribute("bid");
	String cid = (String)request.getAttribute("cid");
	String type = (String)request.getAttribute("type");

	HashMap<String, Object> data = (HashMap<String, Object>)request.getAttribute("board");
	
	HashMap<String, Object> prevId = request.getAttribute("prevId") == null ? null : (HashMap<String, Object>)request.getAttribute("prevId");
	HashMap<String, Object> nextId = request.getAttribute("nextId") == null ? null : (HashMap<String, Object>)request.getAttribute("nextId");
	
	Date date = (Date)data.get("createDate");
	String f_date = DateUtil.formatDate(date, DateUtil.YYYYMMDDHHMM);
	
	String CM = request.getParameter("CM");
	
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/board.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	<% if ( CM == null ){ %>
	loadMore(<%=bid%>,0 ,'commlist');
	<%  }%>
	
	$('.m4').addClass('sub on');
});

</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title pt25">
		<h1>게시판</h1>
	</div>
	
	<div class="content">
		<div class="hospital_tab">
			<ul>
				<%
					if(bid == 15){
				%>
				<li class="on"><a href="${contextPath}/___/renew/board/15">공지사항</a></li>
				<li class="divide"><a href="${contextPath}/___/renew/board/33">자주묻는 질문</a></li>
				<li class=""><a href="${contextPath}/___/renew/board/34">1:1문의</a></li>
				<%	
					}else if(bid == 33){
				%>
				<li class="divide"><a href="${contextPath}/___/renew/board/15">공지사항</a></li>
				<li class="on"><a href="${contextPath}/___/renew/board/33">자주묻는 질문</a></li>
				<li class=""><a href="${contextPath}/___/renew/board/34">1:1문의</a></li>
				<%	
					}else if(bid == 34){
				%>
				<li class="divide"><a href="${contextPath}/___/renew/board/15">공지사항</a></li>
				<li class="divide"><a href="${contextPath}/___/renew/board/33">자주묻는 질문</a></li>
				<li class="on"><a href="${contextPath}/___/renew/board/34">1:1문의</a></li>
				<%			
					}
				%>				
			</ul>
		</div><!-- hospital_tab -->
	
		<div class="review_board pt45">
			<table cellpadding="0" cellspacing="0" class="review_board_tb">
				<colgroup>
					<col width="140">
					<col width="500">
					<col width="140">
					<col width="179">
				</colgroup>		
				<tbody>		
				<tr>
					<td class="tit">제목</td>
					<td class="subject">
						[<%=data.get("cname") %>]		
					<%=data.get("subject") %>
					<% if(data.get("commentCount") != null) {
							int commCount = (Integer)data.get("commentCount");
							if(commCount > 0){
						%> 
					<span class="blue">[<%=commCount %>]</span>
					<%}} %>
					</td>
					<td class="tit">작성자</td>
					<td><%=data.get("creator") %></td>
				</tr>
				<tr>
					<td class="tit">날짜</td>
					<td class="subject"><%=f_date %></td>
					<td class="tit">조회수</td>
					<td><%=data.get("viewCount") %></td>
				</tr>				
				<tr>
					<td colspan="4" class="contents_td"><%=data.get("contents") %></td>
				</tr>
				<%if(nextId != null) {
					Date cdate = (Date)nextId.get("createDate");
					String formatted = DateUtil.formatDate(cdate, DateUtil.YYYYMMDD);
				%>
				<tr>
					<td class="brd_next tit">다음글</td>
					<td colspan="2" class="subject">
						<a href="${contextPath }/___/renew/board/viewn/<%=nextId.get("id")%>?TP=<%=type%>&CI=<%=cid%>"><%=nextId.get("subject") %></a>
						<% if(nextId.get("commentCount") != null) {
								int commCount = (Integer)nextId.get("commentCount");
								if(commCount > 0){
							%> 
						<span class="blue">[<%=commCount %>]</span>
						<%}} %>
					</td>
					<td><%=formatted %></td>
				</tr>		
				<%} %>
				<% if(prevId != null) {
					Date cdate = (Date)prevId.get("createDate");
					String formatted = DateUtil.formatDate(cdate, DateUtil.YYYYMMDD);
				%>
				<tr>
					<td class="brd_prev tit">이전글</td>
					<td colspan="2" class="subject">
						<a href="${contextPath }/___/renew/board/viewn/<%=prevId.get("id")%>?TP=<%=type%>&CI=<%=cid%>"><%=prevId.get("subject") %></a>
						<% if(prevId.get("commentCount") != null) {
								int commCount = (Integer)prevId.get("commentCount");
								if(commCount > 0){
							%> 
						<span class="blue">[<%=commCount %>]</span>
						<%}} %>
					</td>
					<td><%=formatted %></td>
				</tr>
				<%} %>
				</tbody>
			</table>
			<div class="board_btns">				
				<a href="${contextPath }/___/renew/board/list/<%=type %>" class="btn_bg3">목록보기</a>
			</div>
			
			<%-- 댓글로딩 --%>
			<%
				if(CM == null){
			%>
			<%@include file="inc/board_comment.jsp" %>
			<% } %>	
		</div>
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>