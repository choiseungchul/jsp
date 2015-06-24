<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
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
.join_body {
	background:url("${imageHandler.g_right_body_bg_700}");
	border: 1px solid #CCCCCC;
	border-top: 0px;
}
.join_body_top{
	background:url("${imageHandler.g_right_logoset}") no-repeat right;
}
.desc_page{
	color:#444444;
	font-size: 12px;
	margin-left: 180px;
	margin-top: 90px;
	text-align: left;
}

.join-user-info-title{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
}
.join-user-info-confirm, .join-user-info-cancel, .join-user-info-confirm a:link, .join-user-info-cancel a:link, .join-user-info-confirm a:hover, .join-user-info-cancel a:hover{
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
.join-user-info-confirm{	
	background:url("${imageHandler.g_right_bt_confirm}") no-repeat;
	margin-left: 230px;
}
.join-user-info-cancel{
	background:url("${imageHandler.g_right_bt_cancel}") no-repeat;
	margin-left: 20px;
}
.join-user-info{
	border:1px solid #CCCCCC;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 100%;
}
.join-user-info-head {
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
.join-user-info-data {
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
.join-value, .join-checkbox-value {
	float: left;
	width:auto;margin:0;
	padding-bottom: 2px;
}
.join-checkbox-value{
	padding-right: 20px;
}

.join-input-text {
	font-size: 12px;
	height: 20px;
	background-color: white;
	color: #454545;
	padding-left: 2px;
	padding-top: 2px;
	border: 1px solid #CCCCCC;
}
.join-select {
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
	$( "#gender2").attr('checked', 'checked');
	$( "#isSubscribe1").attr('checked', 'checked');
	$( "#keyword_1").attr('checked', 'checked');
	
	$( "#email2").change( function(){
		if ( $( "#email2").find(":selected").val() == ""){
			$( "#email3").show(500);
		}else{
			$( "#email3").hide(500);
		}
	});
	if ( $( "#email2").find(":selected").val() == ""){
		$( "#email3").show();
	}
	
	
	// 생년월일 체크용 제한값 설정
	var currentTime = new Date(); 
	var month = parseInt(currentTime.getMonth()+1); 
	month = month<=9? "0"+month : month; 
	var day = currentTime.getDate(); 
	day = day<=9? "0"+day : day; 
	var year = currentTime.getFullYear(); 
	var currentYear = year;
	<c:choose>
	<c:when test="${userType=='h'}">
		year = year - 18;
	</c:when>
	<c:otherwise>
		year = year - 14;
	</c:otherwise>
	</c:choose>
	
	var allowAge =  year+ "-" + month + "-" + day;
	
	
	$('#address1').each( function(){
		var input = $(this);
		input.autocomplete({
			serviceUrl : '${contextPath}/ajax.do', minChars: 2,
			params:{ fid:'${funcHandler.funcZipcodeZibunAjaxSearch.id}', field:'zipcodeId'},
			onSelect: function( value, data){ 
				getZipcodeInfo( input.attr('no'), data);
			}
		});
	});
	
	$( "#btn_submit").click( function() {
		
		<c:if test="${userType=='g'}">
			var name = $.trim($("#name").val());
			if( typeof $('#name').val() === 'undefined'|| name ==''){
				$(".property-error").hide();
				$(".hint-name").html("이름을 적어주세요.").show();
				$('#name').focus();
				return false; 
			}else{
				$(".hint-name").hide();
			}
		</c:if>
		
		var nickname = $.trim( $('#nickname').val());
		if( typeof $('#nickname').val() === 'undefined'|| nickname==''){
			<c:choose>
				<c:when test="${userType=='h'}">
					$(".property-error").hide();
					$(".duplicate-result-nickname").html("병원명을 적어주세요.").show();
				</c:when>
				<c:otherwise>
					$(".property-error").hide();
					$(".duplicate-result-nickname").html("닉네임을 적어주세요.").show();
				</c:otherwise>
			</c:choose>
			$('#nickname').focus();
			return false; 
		}else{
			$(".duplicate-result-nickname").hide();
		}
		
		<c:if test="${userType=='h'}">
			var registrationNo = $.trim($("#registrationNo").val());
			var pattern3 = /^[0-9]+[-]+[0-9]+[-]+[0-9]/;
			if( typeof $('#registrationNo').val() === 'undefined'|| registrationNo ==''){
				$(".property-error").hide();
				$(".hint-registrationNo").html("사업자번호를 적어주세요. ex) 000-00-00000").show();
				$('#registrationNo').focus();
				return false; 
			}else if( !pattern3.test( registrationNo)){
				$(".property-error").hide();
				$(".hint-registrationNo").html("유효한 사업자번호를 적어주세요. ex) 000-00-00000").show();
				$('#registrationNo').focus();
				return false; 
			}else{
				var bizId = registrationNo.replace(/-/g, "");
				if ( !checkBizID( bizId)){
					$(".property-error").hide();
					$(".hint-registrationNo").html("유효한 사업자번호를 적어주세요. ex) 000-00-00000").show();
					$('#registrationNo').focus();
					return false; 
				}
				$(".hint-registrationNo").hide();
			}
		</c:if>
		
		var account = $.trim($("#account").val());
		if( typeof $('#account').val() === 'undefined'|| account ==''){
			$(".property-error").hide();
			$(".duplicate-result-account").html("아이디를 적어주세요.").show();
			$('#account').focus();
			return false; 
		}else{
			$(".duplicate-result-account").hide();
		}
		
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
		
		var email = $.trim( $("#email").val());
		var email2 = $.trim( $("#email2").val());
		var email3 = $.trim( $("#email3").val());
		if ( email == '' || ( email.length < 4) || ( email2 == '' && email3 == '')){
			//alert( "유효한 이메일 주소를 적어주세요.");
			$(".property-error").hide();
			$(".hint-email").html("유효한 이메일 주소를 적어주세요.");
			$("#email").focus();
			return false;
		}
		var email_regex = /^[a-zA-Z0-9._-]/;
		var email_regex2 = /[a-zA-Z0-9.-]/i;
		var email_regex3 = /[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
		if ( !( email_regex.test(email) || email_regex2.test(email2) || email_regex3.test(email3))){
			//alert( "유효한 이메일 주소를 적어주세요.");
			$(".property-error").hide();
			$(".hint-email").html("유효한 이메일 주소를 적어주세요.");
			$("#email").focus();
			return false;
		}else{
			$(".hint-email").hide();
		}
		
		
		<c:if test="${userType=='g'}">
			var currentTime = new Date(); 

			var birthday =  $.trim( $( "#birthday").val());
			if ( birthday == ""){
				//alert( "생년월일을 선택해주세요");
				$(".hint-birthday").html( "생년월일을 적거나 선택해주세요. ex) 2000년 1월 1일 -> 2000-01-01");
				$("#birthday").focus();
				return false;
			}else if ( birthday != ""){
				var birthdays =  birthday.split("-");
	
				if ( birthdays.length < 3){
					$(".hint-birthday").html( "유효한 생년월일을 선택해주세요 ex) 2000년 1월 1일 -> 2000-01-01");
					//alert( "유효한 생년월일을 선택해주세요");
					$("#birthday").focus();
					return false;
				} else if ( ( birthdays[0].length < 4) || ( birthdays[0] < '1000') || ( birthdays[0] > currentYear)
						||  ( birthdays[1].length < 2) || !( birthdays[1] < 13 && birthdays[1] > 0 )
						||  ( birthdays[2].length < 2) || !( birthdays[2] < 32 && birthdays[2] > 0 )) {
					$(".hint-birthday").html( "유효한 생년월일을 선택해주세요 ex) 2000년 1월 1일 -> 2000-01-01");
					//alert( "유효한 생년월일을 선택해주세요 ex) 2000년 1월 1일 -> 2000-01-01");
					$("#birthday").focus();
					return false;
				}
			} 
			
			if ( ( allowAge) <  $( "#birthday").val()){
				<c:choose>
				<c:when test="${userType=='h'}">
					alert( "병원관계자는 만 18세 이상만 가입이 가능합니다.");
				</c:when>
				<c:otherwise>
					alert( "회원가입은 만 14세 이상만 가입이 가능합니다.");
				</c:otherwise>
				</c:choose>
				
				$("#birthday").focus();
				return false;
			}
		</c:if>
		
		
		var checkedKeys = "";
		<c:forEach var="keywordModel" items="${keywordModels}">
			if ( $( "#keyword_${keywordModel.id}").is(":checked")){
				checkedKeys += "${keywordModel.id},";
			}
		</c:forEach>
		
		$("#userKeyword").val(checkedKeys);
		
		$.blockUI({ 
			message: $('.submitting'), 
			css: { width: '270px', height : '76px', border:'none', backgroundColor: '', '-webkit-border-radius': '5px', '-moz-border-radius': '5px'/* , opacity: .9 */},
			overlayCSS:{ backgroundColor: '#000000'},
			onOverlayClick: $.unblockUI
		});
		setTimeout($.unblockUI, 3000); 
		dynamic.util.submitForm('form_join');
	}).css('cursor', 'pointer');
	
	$( "#btn_cancel").click( function() {
		location.href="${contextPath}/index.jsp";
	});

	var pattern = /^[a-z]+[a-z0-9_]*$/;
	var pattern2 = /[!-+\]\/\'\:\;.,<>?\"|\\={}`~]/;
	var num = /[0-9]/;
	
	
	$("#duplicate-account").click(function() { 
		
		var account = $.trim($("#account").val());
		if( typeof $('#account').val() === 'undefined'|| account ==''){
			$(".property-error").hide();
			$(".duplicate-result-account").html("중복검사할 아이디을 적어주세요.").show();
			$('#account').focus();
			return false; 
		}
		if ( !pattern.test( account)){
			$(".property-error").hide();
			$(".duplicate-result-account").html("아이디는 영문소문자로 시작하고\r\n영문소문자, 숫자, 언더바(_)만 사용하실 수 있습니다.").show();
			$('#account').focus();
			return false;
		}
		if ( account.length < 4){
			$(".property-error").hide();
			$(".duplicate-result-account").html("[ "+$("#account").val()+" ]은 글자수가 너무 짧습니다. 4자 이상으로 작성해 주시기 바랍니다.").show();
			$('#account').focus();
			return false; 
		}
		
		var url = dynamic.constants.CONTEXTPATH + "/___/user/checkDuplicated/${userType}/account/" + account;
		
		 $.getJSON( url, function( data){
			if ( data.result == 'true'){
				$(".property-error").hide();
				$(".duplicate-result-account").html("사용 가능한 아이디 입니다.").show();
			}else{
				$(".property-error").hide();
				$(".duplicate-result-account").html("중복된 아이디가 있습니다.").show();
			}
		});
		
	}).css('cursor', 'pointer');
	
	$("#duplicate-nickname").click(function() { 
		var nickname = $.trim( $('#nickname').val());
		if( typeof $('#nickname').val() === 'undefined'|| nickname==''){
			<c:choose>
				<c:when test="${userType=='h'}">
				$(".property-error").hide();
				$(".duplicate-result-nickname").html("중복검사할 병원명을 적어주세요.").show();
				</c:when>
				<c:otherwise>
				$(".property-error").hide();
				$(".duplicate-result-nickname").html("중복검사할 닉네임을 적어주세요.").show();
				</c:otherwise>
			</c:choose>
			$('#nickname').focus();
			return false; 
		}
		
		if ( pattern2.test( nickname)){
			//alert( "특수문자는 사용할 수 없습니다.");
			$(".property-error").hide();
			$(".duplicate-result-nickname").html("특수문자는 사용할 수 없습니다.").show();
			$('#nickname').focus();
			return false;
		}
		
		<c:if test="${userType=='g'}">
		if ( $('#nickname').val().length < 2){
			//alert( '[ '+$('#nickname').val()+' ]은 글자수가 너무 짧습니다. 2자 이상으로 작성해 주시기 바랍니다.');
			$(".property-error").hide();
			$(".duplicate-result-nickname").html("[ "+$('#nickname').val()+" ]은 글자수가 너무 짧습니다. 2자 이상으로 작성해 주시기 바랍니다.").show();
			$('#nickname').focus();
			return false; 
		} 
		</c:if>
		
		var url = dynamic.constants.CONTEXTPATH + "/___/user/checkDuplicated/${userType}/nickname/" + nickname;
			
		 $.getJSON( url, function( data){
			if ( data.result == 'true'){
				<c:choose>
				<c:when test="${userType=='h'}">
				$(".property-error").hide();
				$(".duplicate-result-nickname").html("사용 가능한 병원명입니다.").show();
				</c:when>
				<c:otherwise>
				$(".property-error").hide();
				$(".duplicate-result-nickname").html("사용 가능한 닉네임 입니다.").show();
				</c:otherwise>
				</c:choose>
			}else{
				<c:choose>
				<c:when test="${userType=='h'}">
				$(".property-error").hide();
				$(".duplicate-result-nickname").html("중복된 병원명이 있습니다.").show();
				</c:when>
				<c:otherwise>
				$(".property-error").hide();
				$(".duplicate-result-nickname").html("중복된 닉네임이 있습니다.").show();
				</c:otherwise>
				</c:choose>
			}
		});
		
	}).css('cursor', 'pointer');

});

function checkBizID(bizID)  //사업자등록번호 체크 
{ 
    // bizID는 숫자만 10자리로 해서 문자열로 넘긴다. 
    var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1); 
    var tmpBizID, i, chkSum=0, c2, remander; 
     bizID = bizID.replace(/-/gi,''); 

     for (i=0; i<=7; i++) chkSum += checkID[i] * bizID.charAt(i); 
     c2 = "0" + (checkID[8] * bizID.charAt(8)); 
     c2 = c2.substring(c2.length - 2, c2.length); 
     chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1)); 
     remander = (10 - (chkSum % 10)) % 10 ; 

    if (Math.floor(bizID.charAt(9)) == remander) return true ; // OK! 
      return false; 
} 

