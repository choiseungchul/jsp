<%@page import="dynamic.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	
	String type = request.getAttribute("type").toString();
	List<HashMap<String, Object>> category = (List<HashMap<String, Object>>)request.getAttribute("category");
	
%>
<%@include file="../inc/top.jsp" %>
<%
 	String sub = "board";
 %>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/board.css?noc=<%=System.currentTimeMillis() %>" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	$('.m4').addClass('sub on');	
});

function send_mod(){
	if(confirm("글을 게시 하시겠습니까?")){
		oEditors[0].exec("UPDATE_CONTENTS_FIELD", []); 
		<% if(type.equals("26")){ %>
		var point = getStatbar();
		$('input[name=point]').val(point);
		<% }%>
		document.frm.submit();
	}
}

</script>
<script type="text/javascript">
var oEditors = [];
$(document).ready(function(){
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "ir1",
	    sSkinURI: "${contextPath }/script/smarteditor/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	});
	
	$('input[name=createDate]').datepicker({
		"dateFormat" : "yy-mm-dd"
	});
});
<%
if(type.equals("26")){
%>
$(function(){
	$( ".statbar" ).slider({
		range: "min",
		min : 1,
		max : 5,
		value : 3,
		disabled : false
	});
	
	$('.statbar').bind('slidechange', function(event, ui){
		var idx = $('.statbar').index(this);
		var val = ui.value;
		
		$('.stat_text').eq(idx).text( getStatText(val) );		
	});
});
function getStatText(num){
	if(num == 1){
		return '<%=MessageHandler.getMessage("reviewPoints.answer.1")%>';
	}else if(num == 2){
		return '<%=MessageHandler.getMessage("reviewPoints.answer.2")%>';
	}else if(num == 3){
		return '<%=MessageHandler.getMessage("reviewPoints.answer.3")%>';
	}else if(num == 4){
		return '<%=MessageHandler.getMessage("reviewPoints.answer.4")%>';
	}else if(num == 5){
		return '<%=MessageHandler.getMessage("reviewPoints.answer.5")%>';
	}
}
function getStatbar(){
	var str = '';
	for(var i = 0 ; i < 12 ; i++){
		var val = $('.statbar').eq(i).slider('value');
		str += ':' + val;
	}
	return str;
}
<%
}
%>
</script>
<style>
.ir1{
	width: 980px;
	height: 400px;
}
</style>
<script type="text/javascript" src="${contextPath }/script/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<body>
<%@include file="../inc/gnb.jsp" %>
<div class="container-fluid">
  <div class="row">
	 <%@include file="../inc/left.jsp" %>	 
 	 <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">게시판검색</h1>
			
          <div class="row placeholders">
          	<div class="col-lg-1">
          		<div class="btn-group">
				  <select id="srch_code">
				  <%
				  	String ST = "";
				  	if(request.getAttribute("ST") != null){
				  		ST = request.getAttribute("ST").toString();
				  	}
				  %>				  
				  	<option value="name" selected="selected">제목</option>				  	
				  	<option value="address">내용</option>
				  	<option value="homepage">제목+내용</option>
				  	<option value="creator">작성자</option>
				  </select>
				</div>
          	</div>
            <div class="col-lg-3">
			    <div class="input-group">
			      <input type="text" class="form-control" name="srch_text" id="srch_text" value="${ST }">
			      <span class="input-group-btn">
			        <button class="btn btn-default"  type="button" onclick="go_srch()">검색</button>
			      </span>
			    </div><!-- /input-group -->
			  </div><!-- /.col-lg-6 -->
          </div>
          
          <!-- 게시판들 -->
          <div class="row placeholders">
          	<ul id="tabs" class="nav nav-tabs">
          		<li class="<% if(type.equals("15"))  out.print("active");%>"><a href="${contextPath }/___/admin/board/30" >공지사항</a></li>
		        <li class="<% if(type.equals("30"))  out.print("active");%>"><a href="${contextPath }/___/admin/board/30" >성형전게시판</a></li>
		        <li class="<% if(type.equals("31"))  out.print("active");%>"><a href="${contextPath }/___/admin/board/31" >성형후게시판</a></li>
		        <li class="<% if(type.equals("32"))  out.print("active");%>"><a href="${contextPath }/___/admin/board/32" >출석게시판</a></li>
		        <li class="<% if(type.equals("25"))  out.print("active");%>"><a href="${contextPath }/___/admin/board/25" >수술후기 게시판</a></li>
		        <li class="<% if(type.equals("26"))  out.print("active");%>"><a href="${contextPath }/___/admin/board/26" >병원리뷰 게시판</a></li>
		    </ul>
          </div>
          
          <form action="${contextPath }/___/admin/board/addproc" method="post" id="frm" name="frm">
          	<input type="hidden" name="bid" value="<%=type%>">
          	<input type="hidden" name="point" value="">
          <h2 class="sub-header">게시글 뷰</h2>
          <div class="table-responsive">          
            <table class="table table-striped">
            	
              <thead>
				<tbody>		
				<tr>
					<td class="tit">제목</td>
					<td class="subject">
						<select name="category" id="category">							
							<% 
								for(int i = 0 ; i < category.size() ; i++) {
									HashMap<String, Object> c_data = category.get(i);
									String c_id = c_data.get("id").toString();
									String c_name = c_data.get("name").toString().trim();									
							%>
							<option value="<%=c_id%>"><%=c_name%></option>
							<%} %>
						</select>						
						<input type="text" name="subject" value="">					
					</td>
					<td class="tit">작성자</td>
					<td>
						<input type="text" name="creator" value="">
					</td>
				</tr>
				<%
					if(type.equals("25") || type.equals("26")){
						
						List<HashMap<String, Object>> hos = (List<HashMap<String, Object>>)request.getAttribute("hos");
				%>
				<tr>
					<td class="tit">병원이름</td>
					<td class="subject" colspan="3">
						<select name="hid" id="hid">
					<%
						for(int k = 0 ; k < hos.size(); k++){
							HashMap<String, Object> hosInfo = hos.get(k);
					%>
							<option value="<%=hosInfo.get("id")%>"><%=hosInfo.get("name")%></option>
					<% } %>
						</select>
					</td>
				</tr>
				<%
					}
				%>
				<tr>
					<td class="tit">날짜</td>
					<td class="subject">
						<input type="text" name="createDate" value="">
					</td>
					<td class="tit">조회수</td>
					<td>
						<input type="text" name="viewCount" value="">
					</td>
				</tr>				
				<tr>
					<td colspan="4" class="contents_td">					
						<textarea rows="" cols="" id="ir1" name="contents" class="ir1"></textarea>
					</td>
				</tr>
				<%
					if(type.equals("26")){
					// 질문목록
					for( int i = 1 ; i <= 12 ; i++){
				%>
				<tr>
					<td><%=MessageHandler.getMessage("reviewPoints.question.review" + i) %></td>
					<td class="point">
						<div class="statbar"></div>					
					</td>
					<td class="point" colspan="2">
						<div class="stat_text">보통</div>
					</td>
				</tr>
				<% }//for 
				}%>	
				<%
					if(type.equals("26")){
				%>
				<tr>
					<td class="tit">리뷰포인트 적용 성별</td>
					<td class="subject">
						<select name="gender" id="gender">
							<option value="F">여자</option>
							<option value="M">남자</option>
						</select>
					</td>
					<td class="tit">리뷰포인트 적용 생일(연령대)</td>
					<td>
						<select id="age" name="age">
							<option value="10">10대</option>
							<option value="20">20대</option>
							<option value="30">30대</option>
							<option value="40">40대</option>
						</select>
					</td>
				</tr>
				<%} %>
				</tbody>
			</table>
			
			<div class="board_btns " style="padding-bottom: 50px;">
				<button type="button" class="btn btn-default btn-lg"  onclick="send_mod()">글쓰기</button>
				<a href="${contextPath }/___/admin/board/<%=type %>"><button type="button" class="btn btn-default btn-lg" >목록으로</button></a>
			</div>
				
		</div>
		</form>
	</div>
</div>
</div>
</body>
</html>