<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
}

.top_ranking_strong {
	font-size: 12px;
	font-weight: bold;
}
.table-list{
	margin-top: 10px;
}
.table-list td, .table-list th{
	border: 1px solid #ccc;
}
.table-data-tr{
	height: 35px;
}
.table-data-td{
	font-weight: bold;
	color: #3F3F3F;
}
.ranking_date_info{
	font-size: 20px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
	width:230px;
	margin-right:10px;
	margin-top:5px;
}
.ranking_date_select{
	width:180px;
	height:25px;
	
}
.grade{
	color: #D12F2F;
}
.ranking-city-list, .ranking-part-list{
	height:30px;
	list-style:none;
	border-bottom: 1px solid #CCCCCC;
}
.ranking-city-list > li{
	margin-top:5px;
	float:left;
	margin-left:27px;
}
.ranking-part-list > li{
	margin-top:5px;
	float:left;
	margin-left:45px;
}
.top3-ranking-A, .top3-ranking-A a, .top3-ranking-A a:link {
	color: #005EA6;
	font-weight:bold;
	font-size:14px;
}

.top3-ranking-B, .top3-ranking-B a, .top3-ranking-B a:link {
	color: #B31515;
	font-weight:bold;
	font-size:14px;
}

.top3-ranking-C, .top3-ranking-C a, .top3-ranking-C a:link {
	color: #0D5C47;
	font-weight:bold;
	font-size:14px;
}

.top3-ranking-D, .top3-ranking-D a, .top3-ranking-D a:link {
	color: #9B491D;
	font-weight:bold;
	font-size:14px;
}
.hospitalName, .hospitalName a, .hospitalName a:link{
	color: #005EA6;
}
.prevMonth, .nextMonth{
	width:100px;float:left;
	cursor:pointer;
}

