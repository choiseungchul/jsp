<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<style type="text/css">
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
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
}
.front_tab{
	color: #005ea6;
	font-size: 12px;
	font-weight:bold;
}
.rear_tab, .rear_tab a{
	color: #444444;
	font-size: 12px;
}
.top_ranking_strong {
	font-size: 12px;
	font-weight: bold;
}
.hospital-name{
	color: #444444;
	font-weight:bold;
	font-size:15px;
	padding-left:10px;
}
.hospital-info{
	color: #4f4f4f;
	font-size: 12px;
	margin-top:10px;
	line-height:170%;
}
.hospital-ranking-row{
	width:280px;
	height:38px;
	
}
.hospital-ranking-head{
	color: #005ea6;
	font-size: 13px;
	width:60px;
	float:left;
	margin-left:20px;
	margin-top:20px;
	font-weight:bold;
}
.hospital-ranking-value{
	width:180px;
	color: #266dad;
	font-size: 13px;
	text-align:center;
	float:left;
	margin-top:20px;
}
.hospital-ranking-value .grade{
	color: #c70000;
	font-size: 13px;
	font-weight:bold;
}
.hospital-ranking-value .slash{
	color: #87888a;
	font-size: 13px;
}
.hospital-ranking-homepage{
	color: #565656;
	width:240px;
	text-align:left;
	float:left;
	margin-top:20px;
	margin-left:20px;
}
.postingCategory-list{
	list-style:none;
	padding:0px;
	margin:0px;
	height:53px;
	width:608px;
	border-bottom: 1px solid #CCCCCC;
	border-top: 2px solid #CCCCCC;
}
.postingCategory-list > li{
	padding:5px;
	cursor: pointer;
	float:left;
	margin-left:20px;
	width:67px;
}
.posting{
	width:608px;
	float:left;
	border-top: 1px solid #ebeef0;
	border-bottom: 1px solid #ebeef0;
	padding-top: 10px;
	padding-bottom: 10px;
	margin-top:10px;
}
.posting .num{
	width: 35px;
	float: left;
	text-align: center;
}
.posting .photo{
	width: 100px;
	float: left;
	text-align: center;
	margin-right:10px;
}
.posting .infos{
	width: 450px;
	float: left;
}
.posting .infos div{
	line-height: 170%;
}
.posting .infos .subject, .posting .infos .contents, .posting .infos .extra_infos{
	margin-top:5px;
}
.extra_infos{
}
.evaluation-rating{
	width:140px;
	height:100px;
	text-align:left;
	background: url(${contextPath}/images/givus/hospital/rating_blue_star2.gif) no-repeat;
}
.evaluation-rating div{
	margin-left:80px;
	margin-bottom:5px;
}
.evaluation-avgPoint {
	font-size: 30px;
	color:#cf4e51;
}
.evaluation-avgPoint-text{
	margin-top:10px;
}
.evaluation-avgPoint-graph{
	height:8px;
	width:95px;
	padding:0px;
	text-align:left;
	background: url(${imageHandler.g_hospital_rating_average_base}) no-repeat;
}
.evaluation-avgPoint-graph > div{
	height:8px;
	background: url(${contextPath}/images/givus/hospital/rating_average_full.gif) no-repeat;
}
.evaluation-totalCount {
	margin: 0px 5px 0px 25px;
	font-family: "나눔고딕";
	color:#cf4e51;
}
.evaluation-sex{
	margin-top:10px;
	width:100px;
	margin-left:15px;
}
.evaluation-sex-text{
	float:left;
	width:34px;
	margin-right:12px;
}

