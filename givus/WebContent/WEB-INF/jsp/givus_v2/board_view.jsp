<%@page import="java.net.URLDecoder"%>
<%@page import="dynamic.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="kr.co.zadusoft.contents.model.UserModel" %>
<%@page import="dynamic.web.util.SessionContext" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>
<%

	String xpath = request.getAttribute("blist_path").toString();
	
	HashMap<String, Object> data = (HashMap<String, Object>)request.getAttribute("board");
	
	HashMap<String, Object> prevId = request.getAttribute("prevId") == null ? null : (HashMap<String, Object>)request.getAttribute("prevId");
	HashMap<String, Object> nextId = request.getAttribute("nextId") == null ? null : (HashMap<String, Object>)request.getAttribute("nextId");
	

	Date date = (Date)data.get("createDate");
	String f_date = DateUtil.formatDate(date, DateUtil.YYYYMMDDHHMM);
	
	UserModel um = (UserModel)SessionContext.getUserModel();
	
%>

<div class="review_board">
	<table cellpadding="0" cellspacing="0" class="review_board_tb">
		<colgroup>
			<col width="109">
			<col width="313">
			<col width="110">
			<col width="125">
		</colgroup>		
		<tbody>		
		<tr>
			<td>제목</td>
			<td colspan="3" class="subject">
			[<%=data.get("cname") %>]		
			<%=data.get("subject") %>
			<% if(data.get("commentCount") != null) {
					if(!data.get("commentCount").equals("0")) {
				%> 
			<span class="blue">[<%=data.get("commentCount") %>]</span>
			<%}} %>
			</td>
		</tr>
		<tr>
			<td class="tit">날짜</td>
			<td colspan="3" class="cont"><%=f_date %></td>
		</tr>
		<tr>
			<td class="tit">작성자</td>
			<td class="cont"><%=data.get("creator") %></td>
			<td class="tit">조회수</td>
			<td class="cont"><%=data.get("viewCount") %></td>
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
			<td colspan="2" class="subject"><a href="javascript:loadPage('${contextPath}/___/renew/hospital/boardview/<%=nextId.get("id")%>/?xpath=<%=xpath%>')"><%=nextId.get("subject") %></a></td>
			<td class="cont"><%=formatted %></td>
		</tr>		
		<%} %>
		<% if(prevId != null) {
			Date cdate = (Date)prevId.get("createDate");
			String formatted = DateUtil.formatDate(cdate, DateUtil.YYYYMMDD);
		%>
		<tr>
			<td class="brd_prev tit">이전글</td>
			<td colspan="2" class="subject"><a href="javascript:loadPage('${contextPath}/___/renew/hospital/boardview/<%=prevId.get("id")%>/?xpath=<%=xpath%>')"><%=prevId.get("subject") %></a></td>
			<td class="cont"><%=formatted %></td>
		</tr>
		<%} %>
		</tbody>
	</table>
	<div class="board_btns">
		<%
			if(um != null){
				//out.print("um not null");
				if(um.getEmail() != null){
					if(um.getAccount().equals( data.get("creator") )){
		%>
		<a href="javascript:delete_post();" class="btn_bg2">글 삭제하기</a>
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board/write?type=<%=data.get("boardId") %>&hid=<%=data.get("customField1") %>');" class="btn_bg2">글 수정하기</a>
		<%
					}
				}
			}else{
				//out.print("um null");
			}
		%>				
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=xpath %>')" class="btn_bg3">목록보기</a>
	</div>
	
	<div class="board_comment">
		<div class="comments">
			<h4 class="comm_cnt">답글 [총 <span id="comm_count"></span>개]</h4>
			
			<%
				if(um != null){
					if(um.getEmail() != null){
			
			%>
			<div class="input_area">				
				<div class="">
					<div class="left">
						<textarea class="input_area_ta"></textarea>
					</div>
					<div class="left ml9" >
						<a class="btn_bg4" href="javascript:send_reply(1,<%=data.get("id")%>,'commlist')">답글쓰기</a>
					</div>
				</div>
			</div><!-- "input_area" -->
			<%
						
					}
				}
			%>
			
			<div class="list_area clear">
				<div class="commlist">
					<table cellpadding="0" cellspacing="0" class="commlist_tb">
						<colgroup>
							<col width="90">
							<col width="99">
							<col width="416">
							<col width="52">
						</colgroup>
						<tbody id="commlist">
						</tbody>
					</table>					
				</div>
			</div>		<!-- list_area -->	
			<div class="more_btn">
				<a href="javascript:loadMore(<%=data.get("id") %>, 0, 'commlist')" class="btn_bg5">글 더보기</a>
			</div>
			<script type="text/javascript">
				loadMore(<%=data.get("id")%>, 0,'commlist');
			</script>
		</div>
	</div>	
</div>
<script type="text/javascript">
function delete_post(){
	if(confirm("글을 삭제하시겠습니까?")){
		$.ajax({
			url : '${contextPath}/___/renew/board/post/remove',
			type : 'post',
			data : { pid : '<%=data.get("id")%>' },
			dataType : 'json',
			success: function(data){
				if(data.code == '0'){
					alert(data.msg);
					location.reload();
				}else{
					alert(data.msg);
				}
			}
		});
	}
}
</script>