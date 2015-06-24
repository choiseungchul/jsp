<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${contextPath}/script/jqueryui/plugin/jquery-wordcount.js"></script>
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

.right_body {
	background:url("${imageHandler.g_right_body_bg_700}");
	border: 1px solid #CCCCCC;
	border-top: 0px;
	padding: 40px 0px 40px 0px;
}
.right_subtitle{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
	margin-bottom: 5px;
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
.message-info-title{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
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
	width: 150px;
	font-weight: bold;
}
.message-info .data {
	border-top:1px solid #CCCCCC;
	background-color: #FFFFFF;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 550px;
	padding: 5px;
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
.input-list{
	list-style:none;
	width:550px;
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
<%-- //////////////// MESSAGE SEND STYLE //////////////// --%>
.subtitle{
	height:40px;
	margin-top:20px;
	text-align:left;
}
.message-list{
	width:309px;
	height:600px;
	float:left;
	background-color: #fff;
	border:1px solid #c7c7c7;
}
.message-contents{
	width:380px; /* 340px; */
	height:600px;
	float:left;
	background-color: #fff;
	border:1px solid #c7c7c7;
}
.message-list > table{
	width:309px;
}
.message-list td {
	border:1px solid #c7c7c7;
}
.message-head{
	height:24px;
	font-weight:bold;
	text-align:center;
	background : url("${imageHandler.g_right_msg_title_bg}");
	color: #444444;
}
.message-value{
	text-align:center;
	height:49px;
	color: #666666;
}
.message-selected{
	background-color: #eceff8;
}
.message-navigation{
	background-color: #eaedf2;
	text-align:center;
	height:54px;
	font-weight:bold;
	border-top: 1px solid #c7c7c7;
	background: url( "${imageHandler.g_right_msg_nav_bg}");
}
.navSelected{
	color: blue;
}
</style>

<script type="text/javascript">
$(function(){
	$('.message-list td[sendMessageId]').click(function(){
		var sendMessageId = $(this).attr('sendMessageId');
		var url = '${contextPath}/___/msg/send/view/' + sendMessageId;
		$('.message-contents').load( url, function( responseText){

		});
		$('.message-list tr').removeClass('message-selected');
		$(this).closest('tr').addClass('message-selected');
	}).css('cursor', 'pointer')[0].click();
	
	$('#chkall').click( function(){
		var checked = this.checked;
		$(':checkbox[id^=chk_]').each( function(){
			this.checked = checked;
		});		
	});
});
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<td height="50px" class="path_info" align="left"><c:choose><c:when test="${ pageType=='m'}">마이페이지</c:when><c:otherwise>병원페이지</c:otherwise></c:choose> > 보낸쪽지함 </td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="980" style="margin:auto;" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="145px" height="52px" class="body_title_name" align="center"><c:choose><c:when test="${ pageType=='m'}">마이페이지</c:when><c:otherwise>병원페이지</c:otherwise></c:choose></td>
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
			</td><%-- //////////////// RIGHT BODY //////////////// --%>
			<td width="830px" class="right_body" valign="top" align="center"> 				
				<table width="700px" border="0" cellspacing="0" cellpadding="0">
					<tr><td>
					<div class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> 보낸쪽지함</div>
					<div class="message-list">
						<div style="height:545px;">
						<table width="309">
							<tr>
								<td class="message-head" width="26px"><input type="checkbox" name="chkall" id="chkall"></td>
								<td class="message-head" width="98px">받는사람</td>
								<td class="message-head" width="90px">보낸날짜</td>
								<td class="message-head" width="100px">받은날짜</td>
							</tr>
							<c:forEach var="data" items="${dispatcher.datas}">
							<tr>
								<td class="message-value" width="26px"><input type="checkbox" id="chk_${data.id}" name="chk_${data.id}" value="${data.id}"></td>
								<td class="message-value" sendMessageId="${data.id}">${data.renderedData.receiveUserId}</td>
								<td class="message-value">${data.renderedData.createDate}</td>
								<td class="message-value">${data.renderedData.readDate}</td>
							</tr>
							</c:forEach>
						</table>
						</div>
						<div class="message-navigation">
							<div style="margin-top:20px;">
							<c:forEach var="nav" items="${dispatcher.navigations}" varStatus="count">
								<c:if test="${nav.selected}">
									<c:if test="${count.count > 1}">| </c:if>
									<c:if test="${nav.selected}"><a href="${nav.url}"><span class="navSelected">${nav.name}</span></a></c:if>
									<c:if test="${nav.selected == false}"><a href="${nav.url}"><span class="${nav.className}">${nav.name}</span></a></c:if>
								</c:if>
							</c:forEach>
							</div>
						</div>
						
					</div>
					<div class="message-contents">
					</div>
					</td></tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
