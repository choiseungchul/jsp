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
	$('.m4').addClass('sub on');
});

function rv_srch_btn(){
	if($('#rv_search').val() == '') {
		alert('검색어를 입력해주세요.');
		return;
	}
	
	var cate = $('#category option:selected').val();
	
	location.href = '${contextPath }/___/renew/board/<%=bid%>?PN=0&CT='+cate+'&QR=' + $('#rv_search').val();
	
}
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
				<li class="divide"><a href="${contextPath}/___/renew/board/attendance">출석게시판</a></li>
				<li class="on"><a href="${contextPath}/___/renew/board/list/30">성형전게시판</a></li>
				<li class=""><a href="${contextPath}/___/renew/board/list/31">성형후게시판</a></li>
			</ul>
		</div><!-- hospital_tab -->
		
		<div class="category">
			<a href="${contextPath }/___/renew/board/list/<%=bid%>?PN=0" class="<% if(categoryId.equals("")) out.print("on"); %>">[전체]</a>
			<% 
				for(int i = 0 ; i < cate.size() ; i++){
					if(cate.get(i).get("id").toString().equals(categoryId)){
			%>
			<a href="${contextPath }/___/renew/board/list/<%=bid%>?PN=0&CT=<%=cate.get(i).get("id") %>" class="on">[<%=cate.get(i).get("name") %>]</a>
			<%	
					}else{
			%>
			<a href="${contextPath }/___/renew/board/list/<%=bid%>?PN=0&CT=<%=cate.get(i).get("id") %>" class="">[<%=cate.get(i).get("name") %>]</a>
			<%} }%>
		</div>
		<div class="review_search">
			<span class="mr17"><img src="${contextPath }/img/hospital/cate_search_sq.png" class="input_sq_img">카테고리</span>
			<span>
				<select id="category">
					<option value="0">전체</option>
					<% 
						for(int i = 0 ; i < cate.size() ; i++){
							if(cate.get(i).get("id").toString().equals(categoryId)){
					%>
					<option value="<%=cate.get(i).get("id")%>" selected="selected"><%=cate.get(i).get("name") %></option>
					<%
							}else{
					%>
					<option value="<%=cate.get(i).get("id")%>"><%=cate.get(i).get("name") %></option>
					<%}} %>
				</select>
			</span>		
			<span class="mr17 srch_btn"><img src="${contextPath }/img/hospital/cate_search_sq.png" class="input_sq_img">검색어</span>
			<span>
				<input type="text" id="rv_search" value="<%=query%>">
			</span>		
			<span class="rv_srch_btn" onclick="rv_srch_btn();">검색</span>
		</div>
		<div class="rv_board_sort">
			<a href="">+ 최신순</a>
			<a href="">+ 조회순</a>
		</div>
		
		<div class="post_list">
			<table cellpadding="0" cellspacing="0" class="post_list_tb">
				<colgroup>
					<col width="99">
					<col width="490">
					<col width="134">
					<col width="137">
					<col width="100">
				</colgroup>
				<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>					
				</tr>
				</thead>
				<tbody>
				<%
					for( int i = 0 ; i < get_board_list.size(); i++){
						HashMap<String, Object> data = get_board_list.get(i);
						
						int num = totalCnt - i - (pnum * 10);
						String dateStr = DateUtil.formatDate((Date)data.get("createDate"), "yyyy.MM.dd");
				%>
				<tr>
					<td><%=num %></td>
					<td class="subject">
						<a href="${contextPath }/___/renew/board/view/<%=data.get("id")%>?TP=<%=bid%>&CI=<%=categoryId%>">[<%=data.get("cname") %>]<%=data.get("subject") %></a>
						<%
							int commentCount = (Integer)data.get("commentCount");
							if(commentCount > 0){
						%>
							<span class="blue">[<%=commentCount %>]</span>
						<%
							}
						%>
					</td>
					<td><%=data.get("creator") %></td>
					<td><%=dateStr %></td>
					<td><%=data.get("viewCount") %></td>
				</tr>
				<% } %>
				</tbody>
			</table>
		</div>
		
		<div class="review_write">
			<a href="${contextPath }/___/renew/board/write/<%=bid %>" class="btn_bg2">글 작성하기</a>		
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
				<a href="${contextPath }/___/renew/board/list/30?PN=<%=ltPnum %>&QR=<%=query %>" class="btn">&lt;&lt;</a>
				<% }
					int loop = pcount;
					if(loop > pagePerCount) loop = pagePerCount;
					
					for( int a=startIdx ; a < startIdx+loop; a++){					
				%>	
				<%if(pnum == a){ %>	
				<a href="${contextPath }/___/renew/board/list/30?PN=<%=pnum %>&QR=<%=query %>" class="on"><%=a+1 %></a>
				<%}else{ %>
				<a href="${contextPath }/___/renew/board/list/30?PN=<%=a %>&QR=<%=query %>"><%=a+1 %></a>
				<%}//else %>
				<% } %>
				<% if( startIdx+pagePerCount < pcount ) {
					int gtPnum = startIdx + pagePerCount;
				%>
				<a href="${contextPath }/___/renew/board/list/30?PN=<%=gtPnum %>&QR=<%=query %>" class="btn">&gt;&gt;</a>
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