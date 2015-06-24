<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
.left-menu{
	list-style:none;
}
.left-menu > li{
	padding:10px;
	text-align:left;
	padding-left:30px;
	background: url("${imageHandler.g_left_sub_line}") center bottom no-repeat;
}
.left-submenu{
	list-style:none;
	margin-top:5px;
}
.left-submenu > li{
	padding:5px;
}
.right_body {
	background:url("${imageHandler.g_right_body_bg_700}");
	border: 1px solid #CCCCCC;
	border-top: 0px;
}
.body_top{
	background:url("${imageHandler.g_right_logoset}") no-repeat right;
}
.desc_page{
	color:#444444;
	font-size: 13px;
	font-weight: bold;
	margin-left: 180px;
	margin-top: 90px;
	text-align: left;
}
.right_subtitle{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
}
.right_table{
	border:1px solid #CCCCCC;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 100%;
}
.right-title{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
}
.right-confirm, .right-cancel, .right-confirm a:link, .right-cancel a:link, .right-confirm a:hover, .right-cancel a:hover{
	width:117px;
	height:41px;
	color: #ffffff;
	font-size: 13px;
	text-align: center;
	vertical-align: middle;
	font-weight: bold;
	padding-top: 11px;	
	float: left;
}
.right-confirm{	
	background:url("${imageHandler.g_right_bt_confirm}") no-repeat;
	margin-left: 230px;
}
.right-cancel{
	background:url("${imageHandler.g_right_bt_cancel}") no-repeat;
	margin-left: 20px;
}
.right-head {
	border-top:1px solid #CCCCCC;
	background-color: #ECEFF8;
	color: #444444;
	font-size: 12px;
	font-family: "나눔고딕","돋움", Arial Unicode MS, sans-serif;
	text-align: center;
	height:34px;
	font-weight: bold;
	width: 110px;
}
.right-data {
	border-top:1px solid #CCCCCC;
	background-color: #FFFFFF;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 590px;
	padding: 5px;
}
.caution-list{
	list-style-image: url("${imageHandler.g_right_icon_checked}");
	padding:10px;
	padding-left:30px;
}
.caution-list > li{
	padding:5px;
	text-align:left;
	font-size: 12px;
	color: #666666;
}
.caution-red{
	color: #e20008;
	font-weight: bold;
}
.caution-gray-blod{
	color: #444444;
	font-weight: bold;
}
.borderline{
	border: 1px solid #CCCCCC;
}
</style>
<script type="text/javascript">

$(function() {
	
	$( "#btn_submit")
	.click( function() {
		if ( $( "#chx_agree" ).is(':checked')){
			location.href="${contextPath}/___/user/withdraw/${pageType}";
		}
		else{
			alert( "동의해 주셔야 GIVUS에서 탈퇴신청을 진행할 수 있습니다.");
			return false;
		}
	}).css('cursor', 'pointer');
	
	$( "#btn_cancel")
	.click( function() {
		location.href="${contextPath}/___/p/msg/receive/${pageType}";
	}).css('cursor', 'pointer');
	
});

</script>
<%-- input field form --%>

