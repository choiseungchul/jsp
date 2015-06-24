<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<style>
.no_bg_gray, .no_bg_blue, .no_bg_gray2{
	text-align: center;
	height:14px;
	width:15px;
	float:left;
	margin-top:3px;
	margin-right:10px;
	padding-bottom:2px;
}
.no_bg_gray{
	background: url(${imageHandler.g_main_no_bg_gray}) no-repeat bottom;
}
.no_bg_blue{
	background: url(${imageHandler.g_main_no_bg_blue}) no-repeat bottom;
}
.no_bg_gray2{
	width:21px;
	background: url(${imageHandler.g_main_no_bg_gray2}) no-repeat bottom;
}
.ranking_no_font{
	color: #FFFFFF;
	font-size:10px;
	
}
.ranking-portlet-goingup{
	color: #b60000;
}
.ranking-portlet-goingdown{
	color: #2e61a9;
}
</style>
<ul class="ranking-hospital-list">
<c:set var="navSize" value="${fn:length(dispatcher.navigations)}"/>
<c:if test="${not empty dispatcher.navigations && navSize > 1}">
	<c:forEach var="nav" items="${dispatcher.navigations}" varStatus="count">
		<c:if test="${nav.selected}">
			<c:set var="countstart" value="${(nav.name - 1) * 10}"/>
		</c:if>
	</c:forEach>
</c:if>
	<c:forEach var="data" items="${dispatcher.datas}" varStatus="count">
	<c:set var="ranking_no_bg" value="no_bg_gray"/>
	<c:set var="ranking_no" value="${countstart + count.count}"/>
	
	<c:if test="${ranking_no <=3 }"><c:set var="ranking_no_bg" value="no_bg_blue"/></c:if>
	<c:if test="${ranking_no >= 100 }"><c:set var="ranking_no_bg" value="no_bg_gray2"/></c:if>
	<li>
		<div style="width:150px;float:left;"><div class="${ranking_no_bg}"><span class="ranking_no_font">${ranking_no}</span></div>${data.renderedData.hospitalName}</div>
		<div style="width:30px;float:right;height:25px;">
			<c:choose>
				<c:when test="${ data.rankingChange == null}"><img src="${imageHandler.g_ranking_thisweekranking_new}" align="absmiddle"><span>&nbsp;</span></c:when>
				<c:when test="${ data.rankingChange > 0}"><img src="${imageHandler.g_ranking_thisweekranking_goingup}"> <span class="ranking-portlet-goingup">${data.rankingChange}</span></c:when>
				<c:when test="${ data.rankingChange == 0}"><img src="${imageHandler.g_ranking_thisweekranking_stay}" align="absmiddle"><span>&nbsp;</span></c:when>
				<c:when test="${ data.rankingChange < 0}"><img src="${imageHandler.g_ranking_thisweekranking_goingdown}"> <span class="ranking-portlet-goingdown">${data.rankingChange}</span></c:when>
			</c:choose>
		</div>
	</li>
	</c:forEach>
</ul>
<c:set var="navSize" value="${fn:length(dispatcher.navigations)}"/>
<c:if test="${not empty dispatcher.navigations && navSize > 1}">
	<div class="table-nav-div">
	<c:forEach var="nav" items="${dispatcher.navigations}" varStatus="count">
		<c:if test="${nav.selected}">
			<c:set var="navSelected" value="${nav.name}"/>
			<span class="table-nav-selected btn btn-small">${nav.name}</span> / ${navSize}
		</c:if>
	</c:forEach>
	<img id="btn_previous" src="${imageHandler.g_ranking_previous}">
	<img id="btn_next" src="${imageHandler.g_ranking_next}">
	</div>
	<c:choose>
		<c:when test="${navSelected == 1}">
			<c:set var="previousNum" value="1"/>
			<c:set var="nextNum" value="${navSelected + 1}"/>
		</c:when>
		<c:when test="${navSelected == navSize}">
			<c:set var="previousNum" value="${navSelected - 1}"/>
			<c:set var="nextNum" value="${navSize}"/>
		</c:when>
		<c:otherwise>
			<c:set var="previousNum" value="${navSelected - 1}"/>
			<c:set var="nextNum" value="${navSelected + 1}"/>
		</c:otherwise>
	</c:choose>
	<script>
	$(function(){
		$('#btn_previous').click(function(){
			var rankingType = $('.ranking-type-selected').attr('rankingType');
			var rankingLocationCode = $('.ranking-type-selected').attr('rankingLocationCode');
			var rankingPartCode = $('.ranking-type-selected').attr('rankingPartCode');
			var url = '${contextPath}/___/ranking/getRecent/' + rankingType;
			if( rankingLocationCode){
				url += '/'+rankingLocationCode;
			}
			if( rankingPartCode){
				url += '/'+rankingPartCode;
			}
			url+= '?${dispatcher.function.id}_pageno=${previousNum}'; 
			$('.ranking-portlet-right').load( url, function( responseText){
				console.log( responseText);
			});
		});
		$('#btn_next').click(function(){
			var rankingType = $('.ranking-type-selected').attr('rankingType');
			var rankingLocationCode = $('.ranking-type-selected').attr('rankingLocationCode');
			var rankingPartCode = $('.ranking-type-selected').attr('rankingPartCode');
			var url = '${contextPath}/___/ranking/getRecent/' + rankingType;
			if( rankingLocationCode){
				url += '/'+rankingLocationCode;
			}
			if( rankingPartCode){
				url += '/'+rankingPartCode;
			}
			url+= '?${dispatcher.function.id}_pageno=${nextNum}'; 
			$('.ranking-portlet-right').load( url, function( responseText){
				console.log( responseText);
			});
		});
	});
	</script>
</c:if>