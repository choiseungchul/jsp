<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dynamic.web.util.SessionContext"%>
<%@page import="kr.co.zadusoft.contents.model.UserModel"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%

	String hid = (String)request.getAttribute("hid");
	String type = (String)request.getAttribute("type");

	List<HashMap<String, Object>> cate = (List<HashMap<String, Object>>)request.getAttribute("cate");

	UserModel um = (UserModel)SessionContext.getUserModel();
	
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
<script type="text/javascript" src="${contextPath }/script/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "ir1",
    sSkinURI: "${contextPath }/script/smarteditor/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});

function update_post(){
	$.ajax({
		url : '${contextPath}/___/renew/board/post/update',
		type : 'post',
		data : { 
			pid : '',
			cate : '' 
		},
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
		url : '${contextPath }/___/renew/hospital/board/writeproc',
		data : { sct : $('#sct_cate option:selected').val(), title : $('#title_input').val(), content : $('#ir1').val(), type : <%=type%>, hid : <%=hid%> },
		type : 'post',
		success : function(rs){
			var obj = $.parseJSON(rs);
			if(obj.code == 0){
				alert(obj.msg);
				loadPage('${contextPath}/___/renew/hospital/board_epil/<%=hid%>/'+$("#sct_cate option:selected").val()+'/1/<%=type%>');
			}else if(obj.code == -1000){
				alert(obj.msg);
			}
		}
	});
}
</script>
<form name="bwrite" id="bwrite" method="post" action="${contextPath }/___/renew/hospital/board/writeproc">
<div class="board_write">
	<table cellpadding="0" cellspacing="0" class="board_write_tb">
		<colgroup>
			<col width="140">
			<col width="517">			
		</colgroup>
		<tbody>
		<tr>
			<td class="tit">제목</td>
			<td>
				<select class="select_cate" id="sct_cate" name="sct_cate">
					<%
						for(int i = 0 ; i < cate.size(); i++){
							HashMap<String, Object> data = cate.get(i);
					%>
					<option value="<%=data.get("id")%>"><%=data.get("name") %></option>
					<% } %>
				</select>
				<input type="text" class="hr_input_title" id="title_input" name="title_input">
			</td>
		</tr>
		</tbody>
	</table>
	<div class="input_editor">
		<textarea id="ir1" class="ir1 input_epil"></textarea>
	</div>	
	<div class="input_submit">
		<a href="javascript:send_write()" class="btn_bg2">글쓰기</a>
		<a href="javascript:loadPage('${contextPath }/___/renew/hospital/board_epil/<%=hid %>/0/1/<%=type %>')" class="btn_bg3">목록으로</a>
	</div>
</div>
</form>