<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.select-usertype-background{
	background:url("${imageHandler.g_join_bg_select_usertype}");
	font-family: "나눔고딕", "돋움", Arial Unicode MS, sans-serif;
	font-size:"12px";
	border:0px solid #ccc;
}
.user-type-title{
	margin-top: -25px;
	margin-right:5px;
}
</style>

<script type="text/javascript">
$( function(){
	$('.user-type-close').click( function(){
		$.unblockUI();
		return false;
	}).css('cursor', 'pointer');
	
});
</script>

<table class="select-usertype-background">
	<tr height="68px">
		<td width="44"></td>
		<td width="160"></td>
		<td width="160"></td>
		<td width="44">
			<div class="user-type-title">
				<img src="${imageHandler.g_popup_icon_close}" align="right" alt="close this popup" class="user-type-close">
			</div>
		</td>
	</tr>
	<tr height="60px">
		<td></td>
		<td valign="middle" align="center">
			<a href="${contextPath}/___/p/user/terms/g"><img src="${imageHandler.g_join_bt_join_generaluser }" alt="일반회원가입"></a>
		</td>
		<td valign="middle" align="center">
			<a href="${contextPath}/___/p/user/terms/h"><img src="${imageHandler.g_join_bt_join_hospitaluser }" alt="병원회원가입"></a>
		</td>
		<td></td>
	</tr>
</table>
