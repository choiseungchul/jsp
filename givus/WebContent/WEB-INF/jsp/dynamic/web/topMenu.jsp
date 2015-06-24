<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="css.jsp" %> 
<%-- <link type="text/css" href="${contextPath}/style/topmenu.css" rel="stylesheet"/> --%>

<c:if test="${dispatcher.menus != null}">

<nav id="tabBar">
<%-- <li class="topLogo"><a href="${contextPath}/index.jsp" target="_top"><img src="${imageHandler.sinshin_logo_title_gray}"/></a></li> --%>
	<ul id="topmenu_subtab" class="topTab">
		<c:forEach var="menu" items="${dispatcher.menus}" varStatus="datasLoop">
			<li class="menu-normal" id="topmenuTab${datasLoop.count}" onmouseover="displayTopTabMenu('topmenuTab${datasLoop.count}')" onmouseout="hideTopTabMenu('topmenuTab${datasLoop.count}')">
				<a href="${menu.url}" target="${menu.target}">${menu.title}</a> 
			</li>
		</c:forEach>
	</ul>
</nav>

<SCRIPT type=text/javascript>
/*
* @desc : top tab menu
*/
function displayTopTabMenu(menuId) {
	$("li").each(function(){
		if( $(this).attr('id') != menuId && $(this).attr('clicked') != 'true'){
			$(this).removeClass("menu-over").addClass( "menu-normal");
		}else{
			$(this).removeClass("menu-normal").addClass( "menu-over");
		}
	});
}

function hideTopTabMenu(){
	$("li").each(function(){
		if( $(this).attr('clicked') != 'true'){
			$(this).removeClass("menu-over").addClass('menu-normal');
		}
	});
}

// 각 메뉴별 click 이벤트 설정
$(function(){
	$("li a").click( function(){
		var li = $(this).closest('li');
		li.removeClass("menu-normal").addClass( "menu-over").attr('clicked', 'true');
		var selectedId = li.attr('id');
		
		$("li").each( function(){
			console.log( $(this));
			if( $(this).attr('id') != selectedId){
				/* $(this).removeClass("topTab menu-over").addClass( "topTab menu-normal").attr('clicked', ''); */
				$(this).removeClass("menu-over").addClass( "menu-normal").attr('clicked', '');
			}
		});
	}).first().click();
});
</SCRIPT>


<style>
<!--top menu tab css start-->
#tabBar {
	padding:0px;
	display:inline;	

	
}
/* .topMenu {
	overflow: hidden;
	display:inline;
} */

#tabBar .topTab {
	padding: 0px;
	/* BACKGROUND: url(${contextPath}/images/bg_topmenutab.gif) no-repeat left top; */ 
	OVERFLOW: hidden; 
	border-bottom: 3px solid #efefef;

}
.topTab li {
	float: left; 
	list-style-type: none;
	display: block; 
	width: 110px;
	height:18px;
	text-align: center;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
	font-size:11px;
}

.menu-over{
	font-weight: bold;
	border-top: 2px solid #9db0d1;
	border-left: 2px solid #9db0d1;
	border-right: 2px solid #9db0d1;
	background-color: #efefef;
	padding-top: 8px; 
	border-bottom: none;
}
.menu-normal{
	border-top: 1px solid #c5c5c5;
	border-left: 1px solid #c5c5c5;
	border-right: 1px solid #c5c5c5;
	background-color: #ffffff;
	padding-top: 7px; 
	border-bottom: 2px solid #9db0d1;
}
<!--top menu tab css end-->

</style>

</c:if>