<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<td class="path_info" align="left">
				<c:choose><c:when test="${ pageType=='h'}">병원페이지 > 병원사용자</c:when>
				<c:otherwise>마이페이지 > 개인</c:otherwise></c:choose> 정보수정
			</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="145px" height="52px" class="body_title_name" align="center"><c:choose><c:when test="${ pageType=='h'}">병원페이지</c:when><c:otherwise>마이페이지</c:otherwise></c:choose> </td>
			<td class="body_title_desc" align="left">GIVUS 사용자 [ ${userNickname} ]님의 개인 공간입니다. </td>
		</tr>
		<tr><%-- //////////////// LEFT MENU //////////////// --%>
			<td width="145px" valign="top" class="body_subtitles">
				<table  width="145px" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<ul class="left-menu">
							<li>회원 정보
								<ul class="left-submenu">
									<li><a href="${contextPath}/___/p/user/modify/${pageType}"> - 회원 정보 수정</a></li>
									<li><a href="${contextPath}/___/p/user/password/modify/${pageType}"> - 비밀번호 수정</a></li>
								</ul>	
							</li>
							<c:if test="${ pageType=='m'}">
							<li>쪽지함
								<ul class="left-submenu">
									<li><a href="${contextPath}/___/p/msg/create/${pageType}"> - 쪽지쓰기</a></li>
									<li><a href="${contextPath}/___/p/msg/receive/${pageType}"> - 받은쪽지함</a></li>
									<li><a href="${contextPath}/___/p/msg/send/${pageType}"> - 보낸쪽지함</a></li>
								</ul>							
							</li>
							</c:if>
							<c:if test="${ pageType=='h'}">
							<c:if test="${ userConHospitalId > 0 || userType=='M'}">
							<li>쪽지함
								<ul class="left-submenu">
									<li><a href="${contextPath}/___/p/msg/create/${pageType}"> - 쪽지쓰기</a></li>
									<li><a href="${contextPath}/___/p/msg/receive/${pageType}"> - 받은쪽지함</a></li>
									<li><a href="${contextPath}/___/p/msg/send/${pageType}"> - 보낸쪽지함</a></li>
								</ul>							
							</li>
							</c:if>
							<li>병원 정보
								<c:if test="${  userConHospitalId == null || userConHospitalId < 1}">
								<ul class="left-submenu">
									<li><a href="${contextPath}/___/p/user/conHospital/apply"> - 병원 연결 신청</a></li>
								</ul>
								</c:if>
								<c:if test="${ userConHospitalId > 0}">
								<ul class="left-submenu">
									<li><a href="#"> - 좋은할인</a></li>
									<li><a href="#"> - 병원 정보 수정</a></li>
								</ul>
								</c:if>
							</li>
							</c:if>
							<li><a href="${contextPath}/___/p/user/withdraw/${pageType}">회원탈퇴신청</a></li>
						</ul>
					</td>
				</tr>
				<tr>
					<td height="80px"></td>
				</tr>
				</table>
			</td>
			<%-- //////////////// RIGHT BODY //////////////// --%>
			<td width="830px" class="right_body" valign="top" align="center"> 	
							
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="body_top" width="700px" height="200px">
						<div class="desc_page">회원탈퇴를 신청하기 전에 유의사항을 반드시 확인해주세요.</div>
					</td>
				</tr>
				<tr>
					<td height="25px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> <c:choose><c:when test="${ pageType=='h'}">병원</c:when><c:otherwise>일반</c:otherwise></c:choose>회원 탈퇴신청</td>
				</tr>
				<%-- //////////////// USER WITHDARW TABLE //////////////// --%>
				<tr>
					<td class="right_table" width="830px">
						<table border="0" cellspacing="0" cellpadding="0"  class="property-list">
							
							<tr>
								<td class="right-head">
									<span class="caution-red">유의사항</span>
								</td>
								<td class="right-data">
									<ul class="caution-list">
										<li><span class="caution-gray-blod">사용하고 계신 <c:if test="${ pageType=='h'}">병원</c:if>아이디(${userAccount})는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</span><br> <span class="caution-red">탈퇴한 아이디는 모두 재사용 및 복구가 불가</span>하오니 신중하게 선택하시기 바랍니다.</li>
										<li><span class="caution-gray-blod">탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.</span><br>- 회원정보 등 개인형 서비스 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.</li>
										<li><span class="caution-gray-blod">탈퇴 후에도 게시판형 서비스에 등록된 게시물은 그대로 남아 있습니다.</span></li>
										<li><span class="caution-gray-blod">게시글은 탈퇴 시 자동 삭제되지 않고 그대로 남아 있습니다.</span><br>- 삭제를 원하는 게시글이 있다면 반드시 탈퇴 전 삭제하시기 바랍니다. 탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없으며, 게시글을 임의로 삭제해드릴 수 없습니다.</li>
										<li><span class="caution-gray-blod">탈퇴신청 후 관리자의 승인을 기다려 주세요. </span><br>- 탈퇴신청은 관리자에게 메일로 전송되며, 가입시 등록된 메일로 탈퇴승인을 알려드립니다.</li>
									</ul>
									
								</td>
							</tr>
							
							<tr>
								<td class="right-head">
									탈퇴사유
								</td>
								<td class="right-data">
									<textarea rows="5" cols="90" autofocus="autofocus" style="resize:none;" class="borderline"></textarea>
								</td>
							</tr>
						</table>

					</td>
				</tr>
				<tr>
					<td height="50px" width="100%" align="center">
						<span class="caution-red">탈퇴 후에는 아이디</span> ${userAccount }<span class="caution-red">로 다시 가입할 수 없으며 아이디와 데이터는 복구할 수 없습니다.<br>게시판형 서비스에 남아 있는 게시글은 탈퇴 후 삭제할 수 없습니다.</span>
					</td>
				</tr>
				<tr>
					<td height="50px" width="100%" align="left">
						<input type="checkbox" id="chx_agree" class="borderline"><span class="caution-gray-blod">안내 사항을 모두 확인했으며, 이에 동의합니다.</span>
					</td>
				</tr>
				<tr>
					<td height="80px" width="100%" align="center">
						<div id="btn_submit"><span class="right-confirm" id="btn_submit">확 인</span></div>
						<a href="#" ><span class="right-cancel" id="btn_cancel">취 소</span></a>
					</td>
				</tr>
				
				</table>

			</td>
		</tr>
	</table>


</td></tr></table>
