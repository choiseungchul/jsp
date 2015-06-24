<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="fl_menu">
	<div><img src="${imageHandler.g_sidebar_real_ranking_list}"></div>
	<div><a href="${contextPath}/___/p/price/compare"><img src="${imageHandler.g_sidebar_button_price_compare}"></a></div>
	<div>
		<a href="${contextPath}/___/p/msg/create"><img src="${imageHandler.g_sidebar_button_write_message}"></a>
	</div>
</div>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/jquery.easing.1.3.js"></script>
<style type="text/css">
#fl_menu{position:fixed;width:100px;height:300px;}
</style>
<script>
//config
$float_speed=1500; //milliseconds
$float_easing="easeOutQuint";
$menu_fade_speed=500; //milliseconds
$closed_menu_opacity=0.75;

//cache vars
$fl_menu=$("#fl_menu");
$fl_menu_menu=$("#fl_menu .menu");
$fl_menu_label=$("#fl_menu .label");

$(function(){
	menuPosition=$('#fl_menu').position().top;
	FloatMenu();
	$fl_menu.hover(
		function(){ //mouse over
			$fl_menu_label.fadeTo($menu_fade_speed, 1);
			$fl_menu_menu.fadeIn($menu_fade_speed);
		},
		function(){ //mouse out
			$fl_menu_label.fadeTo($menu_fade_speed, $closed_menu_opacity);
			$fl_menu_menu.fadeOut($menu_fade_speed);
		}
	);
})

$(window).scroll(function () { 
	FloatMenu();
});

function FloatMenu(){
	var scrollAmount=$(document).scrollTop();
	var newPosition=menuPosition+scrollAmount;
	if($(window).height()<$fl_menu.height()+$fl_menu_menu.height()){
		$fl_menu.css("top",menuPosition);
	} else {
	}
}

function checkAuthority(){
}
</script>

