<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
.body_top{
	background:url("${imageHandler.g_right_logoset}") no-repeat right;
}
.right_subtitle{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
}
.right_table{
	border:1px solid #d4d4d4;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 100%;
	border-top:2px solid #d4d4d4;
}
.chx_style{
	border: 1px solid #666666;
}
.agreement{
	color: #363739;
	font-size: 13px;
	font-weight: bold;
}
.desc_page{
	color:#444444;
	font-size: 13px;
	font-weight: bold;
	margin-left: 180px;
	margin-top: 90px;
	text-align: left;
}
.inputbox-terms{
	width: 700px;
	height: 200px;
	overflow-y:scroll;
	overflow-x:hidden;
	padding: 3px;
	border: 10px solid #e6e8f1;
}

</style>

<script type="text/javascript">

$(function() {

	$( "#btn_agree")
	.click( function() {
		
		if ( $( "#chx_terms" ).is(':checked') && $( "#chx_userinfo" ).is(':checked')){
			location.href="${contextPath}/___/p/user/create/${joinUserType}";
		}
		else{
			alert( "모두 동의해 주셔야 GIVUS에 가입신청을 진행할 수 있습니다.");
			return false;
		}
	});
});

</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<td class="path_info" align="left">
				회원가입 > 약관동의
			</td>
		</tr>
	</table>
	
	<table width="980" style="margin:auto;" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="145px" height="52px" class="body_title_name" align="center">약관동의</td>
			<td class="body_title_desc" align="left">"GIVUS"에 가입신청을 위한 아래 약관에 동의해 주십시오. </td>
		</tr>
		<tr>
			<td width="145px" valign="top" height="860px" >
				<table class="body_subtitles" width="145px" height="150px"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30px"><a href="${contextPath}/___/p/user/terms/${joinUserType}">이용약관</a></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="30px"><a href="${contextPath}/___/p/user/terms/${joinUserType}">개인정보 취급방침</a></td>
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
					<td class="body_top" width="700px" height="200px">
						<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								
								<div class="desc_page">안녕하십니까? GIVUS 입니다.<br>항상 새로운 서비스를 위해 노력하고 있는 GIVUS 회원으로 가입하시면<br> GIVUS가 제공하는다양한 서비스를 제공받으실 수 있습니다.</div>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="25px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> 이용약관</td>
				</tr>
				<tr>
					<td class="right_table" width="830px">
						<%-- //////////////// TERMS //////////////// --%>
						
						<div class="inputbox-terms"><jsp:include page="givus_terms_contents.jsp" flush="false"/></div>
					</td>
				</tr>
				<tr>
					<td height="50px" colspan="8" align="center" class="agreement">
						<input type="checkbox" id="chx_terms" class="chx_style"> 이용약관 내용에 동의하겠습니다
					</td>
				</tr>
				<tr>
					<td height="25px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> 개인정보 취급방침</td>
				</tr>
				<tr>
					<td class="right_table" width="830px">
						<%-- //////////////// TERMS //////////////// --%>
						<div class="inputbox-terms"><jsp:include page="givus_terms_contents2.jsp" flush="false"/></div>
					</td>
				</tr>
				<tr>
					<td height="50px" colspan="8" align="center" class="agreement">
						<input type="checkbox" id="chx_userinfo" class="chx_style"> 개인정보 취급방침 내용에 동의합니다.
					</td>
				</tr>
				<tr>
					<td height="120px">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="275px"></td>
								<td height="80px" width="150" align="center" valign="top">
									<div id="btn_agree">
									<img src="${imageHandler.g_join_bt_agree }" alt="동의합니다." >
									</div>
								</td>
								<td width="275px"></td>
							</tr>
						</table>
					</td>
				</tr>
				</table>

			</td>
		</tr>
	</table>




	
</td></tr></table>