</style>
<script>
$(function(){
	$('.table-data-tr:odd').css('background-color','#eceff8');
	<c:if test="${param.RDC_pageno == null || param.RDC_pageno != '2'}">
	$('.table-data-tr:lt(3) .ranking').addClass('top3-ranking-${rankingModel.rankingType}');
	$('.table-data-tr:lt(3) .hospitalName').removeClass('hospitalName').addClass('top3-ranking-${rankingModel.rankingType}');
	</c:if>
});
$(function(){
	$('.ranking_date_select').change( function(){
		var selectedValue = $('.ranking_date_select option:selected').val();
		var url = '${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/${rankingModel.rankingLocationCode}?rankingId=' + selectedValue;
		location.href = url;
	});
	$('.prevMonth').click( function(){
		var url = '${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/${rankingModel.rankingLocationCode}?startDate=${prevMonth}';
		location.href = url;
	});
	$('.nextMonth').click( function(){
		var url = '${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/${rankingModel.rankingLocationCode}?startDate=${nextMonth}';
		location.href = url;
	});
});
</script>
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<c:set var="ranking_name" value="ranking.name.${rankingModel.rankingType}"/>
			<td class="path_info" align="left">순위 > ${msgHandler[ranking_name]} > RANKINGS DATA </td>
		</tr>
	</table>
	
	<table width="980" style="margin:auto;margin-top:20px;">
		<tr>
			<td width="150px"><img src="${imageHandler.g_ranking_ranking_title_logo}"></td>
			<td width="500px">
				<c:set var="ranking_title_image" value="g_ranking_ranking_title_${rankingModel.rankingType}"/>
				<c:set var="ranking_top_image" value="g_ranking_ranking_title_top_${rankingModel.rankingType}"/>
				<div style="padding-bottom:15px;" align="left"><img src="${imageHandler[ranking_title_image]}"><br/><img src="${imageHandler[ranking_top_image]}"></div>
				<div style="line-height:170%;text-align:left;width:500px">국내 ${msgHandler[ranking_name]} 성형외과들의 <span class="top_ranking_strong">위치, 전문의 수, 마취과 여부, 서비스 퀄리티, 전문의 평가</span> 등 이해하기 위한 정보들을 제공합니다.
				<p>※ 각 성형외과 홈페이지에 제공하는 정보와 공식적인 통계자료를 기준으로 기재합니다.</P>
				</div>
			</td>
			<td ><a href='http://www.worldvision.or.kr' target='_blank'><img src="${imageHandler.g_ads_ranking_ad1}" alt="" width="330" border=0 align="right"/><!-- <img src='http://www.worldvision.or.kr/images/banner/180_180.jpg' border=0 align="right"> --></a></td>
		</tr>
	</table>
	<table width="980" style="margin:auto;margin-top:20px;">
		<tr height="35px">
			<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_behind}) no-repeat" align="center">
				<a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/${rankingModel.rankingLocationCode}">RANKING</a>
			</td>
			<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_front}) no-repeat" align="center">RANKING DATA</td>
			<td align="left" style="background:url(${imageHandler.g_ranking_ranking_tab_base})">&nbsp;</td>
		</tr>
	</table>
	<c:if test="${rankingModel.rankingType == 'C'}">
	<table width="980" style="margin:auto;margin-top:5px;">
		<tr height="35px">
			<td align="center">
				<ul class="ranking-city-list">
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/B">인천광역시 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/D">대전광역시 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/C">대구광역시 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/E">광주광역시 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/F">울산광역시 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/G">부산광역시 TOP10</a></li>
				</ul>
			</td>
		</tr>
	</table>
	</c:if>
	<c:if test="${rankingModel.rankingType == 'D'}">
	<table width="980" style="margin:auto;margin-top:5px;">
		<tr height="35px">
			<td align="center">
				<ul class="ranking-part-list">
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/Z/A">눈 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/Z/B">코 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/Z/C">안면윤곽 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/Z/D">가슴 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/Z/E">체형 TOP10</a></li>
					<li style="width:10px">|</li>
					<li><a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/Z/F">쁘디 TOP10</a></li>
				</ul>
			</td>
		</tr>
	</table>
	</c:if>
	<table width="980" style="margin:auto;margin-top:10px;margin-bottom:10px;">
		<tr height="30px">
			<td align="center">
				<%-- //////////////// RANKING DATE //////////////// --%>
				<div style="width:510px;text-align:center;">
					<div class="prevMonth"><img src="${imageHandler.g_ranking_previewB}">이전달</div>
					<div style="width:310px;float:left;">
						<span class="ranking_date_info">${weekInfo}</span>
						<c:if test="${rankingModels != null}">
						<select class="ranking_date_select">
							<c:forEach var="ranking" items="${rankingModels}">
								<c:set var="selected" value=""/>
								<c:if test="${param.rankingId == ranking.id}">
									<c:set var="selected" value="selected"/>
								</c:if>
							<option value="${ranking.id}" ${selected}>${ranking.renderedData.startDate} ~ ${ranking.renderedData.endDate}</option>
							</c:forEach>
						</select>
						</c:if>
					</div>
					<div class="nextMonth">다음달<img src="${imageHandler.g_ranking_nextB}"></div>
				</div> 
			</td>
		</tr>
	</table>
	<table class="table-list" border="1" width="980" style="margin:auto;">
		<tr class="table-header-tr">
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_ranking}" alt="순위"/></th>
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_hospitalname}" alt="병원명"/></th>
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_grade}" alt="등급"/></th>
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_total}" alt="평균"/></th>
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_special}" alt="전문성(20%)" title="성형외과 전공의여부, 과별수술진행,신수술법,업계평판(학술임원,언론기사,봉사활동 등)으로 판단합니다."/></th>
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_safety}" alt="안정성(30%)" title="마취과유무, 수술건수,최신의료기기 보유,수술클레임(정부공개 및 언론기사 등)으로 판단합니다."/></th>
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_satisfyability}" alt="만족도(30%)" title="홈페이지 전후사진수,클레임,후기만족도,연예인방문여부,수상여부,붓기치료,주차별프로그램관리로 판단합니다."/></th>
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_sizeability}" alt="규모(10%)" title="의료진수,병워사이즈,통역유무,픽업서비스,사회공헌여부로 판단합니다."/></th>
			<th class="table-header-td" width="${head.width}"><img src="${imageHandler.g_rankingdata_header_convenience}" alt="편의성(10%)" title="온라인상담건수, 수술후 고객게시판 여부, 입원실 및 회복실 여부, 시설퀄리티, 가상성형지원 여부로 판단합니다."/></th>
		</tr>
		<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
			<tr class="table-data-tr" id="${dispatcher.function.id}_tr_${data.id}">
				<c:forEach var="head" items="${dispatcher.headers}">
					<td class="table-data-td ${head.name}" align="${head.align}">
						<c:choose>
							<c:when test="${data.renderedData[head.name] != null}">
							${data.renderedData[head.name]} 
							</c:when>
							<c:otherwise>
							${data[head.name]}
							</c:otherwise>
						</c:choose>
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
	<c:if test="${rankingModel.rankingType == 'A'}">
	<table width="980" style="margin:auto;margin-top:10px;margin-bottom:10px;">
		<tr height="30px">
			<td>
				<div style="text-align:right">
					<a href="${dispatcher.navigations[0].url}"><img src="${imageHandler.g_rankingdata_up}"> 1-50위</a>
					<a href="${dispatcher.navigations[1].url}"><img src="${imageHandler.g_rankingdata_down}"> 51-100위</a>
				</div> 
			</td>
		</tr>
	</table>
	</c:if>
</td></tr></table>