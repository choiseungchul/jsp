<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/jquery.blockUI.js"></script>
<script src="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.min.js"></script>
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.theme.css">

<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
}

.top_login_list{
	list-style:none;
	color: #d3d3d3;
	font-size: 11px;
	font-family: 나눔고딕, 돋움, Arial Unicode MS, sans-serif;
	text-shadow: 1px 1px 1px #171717;
}
.top_login_list a {
	color: #d3d3d3;
	font-size: 11px;
}

.top_login_list > li{
	line-height: 26px;
	float:left;
	padding-right: 15px;
	vertical-align: middle;
}
.top_login_space{
	float:left;
	margin-left: 9px;
}
.top_title_selected {
	color: #00C6FF;
}
.topmenu-list{
	list-style:none;
	padding:0px;
	margin:0px;
}
.topmenu-sublist{
	padding:0px;
	margin:0px;
	width:980px;
}
.topmenu-list > li{
	line-height:170%;
	float:left;
	width:160px;
	color: #EFEFEF;
	font-size: 12px;
	text-shadow: 1px 1px 1px #000D15;
	padding-top:8px;
	font-weight: bold;
}
.topmenu-list > li a:visited, .topmenu-list > li a:link, .topmenu-list > li a:hover{
	color: #EFEFEF;
	text-decoration:none;
}
.topmenu-list > li a:hover{
	color: #00C6FF;
}
.topmenu-sublist > li{
	list-style:none;
	line-height:170%;
	float: left;
	color: #000;
	text-shadow: 1px 1px 1px #efefef;
	padding-top:8px;
	width:95px;
	padding-bottom:25px;
}
.topmenu-sublist > li a:visited, .topmenu-sublist > li a:link, .topmenu-sublist > li a:hover{
	color: #444444;
	text-decoration:none;
}

