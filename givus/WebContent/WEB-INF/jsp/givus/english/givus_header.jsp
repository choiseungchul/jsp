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
	width:110px;
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
	height:37px;
	width:200px;
	border: #dde3f2 1px solid;
	border-radius: 5px 5px 5px 5px;
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
			//$( '.login_window' ).toggle( 'slow' );
			$.blockUI({ 
				message: $('#login_form'), 
				css: { width: '404px', height : '248px', border:'none', backgroundColor: '', '-webkit-border-radius': '5px', '-moz-border-radius': '5px'/* , opacity: .9 */},
				overlayCSS:{ backgroundColor: '#000000'} ,
				onOverlayClick: $.unblockUI
			});
			
			$('.login-ok').click(function() { 
				if( typeof $('#login_account').val() === 'undefined'|| $('#login_account').val()==''){
					alert( 'There is no user name.'+$('#login_account').val());
					return false; 
				}
				else if(  typeof $('#login_password').val() === 'undefined'|| $('#login_password').val()==''){
					alert( 'There is no password.'+$('#login_password').val());
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

});

</script>

<%-- //////////////// JOIN GIVUS //////////////// --%>

<div id="join-type-form" title="회원가입" style="display:none;">
	<ol id="selectable">
		<li class="ui-widget-content">general user</li>
		<li class="ui-widget-content">hospital user</li>
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
					<td width="140" height="45" valign="top"><%-- <img src="${imageHandler.g_popup_bt_popup}" alt="로그인" width="87" height="32" tabindex="3" class="login-ok" /> --%>
						<div class="login-ok" tabindex="3">login</div>
					</td>
				</tr>
				<tr>
					<td width="260" height="45" valign="top"><input type="password" name="password" id="login_password" class="login-input" style="height: 32px;" onclick="this.blur" tabindex="2"></td>
					<td width="140" height="45" valign="top"><%-- <img src="${imageHandler.g_popup_bt_popup}" alt="취소" width="87" height="32" class="login-cancel"/> --%>
						<div class="login-cancel" tabindex="4">cancel</div>
					</td>
				</tr>
				<tr>
					<td height="20" valign="top"><div class="login-hint"><input type="checkbox" tabindex="5" style="color:#A0A0A0;"> save ID</div></td>
				</tr>
				<tr>
					<td height="30" valign="middle" ><span style="margin-left: 50px;float: left;">
						<img src="${imageHandler.g_popup_icon_notice}" alt="!">
						<img src="${imageHandler.g_popup_msg_search_idpw }" alt="Do you forget your ID or Password?"></span>
					</td>
					<td width="140" height="30" valign="middle">
						<div class="login-search-idpw" tabindex="6" style="width: 90px; height:28px;text-align: middle;padding: 5px 0px 8px 0px;"><span style="padding: 5px 14px 8px 14px;">Search ID/PW</span></div>
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
			<%-- <td width="154" style="text-align:center;background:url(${imageHandler.g_top_login_left_bg});"></td> --%>
			<td width="980" align="center">
				<table width="980" border="0" cellspacing="0" cellpadding="0" style="text-align:center;background:url(${imageHandler.g_top_login_center_bg}) repeat-x;">
				<tr>
					<td valign="middle">
						<ul class="top_login_list">
							<c:choose>
							<c:when test="${userAccount !=null }">
								<li><c:if test="${userNickname !=null}">${userNickname} | </c:if></li>
								<li><a href="${contextPath}/logout.do">Log out</a></li>
									<c:if test="${userType !=null && userType == 'G'}">
								<li>|</li>
								<li>
									<a href="${contextPath}/___/p/msg/receive/m" id="btn-mypage-generaluser" >My Page</a>
								</li>
									</c:if>
									<c:if test="${userType !=null && userType == 'H'}">
								<li>|</li>
								<li>
									<a href="${contextPath}/___/p/msg/receive/h" id="btn-mypage-hospitaluser" >Hospital page</a>
								</li>
									</c:if>
									<c:if test="${userType !=null && userType == 'M'}">
								<li>|</li>
								<li>
									<a href="${contextPath}/___/p/msg/receive/m" id="btn-mypage-generaluser" >My Page</a> 
								</li>
								<li>|</li>
								<li>
									<a href="${contextPath}/___/p/msg/receive/h" id="btn-mypage-hospitaluser" >Hospital Page</a>
								</li>
									</c:if>
							</c:when>
							<c:otherwise>
								<li><div class="top_login_space">&nbsp;</div><a href="#" class="btn-login" >Log in</a></li>
								<li>|</li>
								<li><a href="#" id="btn-join" >Join us</a></li>
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
								
							<c:if test="${userAccount !=null && userType !=null && userType == 'M' }">
								<li>|</li>
								<li><a href="${contextPath}/___/p/msg/create" style="margin-left:10px;">쪽지</a></li>
								<li>|</li>
								<li><a href="${contextPath}/admin_main.jsp" style="margin-left:10px;" target="_blank">Manager Page</a> </li>
							</c:if>
						</ul>
					</td>
				</tr>
				</table>
			</td>
			
		</tr>
		<tr>
			
			<td width="980"><a href="${contextPath}/___/p/english/main"><img src="${imageHandler.g_top_title_main_center }" width="980" height="71"></a></td>
			
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
									<li><a href="${contextPath}/___/p/howToUseGivus">How to use GIVUS</a></li>
									<li><a href="${contextPath}/___/p/notice">Contact Us</a></li>
								</ul>
							</li>
							<li><a href="${contextPath}/___/p/ranking/A?fid=HE">Ranking</a>
								<ul class="topmenu-sublist">
									<li><a href="${contextPath}/___/p/ranking/A?fid=HE">nation's TOP 100</a></li>
									<li><a href="${contextPath}/___/p/ranking/B">Seoul TOP 50</a></li>
									<li><a href="${contextPath}/___/p/ranking/C">Areas TOP 10</a></li>
									<li><a href="${contextPath}/___/p/ranking/D">Parts TOP 10</a></li>
								</ul>
							</li>
							<li><a href="${contextPath}/___/p/surgeryinfo">Plastic Surgery</a>
								<ul class="topmenu-sublist">
									<li><a href="${contextPath}/___/p/surgeryinfo/19/69">Information</a></li>
									<li><a href="${contextPath}/___/p/surgeryinfo/19/68">News</a></li>
									<li><a href="${contextPath}/___/p/price/compare">Comparing Price</a></li>
								</ul>
							</li>
							
								<ul class="topmenu-sublist">
									<li><a href="${contextPath}/___/p/board/1">일반회원공간</a></li>
									<c:if test="${userType !=null && ( userType == 'H' || userType == 'M')}">
									<li><a href="${contextPath}/___/p/hboard">병원회원공간</a></li>
									</c:if>
								</ul>
							</li>
							<li><a href="${contextPath}/___/p/event">병원이벤트</a></li> 
							<li><a href="${contextPath}/___/p/hospitalpr">Hospital PR</a></li>
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

	<table width="980" style="margin:auto;" style="float:center">
		<tr>
			<td><div id="logo"><img src="${imageHandler.g_main_banner5}"></div></td>
		</tr>
	</table>
</td></tr></table> --%>
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