.evaluation-sex-man-graph{
	width:34px;
	height:88px;
	padding:0px;
	float:left;
	margin-right:10px;
	background: url(${contextPath}/images/givus/hospital/rating_man_full.gif) no-repeat;
}
.evaluation-sex-woman-graph{
	width:41px;
	height:88px;
	padding:0px;
	float:left;
	margin-right:10px;
	background: url(${contextPath}/images/givus/hospital/rating_woman_full.gif) no-repeat;
}
.evaluation-sex-man-graph > div{
	width:34px;
	background: url(${imageHandler.g_hospital_rating_man_base}) no-repeat;
}
.evaluation-sex-woman-graph > div{
	width:41px;
	background: url(${imageHandler.g_hospital_rating_woman_base}) no-repeat;
}
.evaluation-sex-text, .evaluation-generation-text, .evaluation-avgPoint-text{
	color: #444444;
	font-size: 11px;
	font-weight: bold;
}
.evaluation-generation{
	width:120px;
	margin-top:10px;
	margin-left:15px;
}
.evaluation-generation-text{
	float:left;
	margin-right:4px;
}
.evaluation-generation-graph {
	width:19px;
	height:86px;
	background: url(${contextPath}/images/givus/hospital/rating_age_full.gif) no-repeat;
	padding:0px;
	float:left;
	margin-right:10px;
}
.evaluation-generation-graph > div{
	width:19px;
	background: url(${imageHandler.g_hospital_rating_age_base}) no-repeat;
}
.review-header{
	width:610px;
	height:20px;
	border-top: 1px solid #ccc;
	padding-top:3px;
	margin-bottom:10px;
}
.review-header div{
	background-color:#444;
	float:left;
	color:#fff;
	font-weight:bold;
	height:25px;
	text-align:center;
	padding-top:10px;
}
.review-header .header-evaluation{
	width:161px;
}
.review-header .header-average{
	width:130px;
}
.review-header .header-sex{
	width:130px;
}
.review-header .header-age{
	width:187px;
}
.mostview-hospital-list{
	list-style: none;
}
.mostview-hospital-list > li{
	float: left;
	width: 110px;
	height: 110px;
	text-align: center;
	border-bottom:1px solid #ccc;
	margin-top:25px;
}
.mostview-hospital-list .hospitalName{
	text-overflow: ellipsis; /* for browsers that supports it */  
	overflow: hidden; /* for other browsers */
	white-space: nowrap;
}
.writer_info{
	text-align: center;
	color: #837f85;
	padding-top:2px;
}
</style>
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<td class="path_info" align="left">순위 > 전국 TOP 100 > ${hospitalModel.name} 성형외과 </td>
		</tr>
	</table>
	<table width="980" style="margin:auto;margin-top:20px;">
		<tr>
			<td width="150px"><img src="${imageHandler.g_ranking_ranking_title_logo}"></td>
			<td width="500px">
				<c:set var="ranking_name" value="ranking.name.A"/>
			<c:set var="ranking_title_image" value="g_ranking_ranking_title_A"/>
			<c:set var="ranking_top_image" value="g_ranking_ranking_title_top_A"/>
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
				<%-- //////////////// TAP //////////////// --%>
				<table class="table_noborder" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tr height="35px">
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_behind}) no-repeat" align="center">
						<a href="${contextPath}/___/p/hospital/${hospitalModel.id}"><span class="rear_tab">병원정보</span></a>
					</td>
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_behind}) no-repeat" align="center">
						<a href="${contextPath}/___/p/hepilogue/${hospitalModel.id}"><span class="rear_tab">수술후기</span></a>
					</td>
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_front}) no-repeat" align="center"><span class="front_tab">병원리뷰</span></td>
					<td align="left" style="background:url(${contextPath}/images/givus/ranking/ranking_tab_base.gif)">&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;margin-top:10px;">
		<tr>
			<td align="left"  width="608px" valign="top">
				<table style="margin-top:10px;">
					<tr>
						<td colspan="2"><span class="hospital-name">${hospitalModel.name} 성형외과</span></td>
					</tr>
					<tr>
						<td width="281px">
							<div style="width:281px;height:90px;background:url(${imageHandler.g_hospital_comment_bg}) no-repeat">
								<div class="hospital-ranking-row">
									<div class="hospital-ranking-head">RANKING</div>
									<div class="hospital-ranking-value"> ${hospitalModel.ranking}위 <span class="slash">/</span> <span class="grade">${hospitalModel.grade}</span></div>
								</div>
								<div class="hospital-ranking-row">
									
									<div class="hospital-ranking-homepage"><a href="${hospitalModel.homepage}" target="_blank">${hospitalModel.homepage}</a></div>
								</div>
								<div style="width:28px;height:45px;"></div>
							</div>
						</td>
						<td valign="top">
							<div class="hospital-info">${hospitalModel.address}<br/>대표전화) ${hospitalModel.tel}</div>
							<br/><a href="https://twitter.com/share" class="twitter-share-button" data-text="GIVUS TOP 100 [${hospitalModel.name} 성형외과] 병원리뷰" data-via="givus2014">Tweet</a>
								<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
							
						</td>
					</tr>
					
				</table>
				<table style="margin-top:10px;">
					<tr>
						<td colspan="4">
							<div class="review-header">
								<div class="header-evaluation">만족도평가</div>
								<div class="header-average">평점</div>
								<div class="header-sex">성별비율</div>
								<div class="header-age">연령층비율</div>
							</div>
						</td>
					</tr>
				</table>
				<table style="margin-top:10px;" width="100%">
					<tr>
						<td align="center" width="160">
							<div class="evaluation-rating">
								<div>5 [${hospitalEvaluationModel.point5}]</div>
								<div>4 [${hospitalEvaluationModel.point4}]</div>
								<div>3 [${hospitalEvaluationModel.point3}]</div>
								<div>2 [${hospitalEvaluationModel.point2}]</div>
								<div>1 [${hospitalEvaluationModel.point1}]</div>
							</div>
						</td>
						<td align="center" width="130">
							<c:set var="width_totalCount" value="${95 * hospitalEvaluationModel.renderedData.avgPoint / 5}"/>
							<div class="evaluation-avgPoint">${hospitalEvaluationModel.renderedData.avgPoint}</div>
							<div class="evaluation-avgPoint-graph">
								<div style="width:${width_totalCount}px"></div>
							</div>
							<div class="evaluation-avgPoint-text">참여 <span class="evaluation-totalCount">${hospitalEvaluationModel.renderedData.totalCount}</span> 명</div>
						</td>
						<td align="center" width="130">
							<c:set var="height_man" value="${88 * (1 - hospitalEvaluationModel.renderedData.percentageMan / 100)}"/>
							<c:set var="height_woman" value="${88 * (1 - hospitalEvaluationModel.renderedData.percentageWoman / 100)}"/>
							<div class="evaluation-sex">
								<div class="evaluation-sex-man-graph">
									<div style="height:${height_man}px" title="남성"></div>
								</div>
								<div class="evaluation-sex-woman-graph">
									<div style="height:${height_woman}px" title="여성"></div>
								</div>
							</div>
						</td>
						<td align="center" width="180">
							<c:set var="height_generation10" value="${86 * (1 - hospitalEvaluationModel.renderedData.percentage10G / 100)}"/>
							<c:set var="height_generation20" value="${86 * (1 - hospitalEvaluationModel.renderedData.percentage20G / 100)}"/>
							<c:set var="height_generation30" value="${86 * (1 - hospitalEvaluationModel.renderedData.percentage30G / 100)}"/>
							<c:set var="height_generation40" value="${86 * (1 - hospitalEvaluationModel.renderedData.percentage40G / 100)}"/>
							<div class="evaluation-generation">
								<div class="evaluation-generation-graph">
									<div style="height:${height_generation10}px" title="10대"></div>
								</div>
								<div class="evaluation-generation-graph">
									<div style="height:${height_generation20}px" title="20대"></div>
								</div>
								<div class="evaluation-generation-graph">
									<div style="height:${height_generation30}px" title="30대"></div>
								</div>
								<div class="evaluation-generation-graph">
									<div style="height:${height_generation40}px" title="40대"></div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td align="center" width="160">
							
						</td>
						<td align="center" width="130">
							
						</td>
						<td align="center" width="130">
							<div class="evaluation-sex">
								<div class="evaluation-sex-text">남자</div>
								<div class="evaluation-sex-text">여자</div>
							</div>
						</td>
						<td align="center" width="180">
							<div class="evaluation-generation">
								<div class="evaluation-generation-text">10대</div>
								<div class="evaluation-generation-text">20대</div>
								<div class="evaluation-generation-text">30대</div>
								<div class="evaluation-generation-text">40대~</div>
							</div>
						</td>
					</tr>
				</table>
				<table style="margin-top:20px;">
					<tr>
						<td>
							<ul class="postingCategory-list">
								<c:forEach var="postingCategory" items="${postingCategoryModels}">
									<li><a href="${contextPath}/___/p/hreview/${hospitalModel.id}/${postingCategory.id}">${postingCategory.name}[${postingCategory.postingCount}]</a></li>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</table>
				<!--///////// EDIT POSTING START //////////-->
				<script type="text/javascript">
					$(function(){
						$(".write_posting").click( function(){ //hospitalid
							<c:choose>
							<c:when test="${ userType=='H'}">
								alert( "병원사용자는 병원리뷰 작성 권한이 없습니다.");
							</c:when>
							<c:otherwise>
								var url = "${contextPath}/___/posting/review/write?bid=26&hid=${hospitalModel.id}&xpath=${xpath}";
								$("#edit_epilogue").load( url, function(){
									
								}).toggle();
							</c:otherwise>
							</c:choose>
						}).css('cursor','pointer');
						
					});
				</script>
				<img src="${imageHandler.g_hospital_bt_review_write}" alt="병원리뷰쓰기" class="write_posting" >
				<div id="edit_epilogue" style="display:none;"></div>
				<!--///////// EDIT POSTING END //////////-->
				
				<!--///////// VIEW POSTING START //////////-->
				<script type="text/javascript">
					$(function(){
						$(".view_detail").click( function(){
							var url = "${contextPath}/___/posting/review/detail/" + $(this).data('postingid');
							$.blockUI({
								message: 
									$('.detail_infos').load( url, function(){
										
									}),  //$('.detail_infos'),
								css: { width: '800px', height: '680px', border:'none', '-webkit-border-radius': '5px', '-moz-border-radius': '5px', top:'50px', left:'50px'},
								overayCSS:{backgroundColor: '#000000'},
		       					onOverlayClick: $.unblockUI
							});
							
						}).css('cursor','pointer');
						
					});
					
				</script>
				<div class="detail_infos" style="display:none;"></div>
				<!--///////// VIEW POSTING END //////////-->
				
				<table style="margin-top:10px;">
					<c:forEach var="data" items="${dispatcher.datas}">
					<tr>
						<td>
							<div class="posting">
								<div class="num">${data.num}</div>
								<c:set var="writer_infos" value="${fn:split(data.customField2,',')}"/>
								
								
								<div class="photo">
									<c:forEach var="info" items="${writer_infos}" varStatus="status">
										<c:choose>
										<c:when test="${status.count==1}">
											<c:choose>
												<c:when test="${info=='F'}"><img src="${imageHandler.g_hospital_woman}" alt="woman"></c:when>
												<c:otherwise><img src="${imageHandler.g_hospital_man}" alt="man"></c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
										<div class="writer_info">${info}</div>
										</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
								<div class="infos">
									<div class="createDate">${data.renderedData.createDate}</div>
									<div class="subject">${data.renderedData.subject}</div>
									<div class="contents">${data.renderedData.contents}</div>
									<div style="float:left">
										<img src="${imageHandler.g_hospital_view}"> ${data.viewCount}
										<img src="${imageHandler.g_hospital_good}"> <span>${data.recommendCount}</span>
									</div>
									<div class="view_detail" style="float:right" data-postingid="${data.id}">
										<img src="${imageHandler.g_hospital_bt_view_detail}" alt="자세히보기"> 
									</div>
								</div>
								
							</div>
						</td>
					</tr>
					</c:forEach>
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
			<td align="left" valign="top">
				<table style="margin-left:30px;margin-top:10px;margin-bottom:30px;">
					<tr>
						<td align="center"><img src="${imageHandler.g_hospital_view_three}"></td>
					</tr>
					<tr>
						<td>
							<ul class="mostview-hospital-list">
								<c:forEach var="hospitalModel" items="${mostViewedHospitalModels}">
									<li>
										<div class="photo"><a href="${contextPath}/___/p/hospital/${hospitalModel.id}">
										<c:choose>
											<c:when test="${hospitalModel.thumbFileId != null}">
												<img src="${contextPath}/___/file/get/${hospitalModel.thumbFileId}" width="105" >
											</c:when>
											<c:otherwise>
												<img src="${imageHandler.g_ranking_no_image}" width="105" >
											</c:otherwise>
										</c:choose>
										
										</a></div>
										<div class="hospitalName"><a href="${contextPath}/___/p/hospital/${hospitalModel.id}">${hospitalModel.name}</a></div>
									</li>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</table>
				<jsp:include page="/WEB-INF/jsp/givus/givus_ranking_portlet.jsp"/>
			</td>
		</tr>
	</table>
</td></tr></table>