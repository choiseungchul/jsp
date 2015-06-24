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
	font-size: 12px;
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
}
#btn_submit{
	width:117px;
	text-align: center;
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
	width: 150px;
}
.right-data {
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
.right-value, .right-checkbox-value {
	float: left;
	width:auto;margin:0;
	padding-bottom: 2px;
}
.right-checkbox-value{
	padding-right: 20px;
}

.right-input-text {
	font-size: 12px;
	height: 20px;
	background-color: white;
	color: #454545;
	padding-left: 2px;
	padding-top: 2px;
	border: 1px solid #CCCCCC;
}
.right-select {
	font-size: 12px;
	color: #454545;
	height: 24px;
	width: 100px;
	border: 1px solid #CCCCCC;
}
.property-error {
	vertical-align:middle;
	color: red;
	padding-left:10px;
}
.email3{
	vertical-align: top;
	display:none;
}
.hint{
	color: #005EA6;
	padding-left:10px;
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
.submitting{
	background: url("${imageHandler.g_popup_bg_comment}") no-repeat;
	width: 270px;
	height: 76px;
	display:none;
	border-radius: 5px;
}
.submitting-msg{
	width: 250px;
	height: 56px;
	padding-top: 10px;
	padding-left: 10px;
	text-align: left;
}
.duplicate-result-nickname, .duplicate-result-account{
	color: #91b3d6;
	padding-left:10px;
}
.zipcode-popup{
	display:none;
 	width: 678px;
	height: 373px;
	border-radius: 5px;
}
</style>

<script type="text/javascript">

$(function() {
	
	var pageType = "${pageType}";
	
	if (pageType == null || pageType == ''){
		pageType = $( "#pageType").val();
	}
	
	
	$( "#btn_submit").click( function() {
		
		var password = $.trim( $("#password").val());
		if ( password == ''){
			//alert( '비밀번호를 입력하세요!');
			$(".hint-password").html("비밀번호를 입력하세요.").show();
			$("#password").focus();
			return false;
		}
		else if ( password.length < 6){
			$(".hint-password").html("비밀번호가 너무 짧습니다. 6자 이상으로 적어주세요").show();
			//alert( "비밀번호가 너무 짧습니다. 6자 이상으로 적어주세요");
			$("#password").focus();
			return false;
		}else if ( password.length > 20){
			$(".hint-password").html("비밀번호가 너무 깁니다. 20자 이내로 적어주세요").show();
			//alert( "비밀번호가 너무 깁니다. 15자 이내로 적어주세요");
			$("#password").focus();
			return false;
		}
		else if ( password != $.trim( $( "#password1").val())){
			//alert( "비밀번호가 다릅니다.");
			$(".hint-password").hide();
			$(".hint-password1").html("입력한 확인 비밀번호가 위에 적은 비밀번호와 다릅니다.");
			$("#password1").focus();
			return false;
		}else if ( password == $.trim( $( "#password1").val())){
			$(".hint-password").hide();
			$(".hint-password1").hide();
		}
		
		$.blockUI({ 
			message: $('.submitting'), 
			css: { width: '270px', height : '76px', border:'none', backgroundColor: '', '-webkit-border-radius': '5px', '-moz-border-radius': '5px'/* , opacity: .9 */},
			overlayCSS:{ backgroundColor: '#000000'},
			onOverlayClick: $.unblockUI
		});
		setTimeout($.unblockUI, 3000); 
		dynamic.util.submitForm('form');
	}).css('cursor', 'pointer');
	
	$( "#btn_cancel").click( function() {
		location.href="${contextPath}/___/p/msg/receive/${pageType}";
	}).css('cursor', 'pointer');

});

</script>
<div class="submitting">
	<div class="submitting-msg">비밀번호 수정중입니다...</div>
</div>
<%-- input field form --%>
<form:form id="form" enctype="multipart/form-data" action="${contextPath}/gedit.do?fid=${dispatcher.function.id}&action=modify&id=${dispatcher.data.id}&pageType=${pageType}" method="post">
<div class="property-form">
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
			<td width="145px" valign="top" class="body_subtitles" >
				<table width="145px" border="0" cellspacing="0" cellpadding="0">
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
						<div class="desc_page">수정할 비밀번호를 입력하세요.</div>
					</td>
				</tr>
				<tr>
					<td height="25px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> 비밀 번호 수정</td>
				</tr>
				<%-- //////////////// USER INFO TABLE //////////////// --%>
				<tr>
					<td class="right_table" width="830px">
						<table border="0" cellspacing="0" cellpadding="0"  class="property-list">
							<c:forEach var="head" items="${dispatcher.headers}">
							<c:set var="render" value="${dispatcher.renders[head.name]}"/>
							<tr>
								<td class="right-head">
									${head.title}<span class="${validationCss}">&nbsp;&nbsp;&nbsp;</span>
								</td>
								<td class="right-data">
								<c:choose>
									<c:when test="${head.name == 'address'}">
										<span class="right-value">
											<form:input path="${'postalCode1'}" cssClass="right-input-text" size="10"/>
											- <form:input path="${'postalCode2'}" cssClass="right-input-text" size="10"/></span>
										
											<span class="hint hint-postalCode"></span>
										<span class="right-value"><form:input path="${head.name}1" cssClass="right-input-text ${head.className}" no="1" size="80" placeholder="검색할 읍/면/동 이름을 여기에 입력해주세요."/></span>
										<span class="right-value"><form:input path="${head.name}2" cssClass="right-input-text ${head.className}" size="80"  placeholder="나머지 상세주소를 여기에 입력해주세요."/></span>
									</c:when>
									<c:when test="${( head.name == 'nickname') || head.name == 'account' || head.name == 'name'}">
										<form:input path="${head.name}" cssClass="right-input-text ${head.className}" size="30" disabled="true"/>
									</c:when>
									<c:when test="${head.name == 'tel' || head.name == 'mobile'}">
										<form:input path="${head.name}1" cssClass="right-input-text ${head.className}" size="10"/>
										- <form:input path="${head.name}2" cssClass="right-input-text ${head.className}" size="10"/>
										- <form:input path="${head.name}3" cssClass="right-input-text ${head.className}" size="10"/>
									</c:when>
									<c:when test="${head.name == 'email'}">
										<form:input path="${head.name}" cssClass="right-input-text ${head.className}" size="20"/>
										<span style="margin: 0px 5px 0px 5px;">@</span>
										<select class="right-select" name="email2" id="email2" class="email2" >
											
											<option value="naver.com">naver.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="nate.com">nate.com</option>
											<option value="yohoo.co.kr">yahoo.co.kr</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="paran.com">paran.com</option>
											<option value="">직접입력</option>
										</select> 
										<input type="text" class="right-input-text email3" id="email3" name="email3"/>
									</c:when>
									
									<c:otherwise>
										<span class="right-value">
										
										<c:choose>
											<c:when test="${head.name == 'description' || head.name == 'contents' || head.name == 'introduction'}">
												<form:textarea path="${head.name}" cssClass="right-input-text" cssStyle="width:90%;"/>
												<script>$(function(){CKEDITOR.replace('${head.name}', ckeditor_config);});</script>
											</c:when>
											<c:when test="${head.name == 'password' || head.name == 'passwd'}">
												<form:password path="${head.name}" cssClass="right-input-text" size="40"/>
											</c:when> 
											<c:when test="${render == null || render.type == 'text' || render.type == 'number'}">
												<form:input path="${head.name}" cssClass="right-input-text ${head.className}" size="30"/>
											</c:when>
											<c:when test="${render.type == 'date'}">
												<input type="text" id="${head.name}" name="${head.name}" value="${dispatcher.data.renderedData[head.name]}" class="right-input-text" style="margin-right:3px"  placeholder="달력클릭 →">
												<script type="text/javascript">
													$(document).ready( function(){ $("#${render.name}").datepicker();});
												</script>
											</c:when>
											<c:when test="${render.type == 'image' || render.type == 'file'}">
												<span id="${head.name}">${dispatcher.data.renderedData[head.name]}</span><br/>
												<span>
													<input size="50" type="file" id="file_${head.name}" name="file_${head.name}" value="" class="right-input-text">
												</span>
											</c:when>
											<c:when test="${render.type == 'type'}">
												<form:radiobuttons path="${head.name}" items="${items[head.name]}"/>
											</c:when>
											<c:when test="${render.type == 'select'}">
												<c:set var="itemsName" value="${head.name}_items"/>
												<form:select path="${head.name}" items="${requestScope[itemsName]}"/>
											</c:when>
											<c:when test="${render.type == 'radio'}">
												<c:set var="itemsName" value="${head.name}_items"/>
												<form:radiobuttons path="${head.name}" items="${requestScope[itemsName]}"/>
											</c:when>
											<c:when test="${render.type == 'combo'}">
												<c:set var="itemsName" value="${head.name}_items"/>
												<form:select path="${head.name}">
													<form:options items="${requestScope[itemsName]}"/>
												</form:select>
											</c:when>
											<c:when test="${render.type == 'relation'}">
												<c:set var="renderedValue" value=""/>
												<c:if test="${dispatcher.data.renderedData[head.name] != 'null'}">hashmap 에서는 null 객체가 아닌 null text 가 나온다.
													<c:set var="renderedValue" value="${dispatcher.data.renderedData[head.name]}"/>
												</c:if>
												<input id="suggest_${head.name}" name="suggest_${head.name}" type="text" size="50" class="right-input-text" value="${renderedValue}">
												<form:hidden path="${head.name}"/>
												<script>
													$(function(){
														$('#suggest_${head.name}').autocomplete({
															serviceUrl : '${contextPath}/ajax.do', minChars: 2,
															params:{ fid:'${func.id}', field:'${head.name}'},
															onSelect: function( value, data){ $('#${head.name}').val( data).change();}
														});
													});
												</script>
											</c:when>
										</c:choose>
										
										</span>
									</c:otherwise>
								</c:choose>
									
									<c:if test="${head.name == 'password'}"><span class="hint hint-password"></span></c:if>
								
									<form:errors path="${head.name}" cssClass="property-error"/>
									<c:set var="msgKey" value="${func.messageKey}.${head.name}"/>
									<c:if test="${msgHandler[msgKey] != null}">
										<span class="tipTip" title="${msgHandler[msgKey]}"><img src="${imageHandler.memo}"/></span>
									</c:if>
								</td>
							</tr>
							<c:if test="${head.name == 'password'}">
								<tr>
									<td class="right-head">
										${head.title} 확인<span class="${validationCss}">&nbsp;&nbsp;&nbsp;</span>
									</td>
									<td class="right-data">
										<span class="right-value"><form:password path="${head.name}1" cssClass="right-input-text" size="40" hint=""/></span>
										<span class="hint hint-password1">비밀번호를 다시 입력하세오.</span>
										
									</td>
								</tr>
							</c:if>
						</c:forEach> 
						
						
						</table>
						<c:forEach var="hidden" items="${dispatcher.hiddenFields}">
							<input type="hidden" name="${hidden.name}" value="${hidden.value}" id="${hidden.name}"/>
						</c:forEach>
						<input type="hidden" name="userKeyword" id="userKeyword" value="">
					</td>
				</tr>
				<tr>
					<td height="80px" width="100%" align="center">
						
						<div id="btn_submit"><span class="right-confirm">확 인</span></div>
					</td>
				</tr>
				
				</table>

			</td>
		</tr>
	</table>


</td></tr></table>

</div>
</form:form>