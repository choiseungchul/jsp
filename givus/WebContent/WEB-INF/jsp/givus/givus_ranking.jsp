<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
}
.sub_menues_info {
	color: #444444;
	font-size: 14px;
	font-weight: bold;
}
.top_ranking {
	color: #444444;
	font-size: 12px;
}
.top_ranking_strong {
	font-size: 12px;
	font-weight: bold;
}
.table_noborder {
	border:0;
	border-spacing : 0;
	width: 100%;
}
.hospital-name{
	font-size: 16px;
	font-weight: bold;
	color: #005ea6;
}
.hospital-introduction{
	line-height:170%;
}
.hospital-info-list{
	list-style:none;
	padding:10px 1px 1px 10px;
	margin:0px;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
	font-size: 11px;
}
li{
	line-height:170%;
}
.ranking_img{
	width: 42px;
	height: 50px;
	text-align:center;
	margin-right:10px;
}
.ranking_img2{
	width: 72px;
	height: 50px;
	text-align:center;
	margin-right:10px;
}
.ranking{
	color: #FFF;
	font-size: 32px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
.signup-message{
	margin-top:10px;
}
.ranking-city-list, .ranking-part-list{
	height:30px;
	list-style:none;
	border-bottom: 1px solid #CCCCCC;
}
.ranking-city-list > li{
	margin-top:5px;
	float:left;
	margin-left:17px;
}
.ranking-part-list > li{
	margin-top:5px;
	float:left;
	margin-left:35px;
}
.table-nav-div{
	margin-top:20px;
}
.table-nav, .table-nav-selected{
	margin-left: 5px;
	padding: 3px;
	width: 18px;
	
}
.table-nav-selected{
	font-weight:bold;
}
.thisweekranking-top-upperline {
	color: #CCCCCC;
}

.thisweekranking-top {
	border: 1px solid #DBDEE6;
	background: #ECEFF8;
	color: #D3D3D6;
	font-size: 12px;
	font-family: 나눔고딕 ExtraBold, Arial Unicode MS, sans-serif;
	text-shadow: 1px 1px 1px #FAFAFD;
}
.thisweekranking-lefttab {
	border-bottom: 1px solid #CCCCCC;
	background: #FBFCFC;
	color: #444444;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
	padding:8px 0 0 5px;
}
.thisweekranking-lefttab-subtitles {
	color: #777777;
}
.thisweekranking-rightdata {
	color: #575757;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
}
.thisweekranking-rightdata-underline {
	color: #E1E1E1;
}
.ranking-portlet-goingup {
	color: #B60000;
}
.ranking-portlet-goingdown  {
	color: #2E61A9;
}

.ranking-bot-searchbox {
	border: 1px solid #E5E5E5;
}
</style>
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<c:set var="ranking_name" value="ranking.name.${rankingModel.rankingType}"/>
			<td class="path_info" align="left">
				순위 > ${msgHandler[ranking_name]} > RANKINGS 
			</td>
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
	<table width="980" style="margin:auto;">
		<tr>
			<td height="20px"></td>
		</tr>
		<tr>
			<td>
				<%-- //////////////// TOP RANKING LIST TITLE //////////////// --%>
				<table class="table_noborder" border="0" cellspacing="0" cellpadding="0">
				<tr height="35px">
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_front}) no-repeat" align="center">RANKINGS</td>
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_behind}) no-repeat" align="center">
						<a href="${contextPath}/___/p/rankingdata/${rankingModel.rankingType}/${rankingModel.rankingLocationCode}">RANKINGS DATA</a>
					</td>
					<td align="left" style="background:url(${imageHandler.g_ranking_ranking_tab_base})">&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;">
		<tr>
			<td align="left"  width="608px" valign="top">
				<table>
				<c:if test="${rankingModel.rankingType == 'C'}">
					<tr height="35px">
						<td align="center">
							<ul class="ranking-city-list">
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/B">인천광역시</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/D">대전광역시</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/C">대구광역시</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/E">광주광역시</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/F">울산광역시</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/G">부산광역시</a></li>
							</ul>
						</td>
					</tr>
				</c:if>
				<c:if test="${rankingModel.rankingType == 'D'}">
					<tr height="35px">
						<td align="center">
							<ul class="ranking-part-list">
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/Z/A">눈</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/Z/B">코</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/Z/C">안면윤곽</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/Z/D">가슴</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/Z/E">체형</a></li>
								<li style="width:10px">|</li>
								<li><a href="${contextPath}/___/p/ranking/${rankingModel.rankingType}/Z/F">쁘디</a></li>
							</ul>
						</td>
					</tr>
				</c:if>
				<tr>
					<td>
						<%-- //////////////// TOP RANKING LIST DATA //////////////// --%>
						<c:forEach var="data" items="${dispatcher.datas}">
						<table width="608" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="145px" height="224px" style="text-align:left;padding-left:0px;">
								<div style="width:145px;height:3px;margin-top:5px;background:url(${imageHandler.g_ranking_hospital_outline_top}) no-repeat"></div>
								<div style="width:145px;margin-bottom:5px;background:url(${imageHandler.g_ranking_hospital_outline_mid})">
								<div style="text-align: center;padding-top: 1px;">
								<a href="${contextPath}/___/p/hospital/${data.id}">
								<c:if test="${data.thumbFileId!=null && data.thumbFileId > 0}">
									<img src="${contextPath}/___/file/get/${data.thumbFileId}" width="140" height="105">
								</c:if>
								<c:if test="${data.thumbFileId==null || data.thumbFileId == 0}">
									<img src="${imageHandler.g_ranking_no_image}" width="140" height="105">
								</c:if>
								</a>
								</div>
								
								<ul class="hospital-info-list">
									<li>- 주요수술1 : ${data.mostOperation1}</li>
									<li>- 주요수술2 : ${data.mostOperation2}</li>
									<li>- 전문의수 : ${data.specialistCount}명</li>
									<li>- 마취과수 : ${data.anestheticCount}명</li>
									<li>- 온라인상담 : ${data.counselCount}건</li>
									<li>- 전후사진 : ${data.reviewPicCount}건</li>
									<li>- 외국인유치 : ${data.foreignerReg}</li>
								</ul>
								<div style="width:145px;height:10px;background:url(${imageHandler.g_ranking_hospital_outline_bot}) no-repeat"></div>
							</td>
							<td valign="top">
							<div style="padding:10px;">
								<div style="height:60px;vartical-align:middle;margin-top:10px;">
									<c:if test="${data.ranking <= 99}">
									<c:set var="ranking_bg_image" value="g_ranking_ranking_number_bg_${rankingModel.rankingType}"/>
									<div style="float:left;background:url(${imageHandler[ranking_bg_image]}) center center no-repeat;" class="ranking_img">
										<div class="ranking">${data.ranking}</div>
									</div>
									</c:if>
									<c:if test="${data.ranking > 99}">
										<c:set var="ranking_bg_image" value="g_ranking_ranking_number2_bg_${rankingModel.rankingType}"/>
										<div style="float:left;background:url(${imageHandler[ranking_bg_image]}) center center no-repeat;" class="ranking_img2">
											<div class="ranking">${data.ranking}</div>
										</div>
									</c:if>
									<div style="height:50px;">
										<div class="hospital-name">${data.renderedData.name}</div>
										<div class="hospital-address">${data.address}</div>
									</div>
								</div>
								<div class="hospital-introduction">
									${data.introduction}
								</div>
								<c:if test="${userType ==null}">
								<div class="signup-message">
									<img src="${imageHandler.g_ranking_lock}"> <strong>${data.name}</strong>에서 제공하는 더 많은 정보와, 수술별 가격을 제공받으려면 가입해 주시기 바랍니다.
								</div>
								</c:if>
							</div>
							</td>
						</tr>
						<tr>
							<td colspan=2" style="border-bottom:1px dotted #CCCCCC;"></td>
						</tr>
						</table>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td align="center">
					<%-- navigation --%>
					<c:if test="${not empty dispatcher.navigations}">
						<div class="table-nav-div">
						<c:forEach var="nav" items="${dispatcher.navigations}" varStatus="count">
							<c:if test="${count.count > 1}"><span>&nbsp;|</span></c:if>
							<c:if test="${nav.selected}"><a href="${nav.url}"><span class="table-nav-selected btn btn-small">${nav.name}</span></a></c:if>
							<c:if test="${nav.selected == false}"><a href="${nav.url}"><span class="${nav.className}">${nav.name}</span></a></c:if>
						</c:forEach>
						</div>
					</c:if>
					</td>
				</tr>
				</table>
			</td>
			<td valign="top" align="left">
				<jsp:include page="/WEB-INF/jsp/givus/givus_ranking_portlet.jsp"/>
			</td>
		</tr>
	</table>
</td></tr></table>