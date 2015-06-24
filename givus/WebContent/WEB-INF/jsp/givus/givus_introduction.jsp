<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<style type="text/css">
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
}
.body_title_name {
	border: 1px solid #CCCCCC;
	background:url('${imageHandler.g_left_title_bg}') no-repeat;
	color: #FFFFFF;
	font-size: 15px;
	text-shadow: 1px 1px 1px #0C0C0C;
}
.body_title_desc {
	border: 1px solid #CCCCCC;
	color: #444444;
	font-size: 13px;
	padding-left: 25px; 
	font-weight: bold;
}
.body_subtitles{
	border-left: 1px solid #CCCCCC;
	border-top: 1px solid #CCCCCC;
	border-bottom: 1px solid #CCCCCC;
	background:url("${imageHandler.g_left_sub_bg}") no-repeat;
	color: #444444;
	font-size: 13px;
	align:center;
	text-align: center;
	vertical-align: top;
	font-weight: bold;
}
.notice_body {
	background:url("${imageHandler.g_right_body_bg_700}");
	border: 1px solid #CCCCCC;
	border-top: 0px;
}

</style>
<script type="text/javascript">
$(function() {
	$("#intro1").click( function(){
		var val = $("#intro_1").offset();
		$('body,html').animate({scrollTop:val.top}, 1000);
	}).css('cursor', 'pointer');
	$("#intro2").click( function(){
		var val = $("#intro_2").offset();
		$('body,html').animate({scrollTop:val.top}, 1000);
	}).css('cursor', 'pointer');
	$("#intro3").click( function(){
		var val = $("#intro_3").offset();
		$('body,html').animate({scrollTop:val.top}, 1000);
	}).css('cursor', 'pointer');
});
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<td class="path_info" align="left">
				HOME > About Us
			</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="145px" height="52px" class="body_title_name" align="center">GIVUS</td>
			<td class="body_title_desc" align="left">GIVUS 소개, 평가기준, 등급정의를 설명하는 공간입니다.</td>
		</tr>
		<tr>
			<td width="145px" valign="top" height="860px" class="body_subtitles" >
				<table  width="145px" height="150px"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30px"><div id="intro1">GIVUS 소개</div></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="30px"><div id="intro2">GIVUS 평가기준</div></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="30px"><div id="intro3">GIVUS 등급정의</div></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="80px"></td>
				</tr>
				</table>
			</td>
			<td width="830px" height="860px" class="notice_body" valign="top" align="center"> 				
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td id="intro_1">
						<img src="${imageHandler.g_contactus_introduction_1}" alt="GIVUS 소개">
					</td>
				</tr>
				<tr>
					<td id="intro_2">
						<img src="${imageHandler.g_contactus_introduction_2}" alt="GIVUS 평가기준">
					</td>
				</tr>
				<tr>
					<td id="intro_3">
						<img src="${imageHandler.g_contactus_introduction_3}" alt="GIVUS 등급정의">
					</td>
				</tr>
				</table>
			</td>
		</tr>
	</table>

</td></tr></table>
