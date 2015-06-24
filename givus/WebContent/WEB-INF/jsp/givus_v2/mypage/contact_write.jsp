<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<%

	List<HashMap<String, Object>> cate = (List<HashMap<String, Object>>)request.getAttribute("cate");

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
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/mypage.css?noc=<%=System.currentTimeMillis() %>" />
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
	
	$('.m7').addClass('sub on');
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
		url : '${contextPath }/___/renew/mypage/contact/writeproc',
		data : { title : $('#title_input').val(), content : $('#ir1').val() },
		type : 'post',
		success : function(rs){
			var obj = $.parseJSON(rs);
			if(obj.code == 0){
				alert(obj.msg);
				location.href='${contextPath }/___/renew/mypage/contact/';
				
			}else if(obj.code !=0){
				alert(obj.msg);
			}
		}
	});
}
</script>
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
			<h2>문의하기</h2>
			<form name="bwrite" id="bwrite" method="post" action="${contextPath }/___/renew/hospital/board/writeproc">
			<div class="board_write">
				<table cellpadding="0" cellspacing="0" class="board_write_tb">
					<colgroup>
						<col width="140">
						<col width="820">			
					</colgroup>
					<tbody>
					<tr>
						<td class="tit">제목</td>
						<td>
							<input type="text" class="contact_input_title" id="title_input" name="title_input">
						</td>
					</tr>
					</tbody>
				</table>
				<div class="input_editor">
					<textarea id="ir1" class="ir1 contact_input_ta"></textarea>
				</div>	
				<div class="input_submit">
					<a href="javascript:send_write()" class="btn_bg2">문의하기</a>
					<a href="javascript:history.back();" class="btn_bg3">목록으로</a>
				</div>
			</div>
			</form>
		</div>
		
		
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>