/* 로그인 관련 */
.login_window{
	display:none;
	background-color: transparent;
	border-radius: 5px;
}
.login-table{
	height:248px; 
	width:404px;
	border:0;
	background: url('${imageHandler.g_popup_login_bg}') no-repeat;
	border-radius: 9px;
	background-color: #ffffff;
}
.login-hint{
	color:#A0A0A0;
	height:10px;
	margin-left:50px;
	margin-bottom:15px;
	float: left;
}
.login-input{
	/* background: url( '${imageHandler.g_popup_inputbox}') no-repeat; */
	height:37px;
	width:200px;
	border: #dde3f2 1px solid;
	border-radius: 5px 5px 5px 5px;
	/* background-color:#FFFFFF; */
	vertical-align: middle;
	margin-left:40px;
	margin-top:2px;
	padding-left: 5px;
}
.login-ok, .login-cancel{
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
.login-search-idpw{
	background: url( '${imageHandler.g_popup_bt_popup2}') no-repeat;
	color: #005292;
	font-size: 12px;
	font-weight: bold;
	display: inline;
	margin-left: 5px;
	height:27px;
}
.select_usertype{
	display:none;
	height:129px; width:404px;
	border-radius: 5px;
}
.login-title{
	margin-top:-40px;
	margin-right:5px;
}


#selectable .ui-selecting { background: #FECA40; }
#selectable .ui-selected { background: #F39814; color: white; }
#selectable { list-style-type: none; margin: 0; padding: 0; width: 60%; font-family: 나눔고딕, Arial Unicode MS, sans-serif;font-size: 1em; }
#selectable li { margin: 3px; padding: 0.4em; height: 18px; }
#join-type-form {font-family: 나눔고딕, Arial Unicode MS, sans-serif;font-size: 0.7em; }

/* 회원가입관련 */
.ui-dialog-titlebar-close { 
    visibility: hidden; 
}
.ui-dialog-titlebar { 
    visibility: hidden; 
}

/* 상단 검색창 */
.search_hospital{
	background: #3b4f60;
	border: 0px;
	padding-left:5px;
	color: #d3d3d3;
	height: 21px;
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

<script type="text/javascript">
$(function() {
	

	$('.topmenu-list li').hover( function(){
		var submenu = $(this).find('ul');
		if( submenu.length > 0){
			submenu.show();
			$('.submenu_spaceholder').hide();
		}
	}, function(){
		var submenu = $(this).find('ul');
		if( submenu.length > 0){
			submenu.hide();
			$('.submenu_spaceholder').show();
		}
	});
	$('.topmenu-sublist').hide();
	
});

$(function() {

	$(function() {
		if (window.parent.frames.length > 0) {
			window.parent.location.href = document.location.href;
		}

		$("form input").keyup(function(e) {
			if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
				doLogin();
				return false;
			} else {
				return true;
			}
		});
	});

	function doLogin() {
		$('.login-error').html("<span>로그인 중입니다.</span>");
		dynamic.util.submitForm('login_form');
	}
	
	$(function(){
		$('.btn-login').click(function(){
			$.blockUI({ 
				message: $('#login_form'), 
				css: { width: '404px', height : '248px', border:'none', backgroundColor: '', '-webkit-border-radius': '5px', '-moz-border-radius': '5px'/* , opacity: .9 */},
				overlayCSS:{ backgroundColor: '#000000'} ,
				onOverlayClick: $.unblockUI
			});
			
			$('.login-ok').click(function() { 
				if( typeof $('#login_account').val() === 'undefined'|| $('#login_account').val()==''){
					alert( 'User Name이 없습니다.'+$('#login_account').val());
				
					return false; 
				}
				else if(  typeof $('#login_password').val() === 'undefined'|| $('#login_password').val()==''){
					alert( 'Password가 없습니다.'+$('#login_password').val());
					return false; 
				}
				
				else{
					dynamic.util.submitForm('login_form');
					$.unblockUI(); 
				}
	        }).css('cursor', 'pointer');
			
			
			$('.login-cancel').click(function() { 
	            $.unblockUI(); 
	            return false; 
	        }).css('cursor', 'pointer'); 
			
			$('.login-search-idpw').click(function() {
				$.unblockUI();
				return false;
			}).css('cursor', 'pointer');
			
			$('.login-close').click( function(){
				$.unblockUI();
				return false;
			}).css('cursor', 'pointer');
			
		}).css('cursor', 'pointer');
		$('#btn-join').click(function(){
			$.blockUI({  
				message: $('.select_usertype'), 
				css: { width: '404px', height : '129px', border:'none', backgroundColor: '', '-webkit-border-radius': '5px', '-moz-border-radius': '5px'/* , opacity: .9 */},
				overlayCSS:{ backgroundColor: '#000000'},
				onOverlayClick: $.unblockUI
			});
			
		}).css('cursor', 'pointer');
		
	});

	
	/* 병원정보 검색 시작*/
	$('.search_hospital').each( function(){
		var input = $(this);
		input.autocomplete({
			serviceUrl : '${contextPath}/ajax.do', minChars: 1,
			params:{ fid:'${funcHandler.funcHospitalAjaxSearch.id}', field:'hospitalId'},
			onSelect: function( value, data){ 
				// 병원 정보를 가져온후 해당 정보를 채운다.
				$('#top_search_hospitalId').val( data);
				location.href="${contextPath}/___/p/hospital/" + data;
			}
		});
	});
	$('#top_search_hospital').click( function() {
		$('.search_hospital').each( function(){
			
			var hospitalId = hospitalId = $('#top_search_hospitalId').val();
			var hospitalName = $(this).val();
			
			if( typeof hospitalId === 'undefined'|| hospitalId ==''){
				alert( "검색할 병원 명을 한글자 이상 적고 목록에서 선택해 주세요.");
				$('#top_search_hospital_box').focus();
				return false; 
			}
			if( hospitalId && hospitalName && hospitalName.length > 0){
				location.href="${contextPath}/___/p/hospital/" + hospitalId;
			}else{
				alert( "검색할 병원 명을 한글자 이상 적고 목록에서 선택해 주세요.");
				$('#top_search_hospital_box').focus();
				return false;
			}
		});
	}).css('cursor', 'pointer');
	/* 병원정보 검색 끝*/
	
});

</script>

<%-- //////////////// JOIN GIVUS //////////////// --%>

<div id="join-type-form" title="회원가입" style="display:none;">

	<ol id="selectable">
		<li class="ui-widget-content">일반사용자</li>
		<li class="ui-widget-content">병원관계자</li>
	</ol>
</div>

<div class="select_usertype">
	<jsp:include page="givus_select_usertype_popup.jsp" flush="false"/>
</div>

<%-- //////////////// LOGIN GIVUS //////////////// --%>
<div class="login_window">
	<form action="${contextPath}/login.do" id="login_form" method="post">
		
		<table class="login-table">
		<tr valign="middle" align="center">
			<td>
				<table width="400" border="0" align="left" cellpadding="0" cellspacing="0">
				<tr>
					<td height="80"></td>
					<td height="80">
						<div class="login-title">
							<img src="${imageHandler.g_popup_icon_close}" align="right" alt="close this popup" class="login-close">
						</div>
					</td>
				</tr>
				<tr>
					<td width="260" height="45" valign="top"><input type="text" name="account" id="login_account" value="${account}" class="login-input" style="height: 32px;" tabindex="1" ></td>
					<td width="140" height="45" valign="top">
						<div class="login-ok" tabindex="3">로그인</div>
					</td>
				</tr>
				<tr>
					<td width="260" height="45" valign="top"><input type="password" name="password" id="login_password" class="login-input" style="height: 32px;" onclick="this.blur" tabindex="2"></td>
					<td width="140" height="45" valign="top">
						<div class="login-cancel" tabindex="4">취소</div>
					</td>
				</tr>
				<tr>
					<td height="20" valign="top"><div class="login-hint"><input type="checkbox" tabindex="5" style="color:#A0A0A0;"> 아이디 저장하기</div></td>
				</tr>
				<tr>
					<td height="30" valign="middle" ><span style="margin-left: 50px;float: left;">
						<img src="${imageHandler.g_popup_icon_notice}" alt="!">
						<img src="${imageHandler.g_popup_msg_search_idpw }" alt="ID/PW를 잊어버리셨나요?"></span>
						
					</td>
					<td width="140" height="30" valign="middle">
						<div class="login-search-idpw" tabindex="6" style="width: 90px; height:28px;text-align: middle;padding: 5px 0px 8px 0px;"><span style="padding: 5px 14px 8px 14px;">ID/PW찾기</span></div>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		
		</table>
	</form>
</div>


<%-- //////////////// GIVUS 대메뉴 //////////////// --%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="700" style="text-align:center;background:url(${imageHandler.g_top_total_left}) repeat-x;"></td>
	<td width="980" valign="top" align="center">
		<table style="text-align:center" border="0" cellspacing="0" cellpadding="0" >
		<tr>
			
			<td width="980" align="center">
				<table width="980" border="0" cellspacing="0" cellpadding="0" style="text-align:center;background:url(${imageHandler.g_top_login_center_bg}) repeat-x;">
				<tr>
					<td valign="middle">
						<ul class="top_login_list">
							<c:choose>
							<c:when test="${userAccount !=null }">
								<li><c:if test="${userNickname !=null}">${userNickname}님</c:if></li>
								<li><a href="${contextPath}/logout.do">로그아웃</a></li>
									<c:if test="${userType !=null && userType == 'G'}">
								<li>|</li>
								<li>
									<a href="${contextPath}/___/p/msg/receive/m" id="btn-mypage-generaluser" >마이페이지</a>
								</li>
									</c:if>
									<c:if test="${userType !=null && userType == 'H'}">
								<li>|</li>
								<li>
									<a href="${contextPath}/___/p/msg/receive/h" id="btn-mypage-hospitaluser" >병원페이지</a>
								</li>
									</c:if>
									<c:if test="${userType !=null && userType == 'M'}">
								<li>|</li>
								<li>
									<a href="${contextPath}/___/p/msg/receive/m" id="btn-mypage-generaluser" >마이페이지</a> 
								</li>
								<li>|</li>
								<li>
									<a href="${contextPath}/___/p/msg/receive/h" id="btn-mypage-hospitaluser" >병원페이지</a>
								</li>
									</c:if>
							</c:when>
							<c:otherwise>
								<li><div class="top_login_space">&nbsp;</div><a href="#" class="btn-login" >로그인</a></li>
								<li>|</li>
								<li><a href="#" id="btn-join" >회원가입</a></li>
							</c:otherwise>
							</c:choose>
								<li>
									<a href="https://twitter.com/givus2014" target="_blank">
										<img src="${imageHandler.g_top_twitter}" alt="twitter" width="19" height="26" />
									</a>
								</li>
								<li>
									<a href="https://www.facebook.com/pages/GIVUS/441206982691214" target="_blank">
										<img src="${imageHandler.g_top_facebook}" alt="facebook" width="19" height="26" /></a>
								</li>
								<%-- <li>
									<img src="${imageHandler.g_top_google}" alt="google" width="16" height="16" />
								</li> --%>
							<c:if test="${userAccount !=null && userType !=null && userType == 'M' }">
								<li>|</li>
								<li><a href="${contextPath}/___/p/msg/create" style="margin-left:10px;">쪽지</a></li>
								<li>|</li>
								<li><a href="${contextPath}/admin_main.jsp" style="margin-left:10px;" target="_blank">관리자 페이지</a> </li>
							</c:if>
						</ul>
						<div style="float:right;height:26px;"><img alt="병원검색" src="${imageHandler.g_top_icon_search}" id="top_search_hospital"></div>
						<div style="float:right;"><input type="text" class="search_hospital" id="top_search_hospital_box"  placeholder="병원명으로 검색"><input type="hidden" id="top_search_hospitalId"></div>
					</td>
					
				</tr>
				</table>
			</td>
			
		</tr>
		<tr>
			
			<td width="980"><a href="${contextPath}/___/p/main"><img src="${imageHandler.g_top_title_main_center }" width="980" height="71"></a></td>
			
		</tr>
		<tr><%-- /////////////////// TOP MENU ////////////////// --%>
			
			<td width="980" align="center">
				<table width="980" border="0" cellspacing="0" cellpadding="0">
				<tr style="height:34px;background:url(${imageHandler.g_top_titles_bg}) repeat-x;">
					<td valign="middle">
						<div style="text-align:center;vertical-align:middle;height:34px;width:980px;background:url(${imageHandler.g_top_titles_right}) center right no-repeat">
						<ul class="topmenu-list">
							<li><a href="${contextPath}/___/p/main">HOME</a>
								<ul class="topmenu-sublist">
									<li><a href="${contextPath}/___/p/introduction">About us</a></li>
									<li><a href="${contextPath}/___/p/howToUseGivus">GIVUS 활용하기</a></li>
									<li><a href="${contextPath}/___/p/notice">Contact Us</a></li>
								</ul>
							</li>
							<li><a href="${contextPath}/___/p/ranking/A?fid=HE">순위</a>
								<ul class="topmenu-sublist">
									<li><a href="${contextPath}/___/p/ranking/A?fid=HE">전국 TOP 100</a></li>
									<li><a href="${contextPath}/___/p/ranking/B">서울 TOP 50</a></li>
									<li><a href="${contextPath}/___/p/ranking/C">광역 TOP 10</a></li>
									<li><a href="${contextPath}/___/p/ranking/D">부위 TOP 10</a></li>
								</ul>
							</li>
							<li><a href="${contextPath}/___/p/surgeryinfo">정보</a>
								<ul class="topmenu-sublist">
									<li><a href="${contextPath}/___/p/surgeryinfo/19/69">성형정보</a></li>
									<li><a href="${contextPath}/___/p/surgeryinfo/19/68">성형뉴스</a></li>
									<li><a href="${contextPath}/___/p/price/compare">성형가격비교</a></li>
								</ul>
							</li>
							<li><a href="${contextPath}/___/p/board/1">게시판</a>
								<ul class="topmenu-sublist">
									<li><a href="${contextPath}/___/p/board/1">일반회원공간</a></li>
									<c:if test="${userType !=null && ( userType == 'H' || userType == 'M')}">
									<li><a href="${contextPath}/___/p/hboard">병원회원공간</a></li>
									</c:if>
								</ul>
							</li>
							<li><a href="${contextPath}/___/p/event">병원이벤트</a></li>
							<li><a href="${contextPath}/___/p/hospitalpr">우리병원 PR</a></li>
						</ul>
						</div>
					</td>
				</tr>
				</table>
			</td>
			
		</tr>
		</table>
	</td>
	<td  width="700" style="text-align:center;background:url(${imageHandler.g_top_total_right}) repeat-x;"></td>
</tr>
</table>
<div class="submenu_spaceholder" style="height:47px;"></div>
<%-- //////////////// GIVUS LOGO //////////////// --%>

<style type="text/css">
.wrap {
    width: 100%;
    height: 100%;
}

.view {
    width: 980px;
    height: 100px;
    margin: 0 auto;
    background: url(${imageHandler.g_main_banner5}) no-repeat;
}
</style>
<script type="text/javascript">
$( function(){
	toggleImg.start(10000);
});

(function(w, $, ns) {
    "use strict";

    var changeImg = function() {
        var that = this;

        that.imgs = [
            '${imageHandler.g_main_banner1}',
            '${imageHandler.g_main_banner2}',
            '${imageHandler.g_main_banner3}',
            '${imageHandler.g_main_banner4}',
            '${imageHandler.g_main_banner5}'
        ];
        that.idx = 0;
    };

    changeImg.prototype = {
        constructor: changeImg,

        start: function( time ) {
            var that = this;

            that.stop();
            that.timer = setInterval(function() {
                if( that.idx >= that.imgs.length ) that.idx = 0;
                $('.view').css('background', 'url(' + that.imgs[that.idx] + ')');
                $('.cnt').html(that.idx+1);
                ++that.idx;
            }, time);
        },

        stop: function() {
            clearInterval(this.timer);
        }
    };

    w[ns] = new changeImg();
})(window, jQuery, 'toggleImg');
</script>
				<div class="wrap">
				    <div class="view"></div>
				</div>
