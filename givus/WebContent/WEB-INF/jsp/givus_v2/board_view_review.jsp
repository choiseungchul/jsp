<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="dynamic.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="kr.co.zadusoft.contents.model.UserModel" %>
<%@page import="dynamic.web.util.SessionContext" %>
<%@page import="java.util.Date" %>
<%

	String xpath = request.getAttribute("blist_path").toString();
	
	HashMap<String, Object> data = (HashMap<String, Object>)request.getAttribute("board");
	HashMap<String, Object> review = (HashMap<String, Object>)request.getAttribute("review");
	String totalScore = request.getAttribute("totalScore").toString();
	
	HashMap<String, Object> prevId = request.getAttribute("prevId") == null ? null : (HashMap<String, Object>)request.getAttribute("prevId");
	HashMap<String, Object> nextId = request.getAttribute("nextId") == null ? null : (HashMap<String, Object>)request.getAttribute("nextId");
	

	Date date = (Date)data.get("createDate");
	String f_date = DateUtil.formatDate(date, DateUtil.YYYYMMDDHHMM);
	
	UserModel um = (UserModel)SessionContext.getUserModel();
%>
<script>
function send_recomm(pid){
	$.ajax({
		url: '${contextPath}/___/renew/hospital/recomm/add/' + pid,
		success: function(rs){
			var obj = $.parseJSON(rs);
			alert(obj.msg);
		}
	})
}
</script>
<div class="review_board">
	<table cellpadding="0" cellspacing="0" class="review_board_tb">
		<colgroup>
			<col width="108">
			<col width="210">
			<col width="108">
			<col width="231">
		</colgroup>		
		<tbody>
		<% 
		
		%>
		<tr>
			<td class="tit">제목</td>
			<td colspan="3" class="cont">
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
			<td class="cont"><%=f_date %></td>
			<td class="tit">작성자</td>
			<td class="cont">
				<%=data.get("creator") %>
				<%
					String gender = "";
					if(data.get("gender").equals("F")){
						gender = "female";
					}else if(data.get("gender").equals("M")){
						gender = "male";
					}
				%>
				<span class="gender <%=gender%>"><%=data.get("ageGroup") %>대</span>	
			</td>
		</tr>
		<tr class="clear">			
			<td class="tit">조회수</td>
			<td class="cont"><%=data.get("viewCount") %></td>
			<td class="tit">추천수</td>
			<td class="cont"><%=data.get("recommendCount") %></td>
		</tr>
		<tr>
			<td colspan="4" class="contents_td">
				<div class="review_points">
					<div class="points_div">
						<img alt="" src="${contextPath }/img/hospital/plus_icon.png">
						<strong>평가점수</strong>
						[ <span class="fs24 skyblue"><%=totalScore %> </span> / <span class="fs18"> 5 </span> ]
					</div>
					<div class="points_div">
						<img alt="" src="${contextPath }/img/hospital/plus_icon.png">
						<strong>만족도 평가</strong>
					</div>
					<div class="point_detail">
						<table cellpadding="0" cellspacing="0" class="point_detail_tb">
							<colgroup>
								<col width="372">
								<col width="147">
							</colgroup>
							<thead>
							<tr>
								<th class="th_first">평가항목</th>
								<th class="th_last">만족도</th>
							</tr>
							</thead>
							<tbody>
							<%
								for( int i = 1 ; i <= 12; i++){									
							%>
							<tr>
								<td <% if(i == 12) out.print("class='last_l'"); %>><%=MessageHandler.getMessage("reviewPoints.question.review" + i) %></td>
								<td class="point <% if(i == 12) out.print("last_r"); %>"><%=review.get(i) %></td>
							</tr>
							<% } %>
							</tbody>
						</table>
					</div>
					<div class="points_div pt30">
						<img alt="" src="${contextPath }/img/hospital/plus_icon.png">
						<strong>종합 평가</strong>						
					</div>
					<pre class="text_content"><%=data.get("contents") %></pre>
					<div class="recommend">
						<span class="recomm_btn" onclick="send_recomm(<%=data.get("id")%>);">추천하기</span>
					</div>
				</div>				
			</td>
		</tr>
		<%if(nextId != null) {
			Date cdate = (Date)nextId.get("createDate");
			String formatted = DateUtil.formatDate(cdate, DateUtil.YYYYMMDDHHMM);
		%>
		<tr>
			<td class="brd_next">다음글</td>
			<td colspan="2" class="subject"><a href="javascript:loadPage('${contextPath}/___/renew/hospital/boardview_review/<%=nextId.get("id")%>/?xpath=<%=xpath%>')"><%=nextId.get("subject") %></a></td>
			<td><%=formatted %></td>
		</tr>		
		<%} %>
		<% if(prevId != null) {
			Date cdate = (Date)prevId.get("createDate");
			String formatted = DateUtil.formatDate(cdate, DateUtil.YYYYMMDDHHMM);
		%>
		<tr>
			<td class="brd_prev">이전글</td>
			<td colspan="2" class="subject"><a href="javascript:loadPage('${contextPath}/___/renew/hospital/boardview_review/<%=prevId.get("id")%>/?xpath=<%=xpath%>')"><%=prevId.get("subject") %></a></td>
			<td><%=formatted %></td>
		</tr>
		<%} %>
		</tbody>
	</table>
	<div class="board_btns">
		<%
			if(um != null){
				if(um.getEmail() != null){
		%>
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/boardrv/write?type=<%=data.get("boardId") %>&hid=<%=data.get("customField1") %>');" class="btn_bg2">글 작성하기</a>
		<%
				}
			}
		%>	
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_review/<%=xpath %>')" class="btn_bg3">목록보기</a>
	</div>
	
	<div class="board_comment">
		<div class="comments">
			<h4 class="comm_cnt">답글 [총 <span id="comm_count"></span>개]</h4>			
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