<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="dynamic.web.util.SessionContext"%>
<%@page import="kr.co.zadusoft.contents.model.UserModel"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dynamic.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>
<%
	int pnum = (Integer)request.getAttribute("p");
	int cateId = (Integer)request.getAttribute("cateId");
	int hid = (Integer)request.getAttribute("hid");
	int totalCnt = (Integer)request.getAttribute("total");
	int pageCount = 30;
	int pagePerCount = 10;
	int type = (Integer)request.getAttribute("type");
	String query = request.getAttribute("query") != null ? request.getAttribute("query").toString() : null;

	List<HashMap<String, Object>> cate = (List<HashMap<String, Object>>)request.getAttribute("cate");
	List<HashMap<String, Object>> board = (List<HashMap<String, Object>>)request.getAttribute("board");
	
	UserModel um = (UserModel)SessionContext.getUserModel();
	
%>
<script>
function loadPage(url){
	$('.review_board').load(url);
}
function rv_srch_btn(){
	if($('#rv_search').val() == '') {
		alert('검색어를 입력해주세요.');
		return;
	}
	
	var cate = $('#category option:selected').val();

	var url = '';
	
	url = '${contextPath }/___/renew/hospital/board_epil/<%=hid%>/'+cate+'/1/<%=type%>?srch=' + $('#rv_search').val();
	
	loadPage(url);
}
$(function(){
	$('#rv_search').keyup(function(e){
		if(e.which === 13){
			rv_srch_btn();
		}
	});
});
</script>
<div class="category">
	<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid%>/0/1/<%=type %>')" class="<% if(cateId == 0) out.print("on");%>">[전체]</a>
	<% 
		for(int i = 0 ; i < cate.size() ; i++){
	%>
	<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid%>/<%=cate.get(i).get("id")%>/1/<%=type %>');" <% if( cate.get(i).get("id").toString().equals(String.valueOf(cateId))) out.print("class=\"on\"");%>>[<%=cate.get(i).get("name") %>]</a>
	<%} %>
</div>
<div class="review_search">
	<span class="mr17"><img src="${contextPath }/img/hospital/cate_search_sq.png" class="input_sq_img">카테고리</span>
	<span>
		<select id="category">
			<option value="0" selected="selected">전체</option>
			<%
				for( int i = 0 ; i < cate.size() ; i++){
			%>
			<option value="<%=cate.get(i).get("id") %>"><%=cate.get(i).get("name") %></option>
			<%} %>
		</select>
	</span>		
	<span  class="mr17 srch_btn"><img src="${contextPath }/img/hospital/cate_search_sq.png" class="input_sq_img">검색어</span>
	<span>
		<input type="text" id="rv_search">
	</span>		
	<span class="rv_srch_btn" onclick="rv_srch_btn();">검색</span>
</div>
<div class="review_board">
	<div class="rv_board_sort">
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid%>/<%=cateId%>/1/<%=type %><%if(query != null ) out.print("?srch=" + query);%>')">+ 최신순</a>
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid%>/<%=cateId%>/1/<%=type %>?sorting=1<%if(query != null ) out.print("&srch=" + query);%>')">+ 조회순</a>
	</div>
	<table cellpadding="0" cellspacing="0" class="review_board_tb">
		<colgroup>
			<col width="66">
			<col width="334">
			<col width="92">
			<col width="98">
			<col width="67">
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
		
		int stIdx = totalCnt - (pnum-1)*pageCount;
		
		String xpath = hid + "/" + cateId + "/" + pnum + "/" + type;
		if(query != null) xpath += "?srch="+query;
		xpath = URLEncoder.encode(xpath, "UTF-8");
		
		if(board.size() > 0){
			for( int i = 0 ; i < board.size(); i++){
				HashMap<String, Object> data = board.get(i);
				
				Date date = (Date)data.get("createDate");
				String f_date = DateUtil.formatDate(date, DateUtil.YYYYMMDD);
				int vcnt = (Integer)data.get("viewCount");
				
				String cmm = "";
				
				if(data.get("commentCount") != null){
					cmm = "<span class='skyblue'>[" + data.get("commentCount").toString() + "]</span>";
				}
				String subject = data.get("subject").toString();
				
				if(subject.length() > 20){
					subject = subject.substring(0, 20) + "...";
				}
		%>
		<tr>
			<td class="fs13"><%=(stIdx-i)%></td>
			<td class="subject"><a href="javascript:loadPage('${contextPath }/___/renew/hospital/boardview/<%=data.get("id")%>?xpath=<%=xpath%>');">
			[<%=data.get("cname") %>]
			<%=subject %>
			<% if(data.get("commentCount") != null) {
					if(!data.get("commentCount").equals("0")) {
				%> 
			<span class="blue">[<%=data.get("commentCount") %>]</span>
			<%}} %>
			</a></td>
			<td class="fs11"><%=data.get("creator") %></td>
			<td class="fs11"><%=f_date %></td>
			<td class="fs11"><%=vcnt %></td>
		</tr>
		<%
			}//for
		}else{ %>
		<tr>
			<td colspan="5" align="center">게시물이 없습니다.</td>
		</tr>
		<%} %>
		</tbody>
	</table>
	
	<div class="review_write">		
		<%
		if(um != null){
			if(um.getEmail() != null){
		%>
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board/write?type=<%=type %>&hid=<%=hid %>');" class="btn_bg2">글 작성하기</a>
		<%		
			}else{
		%>
		<a href="javascript:alert('<%=MessageHandler.getMessage("posting.msg.recommend_needlogin") %>');" class="btn_bg2">글 작성하기</a>
		<%
			}
		}
		%>		
	</div>
	
	<%
		if(totalCnt > pageCount){
			int pcount = (int)(totalCnt / pageCount) + 1;
			if(totalCnt %pageCount == 0) pcount--;
			
			int startIdx = (((pnum-1)/pagePerCount)*pagePerCount) + 1;
			
			int ppcount = (int)(totalCnt / pageCount) / pagePerCount;			
	%>	
	<div class="page_navi pd60">
		<% if(startIdx > pagePerCount) {
			int ltPnum = startIdx - pagePerCount;
			%>
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid%>/<%=cateId%>/<%=ltPnum%>/<%=type %>');" class="btn">&lt;&lt;</a>
		<% }
			int loop = pcount;
			if(loop > pagePerCount) loop = pagePerCount;
			
			for( int a=startIdx ; a < startIdx + loop; a++){				
		%>	
		<%if(pnum == a){ %>	
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid%>/<%=cateId%>/<%=pnum %>/<%=type %>');" class="on"><%=pnum %></a>
		<%}else{ %>
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid%>/<%=cateId%>/<%=a %>/<%=type %>');"><%=a %></a>
		<%}//else %>
		<% } %>
		<% if( startIdx+pagePerCount < pcount ) {
			int gtPnum = startIdx + pagePerCount;
		%>
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid%>/<%=cateId%>/<%=gtPnum %>/<%=type %>');" class="btn">&gt;&gt;</a>
		<%} %>
	</div>
	<%} else { %>
	<div class="page_navi pd60">
		<a href="javascript:" class="on">1</a>
	</div>
	<%} %>
</div>