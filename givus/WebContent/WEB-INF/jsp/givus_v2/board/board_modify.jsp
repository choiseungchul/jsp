<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<%

	List<HashMap<String, Object>> cate = (List<HashMap<String, Object>>)request.getAttribute("cate");

	HashMap<String, Object> board = (HashMap<String, Object>)request.getAttribute("board");

	int bid = (Integer)request.getAttribute("bid");

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
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/board.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
var oEditors = [];
$(document).ready(function(){
	
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "ir1",
	    sSkinURI: "${contextPath }/script/smarteditor/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	});
});
</script>
<script type="text/javascript" src="${contextPath }/script/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

function send_write(){
	if($('#title_input').val() == ''){
		alert('제목을 입력해주세요.');
		return;
	}
	
	oEditors[0].exec("UPDATE_CONTENTS_FIELD", []); 
	
	if($('#ir1').val() == ''){
		alert('내용을 입력해주세요.');
		return;
	}
	
	$.ajax({
		url : '${contextPath }/___/renew/board/modproc',
		data : { sct : $('#sct_cate option:selected').val(), title : $('#title_input').val(), content : $('#ir1').val(), type : <%=board.get("boardId")%>, pid : $('input[name=pid]').val() },
		type : 'post',
		success : function(rs){
			var obj = $.parseJSON(rs);
			if(obj.code == 0){
				alert(obj.msg);
				location.href = '${contextPath }/___/renew/board/view/<%=bid%>?TP=<%=board.get("boardId")%>&CI='; 
			}else if(obj.code == -1000){
				alert(obj.msg);
			}
		},
		error: function(e){
			//console.log('error!');
			location.href = '${contextPath }/___/renew/board/view/<%=bid%>?TP=<%=board.get("boardId")%>&CI=';
			//console.log(e);
		}
	});
}

function delete_post(){
	if(confirm("글을 삭제하시겠습니까?")){
		$.ajax({
			url : '${contextPath}/___/renew/board/post/remove',
			type : 'post',
			data : { pid : '<%=board.get("id")%>' },
			dataType : 'json',
			success: function(data){
				//console.log(data);
				if(data.code == '0'){
					alert(data.msg);
					location.replace('${contextPath}/___/renew/board/list/<%=board.get("boardId")%>');
				}else{
					alert(data.msg);
				}
			},
			error: function(e){
				//console.log('error!');
				location.replace('${contextPath}/___/renew/board/list/<%=board.get("boardId")%>');
				//console.log(e);
			}
		});	
	}
	
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
				<li class="divide <%if(bid == 30) {out.print("on"); }%>"><a href="${contextPath}/___/renew/board/30">성형전게시판</a></li>
				<li class="<% if(bid == 31){ out.print("on");}%>"><a href="${contextPath}/___/renew/board/31">성형후게시판</a></li>
			</ul>
		</div><!-- hospital_tab -->
	
		<form name="bwrite" id="bwrite" method="post" action="${contextPath }/___/renew/hospital/board/writeproc">
			<input type="hidden" name="pid" value="<%=board.get("id")%>">
		<div class="board_write pt45">
			<table cellpadding="0" cellspacing="0" class="board_write_tb">
				<colgroup>
					<col width="140">
					<col width="820">			
				</colgroup>
				<tbody>
				<tr>
					<td class="tit">제목</td>
					<td>
						<select class="select_cate" id="sct_cate" name="sct_cate">
							<%
								for(int i = 0 ; i < cate.size(); i++){
									HashMap<String, Object> data = cate.get(i);
									if(!board.get("categoryId").equals(data.get("id"))){
							%>
							<option value="<%=data.get("id")%>"><%=data.get("name") %></option>
							<% 
									}else{
							%>
							<option value="<%=data.get("id")%>" selected="selected"><%=data.get("name") %></option>
							<%
									}
								} %>
						</select>
						<input type="text" class="hr_input_title" id="title_input" name="title_input" value="<%=board.get("subject")%>">
					</td>
				</tr>
				</tbody>
			</table>
			<div class="input_editor">
				<textarea id="ir1" class="ir1 input_epil"><%=board.get("contents") %></textarea>
			</div>	
			<div class="input_submit">
				<a href="javascript:delete_post()" class="btn_bg2">글삭제</a>
				<a href="javascript:send_write()" class="btn_bg2">수정하기</a>
				<a href="javascript:history.back();" class="btn_bg3">목록으로</a>
			</div>
		</div>
		</form>
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>