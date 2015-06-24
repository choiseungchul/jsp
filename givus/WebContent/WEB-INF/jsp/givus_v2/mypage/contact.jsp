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
$(document).ready(function(){
	
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
	
	var checkLength =$('.board_check:checked').length;
	if(checkLength > 0){
		if(confirm('<%=MessageHandler.getMessage("mypage.board.check.delete")%>')){
			var arr = new Array();			
			$('.board_check:checked').each(function(){
				arr.push($(this).attr('val'));				
			});
			
			$.ajax({
				url : '${contextPath}/___/renew/mypage/contact/delete',
				type : 'post',
				dataType:'json',
				data : { 'ids[]' : arr},
				success : function(obj){
					if(obj.code == 0){
						alert(obj.msg);
						location.reload();
					}else{
						alert(obj.msg);
					}
				}				
			});
		}
	}else{
		alert('<%=MessageHandler.getMessage("mypage.board.check.delete.length")%>');
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

%>
<%
	
%>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	
	<%
		
		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)request.getAttribute("list");
	
		int total = (Integer)request.getAttribute("total");
		int pnum = (Integer)request.getAttribute("pnum");
		int pageCount = 30;
		int pagePerCount = 10;
	
	%>
	<div class="content">
		<div class="left_menu">
			<%@include file="inc/left.jsp" %>		
		</div>
		<div class="right_content">
			<h2>문의하기</h2>
			
			<div class="my_board">
				<table cellpadding="0" cellspacing="0" class="my_board_tb">
					<colgroup>
						<col width="34">
						<col width="46">
						<col width="437">				
						<col width="111">
						<col width="100">
					</colgroup>
					<thead>
					<tr>
						<th colspan="2">번호</th>
						<th>제목</th>							
						<th>날짜</th>
						<th>답변여부</th>
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
						<td>
							<input type="checkbox" class="board_check" val="<%=data.get("id")%>">
						</td>
						<td><%=num %></td>
						<td class="subject">
							<a href="${contextPath }/___/renew/mypage/contact/view/<%=data.get("id")%>">
							<%=data.get("subject").toString() %>							
							</a>
						</td>
						<td><%=dateStr %></td>
						<%
							String reply_yn = "";
						
							if(data.get("reply_yn").toString().equals("Y")){
								reply_yn = "답변완료";
							}else if(data.get("reply_yn").toString().equals("N")){
								reply_yn = "확인중";
							}
						%>
						<td><%=reply_yn %></td>
					</tr>					
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
					<a href="${contextPath }/___/renew/mypage/contact/write" class="btn_contact">문의하기</a>
				</div>
			</div>
			
			<%--페이징 처리 --%>
			<%
				int totalCnt = total;
			
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
				<a href="${contextPath }/___/renew/mypage/contact?PN=<%=ltPnum %>" class="btn">&lt;&lt;</a>
				<% }
					int loop = pcount;
					if(loop > pagePerCount) loop = pagePerCount;
					
					for( int a=startIdx ; a < startIdx+loop; a++){					
				%>	
				<%if(pnum == a){ %>	
				<a href="${contextPath }/___/renew/mypage/contact?PN=<%=pnum %>" class="on"><%=a+1 %></a>
				<%}else{ %>
				<a href="${contextPath }/___/renew/mypage/contact?PN=<%=a %>"><%=a+1 %></a>
				<%}//else %>
				<% } %>
				<% if( startIdx+pagePerCount < pcount ) {
					int gtPnum = startIdx + pagePerCount;
				%>
				<a href="${contextPath }/___/renew/mypage/contact?PN=<%=gtPnum %>" class="btn">&gt;&gt;</a>
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