function getZipcodeInfo( index, zipcodeId){
	// get Hospital Info Json
	var url = '${contextPath}/___/zipcode/json/'+zipcodeId;
	$.getJSON( url, function( data){
		
		var postalCode = data.postalCode; 
		var postalCode1 = postalCode.substr(0, 3);
		var postalCode2 = postalCode.substr(3, 3);
		$("#postalCode1").val( postalCode1);
		$("#postalCode2").val( postalCode2);
		
	});
}

</script>


<div class="submitting">
	<div class="submitting-msg">GIVUS 멤버신청 감사합니다.<br>가입이 완료되면 로그인 후 메인화면으로 이동합니다.</div>
</div>

<%-- input field form --%>
<form:form id="form_join" enctype="multipart/form-data" action="${contextPath}/gedit.do?fid=${dispatcher.function.id}&action=create&userType=${userType}" method="post">
<div class="property-form">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td align="center">
		<%-- //////////////// PATH INFO //////////////// --%>
		<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<c:if test="${userType=='g' }">
				<td height="50px" class="path_info" align="left">회원가입 > 일반회원가입 </td>
			</c:if>
			<c:if test="${userType=='h' }">
				<td height="50px" class="path_info" align="left">회원가입 > 병원회원가입 </td>
			</c:if>
		</tr>
		</table>

		<table width="980" style="margin:auto;" border="0" cellspacing="0" cellpadding="0"  class="body_subtitles" >
		<tr>
			<td width="145px" height="52px" class="body_title_name" align="center">회원가입</td>
			<td class="body_title_desc" align="left">"GIVUS"에 가입 신청을 진행하는 공간입니다. </td>
		</tr>
		<tr>
			<td width="145px" valign="top" height="860px" >
				<table width="145px" height="150px"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30px"><a href="${contextPath}/___/p/user/terms/g">일반회원가입</a></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="30px"><a href="${contextPath}/___/p/user/terms/h">병원회원가입</a></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="80px"></td>
				</tr>
				</table>
			</td>
			<td width="830px" height="860px" class="join_body" valign="top" align="center"> 				
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="join_body_top" width="700px" height="200px">
						<table border="0" cellspacing="0" cellpadding="0">
						
						<tr>
							<td>
								<div class="desc_page">회원가입시 기본정보를 정확하게 입력하여 주시면 본인확인 및 서비스 이용 시  편리하게 이용하실 수 있습니다.
									GIVUS는 회원님의 개인정보를 안전하게 보호하고 있으며 회원님의 동의 없이는 기재하신 정보가 누출되지 않습니다. 
									자세한 내용은 <a href="#">개인정보보호정책</a>을 확인하여 주십시오.</div>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="25px" class="join-user-info-title"><img src="${imageHandler.g_right_subtitle_icon}"> 회원기본정보입력 ( <span style="color: #c70000;">*</span> 는 필수항목입니다.)</td>
				</tr>
				<tr>
					<td class="join-user-info">
						<table border="0" cellspacing="0" cellpadding="0"  class="property-list">
						
							<c:forEach var="head" items="${dispatcher.headers}">
							<c:set var="render" value="${dispatcher.renders[head.name]}"/>
							<tr>
								<td class="join-user-info-head">
									${head.title}
									<c:if test="${fn:contains('name, nickname, account, registrationNo, password, userType, email, birthday', head.name)}"><span style="color: #c70000;"> * </span></c:if>
									<span class="${validationCss}">&nbsp;&nbsp;&nbsp;</span>
								</td>
								<td class="join-user-info-data">
									<c:if test="${head.name == 'address'}">
										
										<span class="join-value">
											<form:input path="${'postalCode1'}" cssClass="join-input-text" size="10"/>
											- <form:input path="${'postalCode2'}" cssClass="join-input-text" size="10"/></span>
										
											<span class="hint hint-postalCode"></span>
										<span class="join-value">
											<form:input path="${head.name}1" cssClass="join-input-text ${head.className}" no="1" size="80" placeholder="검색할 읍/면/동 이름을 여기에 입력해주세요."/>
											
											</span>
										<span class="join-value"><form:input path="${head.name}2" cssClass="join-input-text ${head.className}" size="80"  placeholder="나머지 상세주소를 여기에 입력해주세요."/></span>
									</c:if>
									<span class="join-value">
									<c:if test="${head.name == 'tel' || head.name == 'mobile'}">
										<form:input path="${head.name}1" cssClass="join-input-text ${head.className}" size="10"/>
										- <form:input path="${head.name}2" cssClass="join-input-text ${head.className}" size="10"/>
										- <form:input path="${head.name}3" cssClass="join-input-text ${head.className}" size="10"/>
									</c:if>
									<c:if test="${head.name != 'tel' && head.name != 'mobile' && head.name != 'address' && head.name != 'addressType' && head.name != 'postalCode'}">
									<c:choose>
										<c:when test="${head.name == 'description' || head.name == 'contents' || head.name == 'introduction'}">
											<form:textarea path="${head.name}" cssClass="join-input-text" cssStyle="width:90%;"/>
											<script>$(function(){CKEDITOR.replace('${head.name}', ckeditor_config);});</script>
										</c:when>
										<c:when test="${head.name == 'password' || head.name == 'passwd'}">
											<form:password path="${head.name}" cssClass="join-input-text" size="30"/>
										</c:when>
										<c:when test="${render == null || render.type == 'text' || render.type == 'number'}">
											<form:input path="${head.name}" cssClass="join-input-text ${head.className}" size="30"/>
										</c:when>
										<c:when test="${render.type == 'date'}">
											<input type="text" id="${head.name}" name="${head.name}" value="${dispatcher.data.renderedData[head.name]}" class="join-input-text" style="margin-right:3px"  placeholder="달력클릭 →">
											<script type="text/javascript">
												$(document).ready( function(){ $("#${render.name}").datepicker();});
											</script>
										</c:when>
										<c:when test="${render.type == 'image' || render.type == 'file'}">
											<span id="${head.name}">${dispatcher.data.renderedData[head.name]}</span><br/>
											<span>
												<input size="50" type="file" id="file_${head.name}" name="file_${head.name}" value="" class="join-input-text">
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
											<form:radiobuttons path="${head.name}" items="${requestScope[itemsName]}" style="padding-right:5px;padding-left:5px;"/>
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
											<input id="suggest_${head.name}" name="suggest_${head.name}" type="text" size="50" class="join-input-text" value="${renderedValue}">
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
									</c:if>
									</span>
									
									<c:if test="${( head.name == 'nickname') || head.name == 'account'}">
										<span class="bt-check" id="duplicate-${head.name}">${head.title} 중복확인</span><span class="duplicate-result-${head.name}" style="display: none;"></span>
									</c:if>
									<c:if test="${head.name == 'email'}">&nbsp;&nbsp;@&nbsp;&nbsp;
										<select class="join-select" name="email2" id="email2" class="email2" >
											
											<option value="naver.com">naver.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="nate.com">nate.com</option>
											<option value="yohoo.co.kr">yahoo.co.kr</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="paran.com">paran.com</option>
											<option value="">직접입력</option>
										</select> 
										<input type="text" class="join-input-text email3" id="email3" name="email3"/>
									</c:if>
									
									<c:if test="${head.name == 'name'}"><span class="hint hint-name"></span></c:if>
									<c:if test="${head.name == 'birthday'}"> <span class="hint hint-birthday">달력클릭 또는 날짜 입력[ 예 : 2000년 1월 1일생이면, 2000-01-01 ]</span> </c:if>
									<c:if test="${head.name == 'password'}"><span class="hint hint-password"></span></c:if>
									<c:if test="${head.name == 'email'}"><span class="hint hint-email"></span></c:if>
									<c:if test="${head.name == 'registrationNo'}"><span class="hint hint-registrationNo"></span></c:if>
									<form:errors path="${head.name}" cssClass="property-error"/>
									<c:set var="msgKey" value="${func.messageKey}.${head.name}"/>
									<c:if test="${msgHandler[msgKey] != null}">
										<span class="tipTip" title="${msgHandler[msgKey]}"><img src="${imageHandler.memo}"/></span>
									</c:if>
								</td>
							</tr>
							<c:if test="${head.name == 'password'}">
								<tr>
									<td class="join-user-info-head">
										${head.title} 확인<span class="${validationCss}">&nbsp;&nbsp;&nbsp;</span>
									</td>
									<td class="join-user-info-data">
										<form:password path="${head.name}1" cssClass="join-input-text" size="30" hint=""/>
										<span class="hint hint-password1">비밀번호를 다시 입력하세오.</span>
										
										<form:errors path="${head.name}1" cssClass="property-error"/>
										<c:set var="msgKey" value="${func.messageKey}.${head.name}1"/>
										<c:if test="${msgHandler[msgKey] != null}">
											<span class="tipTip" title="${msgHandler[msgKey]}"><img src="${imageHandler.memo}"/></span>
										</c:if>
									</td>
								</tr>
							</c:if>
						</c:forEach> 
						
							<tr>
								<td class="join-user-info-head">관심키워드</td>
								<td class="join-user-info-data">
									<c:forEach var="keywordModel" items="${keywordModels}">
										<input type="checkbox" name="${keywordModel.id}" id="keyword_${keywordModel.id}"><label for="keyword_${keywordModel.id}"> ${keywordModel.name}</label>&nbsp;&nbsp;
									</c:forEach>
								</td>
							</tr>
						
						</table>
						<c:forEach var="hidden" items="${dispatcher.hiddenFields}">
							<input type="hidden" name="${hidden.name}" value="${hidden.value}"/>
						</c:forEach>
						<input type="hidden" name="userKeyword" id="userKeyword" value="">
					</td>
				</tr>
				<tr>
					<td height="80px" width="100%" align="center">
						
						<div id="btn_submit"><span class="join-user-info-confirm" id="btn_submit">확 인</span></div>
						
						<a href="#" ><span class="join-user-info-cancel" id="btn_cancel">취 소</span></a>
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