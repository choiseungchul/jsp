<%@page import="kr.co.zadusoft.givus.util.GivusConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
	width: 170px;
	float: left;
	text-align: center;
	margin-right:10px;
}
.posting .infos{
	width: 380px;
	float: left;
}
.posting .infos div{
	line-height: 170%;
}
.posting .infos .subject, .posting .infos .contents{
	margin-top:5px;
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
.write_posting{
	margin-top:20px;
}

</style>

<script type="text/javascript">
	$(function(){
		$(".view_detail").click( function(){
			var url = "${contextPath}/___/posting/epilogue/detail/" + $(this).data('postingid');
			$.blockUI({
				message: 
					$('.detail_infos').load( url, function(){
						
					}),
				css: { width: '740px', height: '500px', border:'none', '-webkit-border-radius': '5px', '-moz-border-radius': '5px', top:'50px', left:'50px'},
				overayCSS:{backgroundColor: '#000000'},
				onOverlayClick: $.unblockUI
			});
			
		}).css('cursor','pointer');
		
	});
	
</script>
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<td class="path_info" align="left">순위 > 전국 TOP 100 > ${hospitalModel.name} 성형외과</td>
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
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_front}) no-repeat" align="center"><span class="front_tab">수술후기</span></td>
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_behind}) no-repeat" align="center">
						<a href="${contextPath}/___/p/hreview/${hospitalModel.id}"><span class="rear_tab">병원리뷰</span></a>
					</td>
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
							<br/><a href="https://twitter.com/share" class="twitter-share-button" data-text="GIVUS TOP 100 [${hospitalModel.name} 성형외과] 병원후기" data-via="givus2014">Tweet</a>
								<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
							
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<jsp:include page="/WEB-INF/jsp/givus/givus_facebook.jsp"/>
							<div class="fb-like" data-href="http://www.givus.co.kr/___/p/hepilogue/${hospitalModel.id}" data-width="600" data-layout="standard" data-action="like" data-show-faces="true" data-share="true"></div>
						</td>
					</tr>
				</table>
				<table style="margin-top:10px;">
					<tr>
						<td>
							<ul class="postingCategory-list">
								<c:forEach var="postingCategory" items="${postingCategoryModels}">
									<li><a href="${contextPath}/___/p/hepilogue/${hospitalModel.id}/${postingCategory.id}">${postingCategory.name}[${postingCategory.postingCount}]</a></li>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</table>
				<!--///////// EDIT POSTING START //////////-->
				<script type="text/javascript">
					$(function(){
						$(".write_posting").click( function(){ //hospitalid
							
							var url = "${contextPath}/___/posting/epilogue/write?fid=PS&action=create&bid=25&hid=${hospitalModel.id}&xpath=${xpath}";
							$("#edit_epilogue").load( url, function(){
								
							}).toggle(); 
							
						}).css('cursor','pointer');
						
					});
				</script>
				<img src="${imageHandler.g_hospital_bt_epilogue_write}" alt="병원후기쓰기" class="write_posting" >
				<div id="edit_epilogue" style="display:none;"></div>
				
				
				<!--///////// EDIT POSTING END //////////-->
				<!--///////// VIEW POSTING START //////////-->
				
				<div class="detail_infos" style="display:none;"></div>
				<!--///////// VIEW POSTING END //////////-->
				<table style="margin-top:0px;">
					<c:forEach var="data" items="${dispatcher.datas}">
					<tr>
						<td>
							<div class="posting">
								<div class="num">${data.num}</div>
								<div class="photo">
									<c:choose>
										<c:when test="${data.files[0] != null}">
											<img src="${contextPath}/___/file/thumb/${data.files[0].id}/130">
										</c:when>
										<c:otherwise>
											<img src="${imageHandler.g_ranking_no_image}" width="130" >
										</c:otherwise>
									</c:choose>
								</div>
								<div class="infos">
									<div class="createDate">${data.renderedData.createDate}</div>
									<div class="subject">${data.renderedData.subject}</div>
									<div class="contents">${data.renderedData.contents}</div>
									<div style="float:left;">
										<img src="${imageHandler.g_hospital_view}"> <span>${data.viewCount}</span>
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
												<img src="${contextPath}/___/file/thumb/${hospitalModel.thumbFileId}/105">
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