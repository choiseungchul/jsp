<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@page import="kr.co.zadusoft.givus.util.GivusUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>

<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/mypage.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
<%
int type = (Integer)request.getAttribute("type");
String del_type = "";
if(type == 0 || type == 3){
	del_type = "p";
}else if(type == 1 || type == 2){
	del_type = "c";
}
%>
var type = <%=type%>;
$(document).ready(function(){
	$('.myboard_list_info a').eq((type * 2)).addClass('on');
	
	$('#check_all').click(function(){
		var checked = $(this).is(':checked');
		if(checked)
		$('.board_check').attr('checked', 'checked');
		else {
			$('.board_check').removeAttr('checked');
		}
	});
	
	$('.m7').addClass('sub on');
});

function send_delete(){
	if(confirm('<%=MessageHandler.getMessage("mypage.board.check.delete")%>')){
		var checkLength =$('.board_check:checked').length;
		if(checkLength > 0){
			var arr = new Array();
			var arr_pid = new Array();
			$('.board_check:checked').each(function(){
				arr.push($(this).attr('val'));
				arr_pid.push($(this).attr('pid'));
			});
			
			$.ajax({
				url : '${contextPath}/___/renew/mypage/board/delete',
				type : 'post',
				dataType:'json',
				data : { type : '<%=del_type%>', 'ids[]' : arr, 'pid[]' : arr_pid},
				success : function(obj){
					if(obj.code == 0){
						location.reload();
					}else{
						alert(obj.msg);
					}
				}				
			});
			
		}else{
			alert('<%=MessageHandler.getMessage("mypage.board.check.delete.length")%>');
		}
	}
	
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

response.flushBuffer();
	
%>
<%
	
	int board_count = (Integer)request.getAttribute("board_count");
	int comment_count = (Integer)request.getAttribute("comment_count");
	int attend_count = (Integer)request.getAttribute("attend_count");
	int delete_count = (Integer)request.getAttribute("delete_count");

	List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)request.getAttribute("list");

	int pnum = (Integer)request.getAttribute("pnum");
	int pageCount = 30;
	int pagePerCount = 10;
	

