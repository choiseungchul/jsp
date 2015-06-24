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
}
.body_top{
	background:url("${imageHandler.g_right_logoset}") no-repeat right;
}
.desc_page{
	color:#444444;
	font-size: 12px;
	font-weight: bold;
	margin-left: 180px;
	margin-top: 90px;
	text-align: left;
}
.desc_page_strong{
	color:#c70000;
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
.message-info-title{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
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
.bt-check {
	background:url("${imageHandler.g_right_bt_bg}") no-repeat;
	width:95px;
	height:20px;
	font-size: 11px;
	color: #FFFFFF;
	text-align: center;
	vertical-align:middle;
	float: left;
	margin-left: 10px;
	padding-top: 3px;
	cursor:pointer;
}
.property-error {
	vertical-align:middle;
	color: red;
	padding-left:10px;
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
.hint{
	color: #005EA6;
	padding-left:10px;
	font-size: 11px;
}
input::-webkit-input-placeholder { /* WebKit browsers */
    color: #aaa;
}
input:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
    color: #aaa;
}
input::-moz-placeholder { /* Mozilla Firefox 19+ */
    color: #aaa;
}
input:-ms-input-placeholder { /* Internet Explorer 10+ */
   color: #aaa;
}
</style>

<c:choose>
<c:when test="${pageType=='h'}"><c:set var="createfid" value="${funcHandler.funcMessageToGeneralUserCreate.id}"></c:set></c:when>
<c:otherwise><c:set var="createfid" value="${funcHandler.funcMessageToHospitalCreate.id}"/></c:otherwise></c:choose>
<%-- <c:set var="createfid" value="${funcHandler.funcMessageCreate.id}"/> --%>
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
	dynamic.util.submitForm('form');
}
</script>
<%-- variable --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="func" value="${dispatcher.function}"/>

<%-- input field form --%>

<form:form id="form" action="${contextPath}/gedit.do?fid=${createfid}&action=create&pageType=${pageType}" method="post">
<div class="property-form">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<td height="50px" class="path_info" align="left"><c:choose><c:when test="${ pageType=='m'}">마이페이지</c:when><c:otherwise>병원페이지</c:otherwise></c:choose> > 쪽지쓰기 </td>
		</tr>
		</table>
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
			</td>
			<%-- //////////////// RIGHT BODY //////////////// --%>
			<td width="830px" class="right_body" valign="top" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
				
				<tr>
					<td class="body_top" width="700px" height="200px">
						<div class="desc_page">
							<c:choose>
								<c:when test="${ pageType=='m'}"><span class="desc_page_strong">받는사람 입력란에 병원사용자 이름을 적으면 병원관계자 계정이 검색이 됩니다.</span><br>받는 사람은 1명부터 최대 10명까지 입력이 가능하며 동시 쪽지 보내기가 됩니다. 보낸 쪽지함에 저장을 원할때는 아래 체크박스에 체크를 해주세요.
								</c:when>
								<c:otherwise><span class="desc_page_strong">받는사람 입력란에 일반사용자 닉네임을 적으면 일반 사용자 계정이 검색이 됩니다.</span><br>받는 사람은 1명부터 최대 10명까지 입력이 가능하며 동시 쪽지 보내기가 됩니다. 보낸 쪽지함에 저장을 원할때는 아래 체크박스에 체크를 해주세요.
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>
				<tr>
					<td height="25px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> 쪽지쓰기 
						<span class="hint">* <c:choose>
												<c:when test="${ pageType=='m'}">받는사람에 병원사용자를 적어주세요<c:set var="msg_placeholder" value="병원사용자명 입력"/></c:when>
												<c:otherwise>받는사람에 일반사용자 닉네임을 적어주세요<c:set var="msg_placeholder" value="일반사용자명 입력"/></c:otherwise>
						</c:choose></span>
					</td>
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
									<li><input type="text" class="input-text" id="receiver1" placeholder="${msg_placeholder}"></li>
									<li><input type="text" class="input-text" ></li>
									<li><input type="text" class="input-text" ></li>
									<li><input type="text" class="input-text" ></li>
									<li><input type="text" class="input-text" ></li>
									<li><input type="text" class="input-text" ></li>
									<li><input type="text" class="input-text" ></li>
									<li><input type="text" class="input-text" ></li>
									<li><input type="text" class="input-text" ></li>
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
								<textarea id="message" name="message" class="input-text" style="width:95%;height:300px;resize:none;"></textarea> 
								<div>( <span class="word_count">0</span> / 1000 자)</div>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td width="100%">
						<div class="save_it">
							<input id="isSave" name="isSave" type="hidden" value="true"><!-- <label for="isSave"> 보낸편지함에 저장</label> -->
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
	</td>
</tr>
</table>
</div>
</form:form>