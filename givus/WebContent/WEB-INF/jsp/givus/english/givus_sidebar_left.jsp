<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="fl_menu">
	<div><img src="${imageHandler.g_sidebar_real_ranking_header}"></div>
	<div class="realtime-rankings"></div>
	<div style="margin-top:2px;"><a href="${contextPath}/___/p/price/compare"><img src="${imageHandler.g_sidebar_button_price_compare}" alt="성형 가격 비교" title="병원들의 성형 가격을 비교할 수 있습니다."></a></div>
	<div style="margin-top:2px;"><a href="${contextPath}/___/p/msg/create"><img src="${imageHandler.g_sidebar_button_write_message}" alt="쪽지 쓰기" title="쪽지쓰기 입니다"></a></div>
</div>
<style type="text/css">
#fl_menu{position:fixed;width:130px;height:350px;overflow:hidden;margin-left:10px;}
.realtime-rankings{
	width:116px;
	height:200px;
	border:1px solid #ccc;
	background-color: #FFFFFF;
}
.ranking-div{
	width:116px;
	height:20px;
}
.realtime-ranking-ranking{
	margin-top:2px;
	text-align:center;
	width:28px;
	float:left;
}
.realtime-ranking-hospitalName{
	margin-top:2px;
	text-align:center;
	width:88px;
	float:left;
}
.ranking-top3, .ranking-top3 a:hover, .ranking-top3 a{
	font-weight:bold;
	color: #005EA6;
	font-size:12px;
}
</style>
<script>
$(function($) {
    function fixDiv() {
      var $cache = $('#fl_menu'); 
      $cache.css({'position': 'fixed', 'top': 'auto'}); 
    }
    $(window).scroll(fixDiv);
    fixDiv();
    
    var url = '${contextPath}/___/hospital/realranking';
    $.getJSON( url, function( data){
    	$.each( data, function( index, item){
    		var ranking = $("<div class='ranking-div'></div>");
    		ranking.append("<div class='realtime-ranking-ranking'>" + item.ranking + "</div>");
    		ranking.append("<div class='realtime-ranking-hospitalName'> <a href='${contextPath}/___/p/hospital/" + item.hospitalId + "'>"+ item.name + "</a></div>");
    		$('.realtime-rankings').append( ranking);
    	});
    	
    	$('.realtime-rankings .ranking-div:nth-child(even)').css('background-color','#ECEFF8');
    	$('.realtime-rankings .ranking-div:lt(3)').addClass('ranking-top3');
	});
});
</script>
