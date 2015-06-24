<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${contextPath}/script/jqueryui/plugin/jquery-wordcount.js"></script>
<style type="text/css">

.msg_body {
	background:url("${imageHandler.g_right_body_bg_700}");
	border: 1px solid #CCCCCC;
	padding-top:23px;
	border-radius: 9px;
}
.right_subtitle{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
}

.input-text {
	font-size: 12px;
	height: 20px;
	background-color: white;
	color: #454545;
	padding-left: 2px;
	padding-top: 2px;
	border: 1px solid #CCCCCC;
}
.message-info-confirm, .message-info-confirm a:link, .message-info-cancel a:link, .message-info-confirm a:hover, .message-info-cancel a:hover{
	width:117px;
	height:41px;
	color: #ffffff;
	font-size: 13px;
	text-align: center;
	vertical-align: middle;
	font-weight: bold;
	padding-top: 11px;	
	text-decoration: none;
}
.message-info-confirm{	
	background:url("${imageHandler.g_right_bt_confirm}") no-repeat;
}
.message-info-cancel{
	background:url("${imageHandler.g_right_bt_cancel}") no-repeat;
	margin-left: 20px;
}
.message-info{
	border:1px solid #CCCCCC;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 100%;
}
.message-info .head {
	border-top:1px solid #CCCCCC;
	background-color: #ECEFF8;
	color: #444444;
	font-size: 12px;
	font-family: "나눔고딕","돋움", Arial Unicode MS, sans-serif;
	text-align: center;
	height:25px;
	width: 100px;
	font-weight: bold;
}
.message-info .data {
	border-top:1px solid #CCCCCC;
	background-color: #FFFFFF;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 350px;
	padding: 5px;
}


.input-list{
	list-style:none;
	width:350px;
}
.input-list > li{
	padding: 3px;
	float:left;
	width:95px;
	margin-right:5px;
}
.input-list input{
	width:95px;
}
.save_it{
	padding: 5px;
	height: 50px;
	font-weight: bold;
	text-align:left;
}
</style>


<c:set var="createfid" value="${funcHandler.funcMessageToAllCreate.id}"/>
<script type="text/javascript">
$(function() {
	$( "#btn-cancel").click( function() {
		location.href="/givus/index.jsp";
	});
});

$(function(){
	$('.input-list .input-text').each( function(){
		var input = $(this);
		input.autocomplete({
			serviceUrl : '${contextPath}/ajax.do', minChars: 1,
			params:{ fid:'${createfid}', field:'receiveUserId'},
			onSelect: function( value, data){ 
				input.data('receiveUserId', data);
			}
		});
	});
	
	$("#message").wordcount({
		countElement : $('.word_count')
	});
});

function checkValidation(){
	var receiveUserIds = [];
	$('.input-list .input-text').each( function(){
		var userId = $(this).data('receiveUserId');
		var userName = $(this).val();
		if( userId && userName && userName.length > 0)
			receiveUserIds.push( userId);
	});
	
	if ( receiveUserIds.length == 0){
		alert( "받는 사람 정보가 없습니다.");
		$("#receiver1").focus();
		return false;
	}
	
	var message =  $.trim( $( "#message").val());
	if ( message.length == 0){
		alert( "보낼 쪽지 내용이 없습니다.");
		$("#message").focus();
		return false;
	}	
	$('#receiveUserIds').val( receiveUserIds.join( ","));
	dynamic.util.submitForm('form-msgcreate-popup');
	alert( "쪽지를 보냈습니다.");
	$.unblockUI();
}
</script>
<%-- variable --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="func" value="${dispatcher.function}"/>

<%-- input field form --%>

<form:form id="form-msgcreate-popup" action="${contextPath}/gedit.do?fid=${createfid}&action=create&xpath=${xPath}" method="post">
<div class="msg_body">
<table width="505px" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="25px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> 쪽지쓰기</td>
				</tr>
				<tr>
					<td class="message-info">
					<table border="0" cellspacing="0" cellpadding="0"  class="property-list">
						<tr>
							<td class="head">
								받는사람
							</td>
							<td class="data">
								<ul class="input-list">
									<li><input type="text" class="input-text" ></li>
								</ul>
								<input type="hidden" name="receiveUserIds" id="receiveUserIds"/>
							</td>
						</tr>
						<tr>
							<td class="head">
								내용쓰기
							</td>
							<td class="data">
								<textarea id="message" name="message" class="input-text" style="width:95%;height:200px;resize:none;"></textarea> 
								<div>( <span class="word_count">0</span> / 1000 자)</div>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td width="100%">
						<div class="save_it">
							<input id="isSave" name="isSave" type="checkbox" value="true"><label for="isSave"> 보낸편지함에 저장</label>
						</div>
					</td>
				</tr>
				<tr>
					<td height="80px" width="100%" align="center">
						<a href="javascript:checkValidation()" ><div class="message-info-confirm" >쪽지보내기</div></a>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
</div>
</form:form>