%>
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
			<h2>내가 쓴 게시물</h2>
			<div class="my_board_info">
				<div class="my_info">
					<% if(um.getGender().equals("F")){ %>
					<img alt="" src="${contextPath }/img/hospital/brd_view_female_bg.png">
					<% }else if(um.getGender().equals("M")){ %>
					<img alt="" src="${contextPath }/img/hospital/brd_view_male_bg.png">
					<%} %>
					<span><%=um.getAccount() %></span>
				</div>
				<div class="my_board_count">
					<span>출석게시판 <strong><%=attend_count %></strong>회</span>
					<span>|</span>
					<span>총 게시물 <strong><%=board_count + comment_count%></strong>개 (일반 <strong><%=board_count %></strong> + 답글 <strong><%=comment_count %></strong>)</span>
					<span>|</span>
					<span>총 답글 <strong><%=comment_count %></strong>개</span>
					<span>|</span>
					<span>삭제한 게시물 <strong><%=delete_count %></strong>개</span>
				</div>
			</div><!-- my_board_info -->
			
			<div class="my_board_list">
				<div class="myboard_list_info">
					<a href="${contextPath }/___/renew/mypage/board/0" >등록한 게시물</a>
					<a href="">|</a>
					<a href="${contextPath }/___/renew/mypage/board/1" >답글 단 게시물</a>
					<a href="">|</a>
					<a href="${contextPath }/___/renew/mypage/board/2" >등록 답글</a>
					<a href="">|</a>
					<a href="${contextPath }/___/renew/mypage/board/3" >삭제한 게시물</a>
				</div>
			</div><!-- my_board_list -->
			
			<div class="my_board">
				<table cellpadding="0" cellspacing="0" class="my_board_tb">
					<colgroup>
						<col width="34">
						<col width="46">
						<col width="477">
						<col width="96">
						<col width="75">
					</colgroup>
					<thead>
					<tr>
						<th colspan="2">번호</th>
						<th>제목</th>
						<th>
							<%if(type != 2) {%>
							날짜
							<% } %>
						</th>
						<th>
							<%if(type != 2){ %>
								조회수
							<% }else{ %>
								날짜
							<% } %>
						</th>
					</tr>
					</thead>
					<tbody>
					<% 
						for(int i = 0 ; i < list.size() ; i++){
							
							HashMap<String, Object> data = list.get(i);
							
							String dateStr = DateUtil.formatDate((Date)data.get("createDate"), "yyyy.MM.dd");
							
							if(type == 0 || type == 1 || type == 3){
								int num = 0;
								if(type == 0){
									num = board_count - (pnum * 30) - i;
								}else if(type == 1){
									num = comment_count - (pnum * 30 ) - i;
								}else if(type == 3){
									num = delete_count - (pnum * 30 ) - i;
								}
					%>
					<tr>
						<td>
							<input type="checkbox" class="board_check" val="<%=data.get("id")%>">
						</td>
						<td><%=num %></td>
						<td class="subject">
							<a href="${contextPath }/___/renew/board/view/<%=data.get("id") %>?TP=<%=data.get("boardId")%>">
							<%
								String ctName = data.get("cname") == null ? "" : data.get("cname").toString();
								if(!ctName.equals("")) out.print("["+ctName+"]");
							%>
							<%=data.get("subject") %>
							<%
								int commCount = (Integer)data.get("commentCount");
								if(commCount > 0){
									out.print("<span class='blue'>["+commCount+ "]</span>");
								}
							%>
							</a>
							</td>
						<td><%=dateStr %></td>
						<td><%=data.get("viewCount") %></td>
					</tr>
					<%		}else if(type == 2){ 
								int num = comment_count - (pnum * 30) - i;					
					%>
					<tr>
						<td>
							<input type="checkbox" class="board_check" val="<%=data.get("id")%>" pid="<%=data.get("postingId")%>">
						</td>
						<td><%=num %></td>
						<td class="subject">
							<%=data.get("contents") %>							
						</td>
						<td><a href="${contextPath }/___/renew/board/view/<%=data.get("postingId") %>">원문보기 ▶</a></td>
						<td><%=dateStr %></td>
					</tr>
					<% 	} %>
					<% } %>
					</tbody>
				</table>
			</div>
			<div class="my_board_btn">
				<div class="left">
					<input type="checkbox" id="check_all">
					<label for="check_all">전체선택</label>
				</div>
				<div class="right">
					<a href="javascript:send_delete();" class="btn_delete">삭제하기</a>
				</div>
			</div>
			
			<%--페이징 처리 --%>
			<%
				int totalCnt = 0;
				if(type == 0) totalCnt = board_count;
				else if(type == 1) totalCnt = comment_count;
				else if(type == 2) totalCnt = comment_count;
				else if(type == 3) totalCnt = delete_count;
			
				if(totalCnt > pageCount){
					int pcount = (int)(totalCnt / pageCount) + 1;
					
					int startIdx = (((pnum-1)/pagePerCount)*pagePerCount) + 1;
					
					if(totalCnt %pageCount == 0) pcount--;
					
					int ppcount = (int)(totalCnt / pageCount) / pagePerCount;			
			%>	
			<div class="page_navi clear">
				<% if(startIdx > pagePerCount) {
					int ltPnum = startIdx - pagePerCount;
					
					%>
				<a href="${contextPath }/___/renew/mypage/board/<%=type %>?PN=<%=ltPnum %>" class="btn">&lt;&lt;</a>
				<% }
					int loop = pcount;
					if(loop > pagePerCount) loop = pagePerCount;
					
					for( int a=startIdx ; a < startIdx+loop; a++){					
				%>	
				<%if(pnum == a){ %>	
				<a href="${contextPath }/___/renew/mypage/board/<%=type %>?PN=<%=pnum %>" class="on"><%=a+1 %></a>
				<%}else{ %>
				<a href="${contextPath }/___/renew/mypage/board/<%=type %>?PN=<%=a %>"><%=a+1 %></a>
				<%}//else %>
				<% } %>
				<% if( startIdx+pagePerCount < pcount ) {
					int gtPnum = startIdx + pagePerCount;
				%>
				<a href="${contextPath }/___/renew/mypage/board/<%=type %>?PN=<%=gtPnum %>" class="btn">&gt;&gt;</a>
				<%} %>
			</div>
			<%} else { %>
			<div class="page_navi clear">
				<a href="javascript:" class="on">1</a>
			</div>
			<%} %>
			
		</div><!-- right_content -->
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>