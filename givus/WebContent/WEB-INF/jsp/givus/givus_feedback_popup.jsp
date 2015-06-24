<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
.feedback-background{
	background:url("${imageHandler.g_feedback_bg_feedback}");
	font-family: "나눔고딕", "돋움", Arial Unicode MS, sans-serif;
	font-size:"12px";
	border:0px solid #ccc;
	border-radius: 9px;
}
.feedback-outline{
	border:0px solid #d6d6d6;
}
.feedback-left{
	background-color: #eceff8;
	color: #444444;
	text-shadow: 1px 1px 1px #88a0b4;
	font-size: 14px;
	font-weight: bold;
	width: 130px;
	border:1px solid #d4d4d4;
	vertical-align: middle;
	text-align: center;
}
.feedback-right{
	vertical-align: middle;
	padding-top:3px;
	padding-left: 10px;
	border:1px solid #d4d4d4;
}

.feedback-table{
	border-top:2px solid #d4d4d4;
}
.feedback-input-box{
	border:1px solid #d4d4d4;
}
.feedback-cancel{
	background: url( '${imageHandler.g_popup_bt_popup}') no-repeat;
	width: 117px;
	height: 40px;
	color: #005292;
	font-size: 16px;
	text-align: center;
	vertical-align: middle;
	font-weight: bold;
	padding-top: 7px;
	margin-left: 5px;
}
.feedback-title{
	margin-top: -47px;
	margin-right:10px;
}
</style>

<script type="text/javascript">
$(function(){
	$('.feedback-write-ok').click(function() { 
		
		$.blockUI({ message: "<img src='${imageHandler.g_feedback_bg_feedback_ok}'>" }); 

		dynamic.util.submitForm('feedback_form');
		alert( "소중한 의견이 전달되었습니다.");
		$.unblockUI();
	}).css('cursor', 'pointer');
	
	$('.feedback-cancel').click(function() { 
        $.unblockUI(); 
        return false; 
    }).css('cursor', 'pointer'); 
	
	
	$('.feedback-close').click( function(){
		$.unblockUI();
		return false;
	}).css('cursor', 'pointer');
	
});
</script>

<table class="feedback-background">
	<tr height="116px">
		<td width="60"></td>
		<td width="458"></td>
		<td width="160">
			<div class="feedback-title">
				<img src="${imageHandler.g_popup_icon_close}" align="right" alt="close this popup" class="feedback-close">
			</div>
		</td>
	</tr>
	<tr height="230px">
		<td></td>
		<td class="feedback-outline">
			<%--#################### feedback Form ####################--%>
			<form:form id="feedback_form" action="${contextPath}/gedit.do?fid=PFA&xpath=${xpath}&amp;action=create&amp;bid=28" method="POST">
				<input type="hidden" id="feedback-boardId" name="boardId" value="28">
				
				<table class="feedback-table">
					<tr height="35px">
						<td class="feedback-left" width="110px">제목</td>
						<td class="feedback-right" width="295px"><input type="text" id="feedback-subject" name="subject" class="feedback-input-box" size="45"></td>
					</tr>
					<tr height="195px">
						<td class="feedback-left">개선<br>아이디어</td>
						<td class="feedback-right"><textarea id="feedback-contents" name="contents" rows="10" cols="45" class="feedback-input-box"></textarea></td>
					</tr>
				</table>
			</form:form>
		</td>
		<td valign="bottom" align="center">
			<div class="feedback-write-ok"><img src="${imageHandler.g_feedback_bt_proposal }" alt="제안하기"></div>
			<br>
			<div class="feedback-write-ok"><div class="feedback-cancel" tabindex="4">취소</div></div>
		</td>
	</tr>
	<tr height="24px">
		<td colspan="3"></td>
	</tr>
</table>