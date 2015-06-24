<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<script src="${contextPath}/script/jqueryui/plugin/jquery.simplemodal-1.4.4-patched.js"></script>
<style>
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
}
.list-table{
	border:1px solid #ccc;
	table-layout: fixed;
}
.title{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
}
.list-table th, .list-table td{
	border-left:1px solid #ccc;
	border-right:1px solid #ccc;
}
.list-table td{
	width:150px;
	text-overflow: ellipsis; /* for browsers that supports it */  
	overflow: hidden; /* for other browsers */
	white-space: nowrap;
	line-height:170%;
}
.list-table .eventPrice{
	font-weight: bold;
	color: #F00;
}
.list-table .hospitalName{
	font-weight:bold;
}
.list-table .header{
	background:url(${imageHandler.g_hospitalevent_header}) repeat-x;
	height:43px;
	font-weight:bold;
	text-align:center;
}
.list-table .value{
	height:35px;
}
.td-left{
	padding-left:10px;
}
.table-nav-div {
	text-align: center;
	margin-top: 20px;
}
.event_detail{
	display:none;
	height:510px; width:880px;
}
.event-best{
	width:980px;
	height:280px;
	background: url(${imageHandler.g_hospitalevent_best_bg}) no-repeat;
}
.best-view, .best-recommend{
	width:490px;
	float:left;
}
.event-best .title{
	text-align:center;
	font-weight: bold;
	font-size: 14px;
	font-family: "나눔고딕 ExtraBold";
	color: #0059A4;
	width:475px;
	height: 31px;
	padding-top:15px;
}
.best-view .contents{
	width:475px;
	height:208px;
	margin-left:14px;
}
.best-recommend .contents{
	width:475px;
	height:208px;
	margin-left:15px;
}
.best-nav{
	position:absolute;
	width: 475px;
	height: 20px;
	text-align:right;
	margin-top:15px;
}
/* Overlay */
#simplemodal-overlay {background-color:#000;}

/* Container */
#simplemodal-container {height:520px; width:890px;background-color:#fff;border:1px solid #ccc; padding:12px;}
#simplemodal-container a.modalCloseImg {background:url(${imageHandler.g_popup_icon_close}) no-repeat; width:25px; height:29px; display:inline; z-index:3200; position:absolute; top:0px; right:0px; cursor:pointer;}
</style>
<script>
$(function(){
	$('.view_detail').click(function(){
		$('.event_detail').modal();
		var url = "${contextPath}/___/hospitalevent/" + $(this).data('hospitalid');
		$('.event_detail').load( url, function(){
			
		});
	}).css('cursor', 'pointer');
	
	$('.list-table tr:nth-child(odd)').css('background-color','#ECEFF8');
	
	var url = '${contextPath}/___/hospitalevent/bestrecommend';
	$('.best-recommend .contents').load( url, function(){});
	var url = '${contextPath}/___/hospitalevent/bestview';
	$('.best-view .contents').load( url, function(){});
	
	$('.button_next').click( function(){
		var curPage = parseInt( $(this).closest('.best-nav').find( '.curPage').text());
		if( curPage < 3){
			var url = $(this).closest('.best-nav').data('url') + (curPage + 1);
			$(this).closest('.best-nav').siblings('.contents').load( url, function(){
				$(this).siblings('.best-nav').find( '.curPage').text( curPage + 1);
			});
		}
	}).css('cursor','pointer');
	
	$('.button_previous').click( function(){
		var curPage = parseInt( $(this).closest('.best-nav').find( '.curPage').text());
		if( curPage > 1){
			var url = $(this).closest('.best-nav').data('url') + (curPage - 1);
			$(this).closest('.best-nav').siblings('.contents').load( url, function(){
				$(this).siblings('.best-nav').find( '.curPage').text( curPage - 1);
			});
		}
	}).css('cursor','pointer');
});
</script>
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<td class="path_info" align="left"> 병원이벤트 </td>
		</tr>
	</table>
	<table width="980" style="margin:auto;margin-top:10px;">
		<tr>
			<td>
				<div class="event-best">
					<div class="best-view">
						<div class="best-nav" data-url="${contextPath}/___/hospitalevent/bestview?${funcHandler.funcHospitalListOrderByViewCount.id}_pageno=">
							<span class="curPage">1</span> / <span class="maxPage">3</span>
							<span class="button_previous"><img src="${imageHandler.g_hospitalevent_previous}"></span>
							<span class="button_next"><img src="${imageHandler.g_hospitalevent_next}"></span>
						</div>
						<div class="title">
							BEST 조회수 성형외과
						</div>
						<div class="contents"></div>
					</div>
					<div class="best-recommend">
						<div class="best-nav" data-url="${contextPath}/___/hospitalevent/bestrecommend?${funcHandler.funcHospitalEventListOrderByRecommendCount.id}_pageno=">
							<span class="curPage">1</span> / <span class="maxPage">3</span>
							<span class="button_previous"><img src="${imageHandler.g_hospitalevent_previous}"></span>
							<span class="button_next"><img src="${imageHandler.g_hospitalevent_next}"></span>
						</div>
						<div class="title">BEST 추천 이벤트</div>
						<div class="contents"></div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:5px;">
		<tr>
			<td colspan="6" class="title"><img src="${imageHandler.g_right_subtitle_icon}"> 이벤트 시술가격</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;" class="list-table">
		<tr>
			<th class="header" width="150">병원이름</th>
			<th class="header" width="150">주소</th>
			<th class="header">이벤트</th>
			<th class="header" width="200">가격</th>
			<th class="header" width="100">상세보기</th>
			<th class="header" width="100">조회수</th>
		</tr>
		<c:forEach var="data" items="${dispatcher.datas}">
		<tr>
			<td class="value hospitalName" align="center">${data.hospitalName}</td>
			<td class="value td-left">${data.hospitalAddress}</td>
			<td class="value td-left">${data.event}</td>
			<td class="value eventPrice" align="center">${data.renderedData.minPrice} ~ ${data.renderedData.maxPrice}</td>
			<td class="value" align="center"><div class="view_detail" data-hospitalId="${data.id}"><img src="${imageHandler.g_hospitalevent_button_detail}"></div></td>
			<td class="value" align="center"></td>
		</tr>
		</c:forEach>
	</table>
	<table width="980" style="margin:auto;maring-top:20px;"><tr><td>
	<%-- navigation --%>
	<div class="table-nav-div">
		<c:forEach var="nav" items="${dispatcher.navigations}" varStatus="count">
			<c:if test="${count.count > 1}">|</c:if>
			<c:if test="${nav.selected}"><span class="table-nav-selected">${nav.name}</span></c:if>
			<c:if test="${nav.selected == false}"><a href="${nav.url}"><span class="nav" url="${nav.url}">${nav.name}</span></a></c:if>
		</c:forEach>
	</div>
	</td></tr></table>
	<div class="event_detail"></div>
</td></tr></table>