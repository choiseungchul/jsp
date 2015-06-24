<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.min.js"></script>
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.theme.css">

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
.hospital-address{
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
	height:30px;
	width:608px;
	border-bottom: 1px solid #CCCCCC;
	border-top: 2px solid #CCCCCC;
}
.postingCategory-list > li{
	padding:5px;
	cursor: pointer;
	float:left;
	margin-left:20px;
}
.posting{
	width:608px;
	float:left;
	border-bottom: 1px dotted #ccc;
	padding-top: 10px;
	padding-bottom: 10px;
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
.operation{
	width:600px;
	height:220px;
}
.operation-header{
	width:600px;
	height:20px;
	border-top: 1px solid #ccc;
	padding-top:3px;
	margin-bottom:10px;
}
.operation-header div{
	background-color:#444;
	float:left;
	color:#fff;
	font-weight:bold;
	height:25px;
	text-align:center;
	padding-top:10px;
	margin-bottom:20px;
}
.operation-header .header-part{
	width:280px;
}
.operation-header .header-name{
	width:180px;
}
.operation-header .header-price{
	width:140px;
}
.operation-left{
	width:300px;
	text-align:center;
	float:left;
}
.operation-select{
	margin-top:5px;
	width:200px;
	text-align:center;
}
.operation-select-title{
	text-align:center;
	width:300px;
}
.operation-right{
	width:300px;
	float:left;
}
.operation-price-list{
	width:300px;
	list-style:none;
	/* display:none; */
}
.operation-price-list > li{
	width:250px;
	height:20px;
	padding:5px;
	padding-left:10px;
	padding-right:10px;
	border-bottom: 1px solid #ccc;
}
.operation-list-separate{
	padding-top:10px;
	padding-bottom:20px;
	border-bottom: 1px dotted #ccc;
}

.operation-name{
	width:125px;
	float:left;
	text-align:left;
}
.operation-price{
	width:125px;
	float:left;
	text-align:right;
}
.carousel-wrapper{
	/* width:460px; */
	width:608px;
	text-align:center;
	margin-bottom:20px;
	float:left;
}
.carousel{
	width:608px;
}
.carousel .item img{
	display:block;
}
.hospital-info{
	color: #4f4f4f;
	font-size: 12px;
	width:600px;
	border-top: 1px solid #ccc;
}
.hospital-info td{
	padding-top:10px;
}
.hospital-detail{
	width:600px;
	float:left;
}
.hospital-info-list{
	list-style:none;
	padding:3px 3px 3px 10px;
	margin:0px;
}
.hospital-info-sublist{
	margin-left:40px;
}
.hospital-introduction{
	background: url(${imageHandler.g_hospital_bg_givus_comment}) no-repeat;
	line-height:170%;
	height: 96px;
	padding: 15px 20px 5px 20px;
	color: #266dad;
}
li{
	line-height:170%;
}

.evaluation-rating{
	width:140px;
	height:100px;
	text-align:left;
	background: url(${imageHandler.g_hospital_rating_blue_star2}) no-repeat;
}
.evaluation-rating div{
	margin-left:80px;
	margin-bottom:5px;
}
.evaluation-avgPoint {
	font-size: 30px;
	color:#cf4e51;
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
	background: url(${imageHandler.g_hospital_rating_average_full}) no-repeat;
}
.evaluation-totalCount {
	font-family: "나눔고딕";
	color:#cf4e51;
}
.evaluation-sex{
	margin-top:10px;
	width:100px;
	margin-left:15px;
}
.evaluation-sex-man-graph{
	width:34px;
	height:88px;
	padding:0px;
	float:left;
	margin-right:10px;
	background: url(${imageHandler.g_hospital_rating_man_full}) no-repeat;
}
.evaluation-sex-woman-graph{
	width:41px;
	height:88px;
	padding:0px;
	float:left;
	margin-right:10px;
	background: url(${imageHandler.g_hospital_rating_woman_full}) no-repeat;
}
.evaluation-sex-man-graph > div{
	width:34px;
	background: url(${imageHandler.g_hospital_rating_man_base}) no-repeat;
}
.evaluation-sex-woman-graph > div{
	width:41px;
	background: url(${imageHandler.g_hospital_rating_woman_base}) no-repeat;
}
.evaluation-generation{
	width:120px;
	margin-top:10px;
	margin-left:15px;
}
.evaluation-generation-graph {
	width:19px;
	height:86px;
	background: url(${imageHandler.g_hospital_rating_age_full}) no-repeat;
	padding:0px;
	float:left;
	margin-right:10px;
}
.evaluation-generation-graph > div{
	width:19px;
	background: url(${imageHandler.g_hospital_rating_age_base}) no-repeat;
}
.review-header{
	width:600px;
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
	width:160px;
}
.review-header .header-average{
	width:130px;
}
.review-header .header-sex{
	width:130px;
}
.review-header .header-age{
	width:180px;
}
.info-title{
	font-weight:bold;
	font-family: "나눔고딕";
	color: #4f4f4f;
	font-size: 14px;
	height: 25px;
}
.hospital-detail1{
	background: url( ${imageHandler.g_hospital_bg_hospitalinfo1}) no-repeat;
	height: 119px;
	line-height: 170%;
	font-size:11px;
	color: #4f4f4f;
}
.hospital-detail2{
	background: url( ${imageHandler.g_hospital_bg_hospitalinfo2}) no-repeat;
	height: 72px;
	line-height: 170%;
	font-size:11px;
	color: #4f4f4f;
}
.hospital-detail3{
	background: url( ${imageHandler.g_hospital_bg_hospitalinfo3}) no-repeat;
	height: 86px;
	line-height: 170%;
	font-size:11px;
	color: #4f4f4f;
}
.hospital-detail5{
	background: url( ${imageHandler.g_hospital_bg_hospitalinfo5}) no-repeat;
	height: 72px;
	line-height: 170%;
	font-size:11px;
	color: #4f4f4f;
}
/* .hospital-detail-title{
	font: bold;
	font-size:12px;
	color: #005ea6;
} */

.hospital-detail-row{
	width:101px;
	height:118px;
	float:left;
}
.hospital-detail-row5{
	width:101px;
	height:82px;
	float:left;
}
.hospital-detail-head{
	color: #005ea6;
	font-size: 12px;
	width:70px;
	/* float:left; */
	margin-left:20px;
	margin-top:8px;
	padding-bottom:3px;
	font-weight:bold;
}
.hospital-detail-value{
	width:101px;
	color: #4f4f4f;
	font-size: 12px;
	text-align:center;
	margin-top:10px;
	height: 25px;
}
.hospital-detail-head2{
	color: #005ea6;
	font-size: 13px;
	width:95%;
	margin-left:20px;
	margin-top:20px;
	padding-top:8px;
	padding-bottom:3px;
	font-weight:bold;
}
.hospital-detail-head5{
	color: #005ea6;
	font-size: 12px;
	width:95%;
	margin-left:15px;
	margin-top:0px;
	padding-top:8px;
	padding-bottom:3px;
	font-weight:bold;
}
.hospital-detail-value2{
	width:95%;
	
	font-size: 12px;
	margin-left:20px;
	margin-top:10px;
	height: 25px;
}
.hospital-info-sublist1{
	list-style: none;

}
.hospital-info-sublist1 li{
	width: 100px;
	float: left;
}
</style>
<script>
$(function(){
	$('.operation-select').change( function(){
		var selectedId = $(this).find('option:selected').val();
		
		$('ul[id^=operation_price]').hide();
		$('#operation_price_'+selectedId).show();
	}).change();
	
	$(".carousel").owlCarousel({
		// navigation : true, // Show next and prev buttons
		slideSpeed : 300,
		paginationSpeed : 400,
		singleItem:true,
		autoScaleUp:false
		
		// "singleItem:true" is a shortcut for:
		// items : 1, 
		// itemsDesktop : false,7/
		// itemsDesktopSmall : false,
		// itemsTablet: false,
		// itemsMobile : false
		
	});
});
</script>

<meta property="og:title" content="GIVUS TOP 100 - ${hospitalModel.name} 성형외과 병원정보"/> 
<meta property="og:type" content="website"/> 
<meta property="og:url" content="http://www.givus.co.kr/___/p/hospital/${hospitalModel.id}"/> 
<meta property="og:image" content="http://www.givus.co.kr/___/file/get/${hospitalModel.thumbFileId}"/> 
<meta property="og:description" content="국내 ${msgHandler[ranking_name]} 성형외과들의 위치, 전문의 수, 마취과 여부, 서비스 퀄리티, 전문의 평가등 이해하기 위한 정보들을 제공합니다. ※ 각 성형외과 홈페이지에 제공하는 정보와 공식적인 통계자료를 기준으로 기재합니다."/> 
<meta property="og:site_name" content="GIVUS TOP 100"/>
												
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<td class="path_info" align="left">
				순위 > <a href="${contextPath}/___/p/ranking/A?fid=HE">전국 TOP 100</a> > ${hospitalModel.name} 성형외과
			</td>
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
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_front}) no-repeat" align="center"><span class="front_tab">병원정보</span></td>
					<td width="145px" style="background:url(${imageHandler.g_ranking_ranking_tab_behind}) no-repeat" align="center">
						<a href="${contextPath}/___/p/hepilogue/${hospitalModel.id}"><span class="rear_tab">수술후기</span></a>
					</td>
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
							<div class="hospital-address">${hospitalModel.address}<br/>대표전화) ${hospitalModel.tel}<br/>팩스) ${hospitalModel.fax}
								<!-- 트윗 start -->
								<br/><a href="https://twitter.com/share" class="twitter-share-button" data-text="GIVUS TOP 100 [${hospitalModel.name} 성형외과] 병원정보" data-via="givus2014">Tweet</a>
								<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
								<!-- 트윗 end -->
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<jsp:include page="/WEB-INF/jsp/givus/givus_facebook.jsp"/>
							<div class="fb-like" data-href="http://www.givus.co.kr/___/p/hospital/${hospitalModel.id}" data-width="600" data-layout="standard" data-action="like" data-show-faces="true" data-share="true"></div>
							
						</td>
					</tr>
				</table>
				<table class="hospital-info" style="margin-top:10px;">
					<tr>
						<td><%-- //////////////// HOSPITAL GALLERY //////////////// --%>
							<c:choose>
							<c:when test="${fn:length(files)==0}"><div class="carousel-wrapper"><div class="carousel" ><img src="${imageHandler.g_ranking_no_image_460}" width="608"></div></div></c:when>
							<c:otherwise>
							<div class="carousel-wrapper">
								<div class="carousel" >
									<c:forEach var="file" items="${files}">
									<div class="item"><img src="/___/file/get/${file.id}" width="608"></div>
									</c:forEach>
								</div>
							</div>
							</c:otherwise>
							</c:choose>
							<c:if test="${userType ==null}"><div class="login_notice" align="center"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-bottom: 5px;margin-right:5px;">로그인을 하면 상세한 병원의 정보를 조회할 수 있습니다.</div></c:if>
						</td>
					</tr>
					<tr>
						<td><%-- //////////////// CATEGORY POINTS //////////////// --%>
							<div style="height:20px;border-top: 1px solid #ccc;"></div>
							<div class="info-title"><img src="${imageHandler.g_right_subtitle_icon}"> ${hospitalModel.name} 성형외과 카테고리별 평점</div>
							<div class="hospital-detail5">
								<div class="hospital-detail-row5">
									<div class="hospital-detail-head5">평균(5점만점)</div>
									<div class="hospital-detail-value"><fmt:formatNumber value="${hospitalModel.totalPoint}" type="pattern" pattern="0.00" /></div>
								</div>
								<div class="hospital-detail-row5">
									<div class="hospital-detail-head5" title="전문성: 성형외과 전공의여부, 과별수술진행,신수술법,업계평판(학술임원,언론기사,봉사활동 등)으로 판단합니다.">전문성(20%)</div>
									<div class="hospital-detail-value"><fmt:formatNumber value="${hospitalModel.expertPoint}" type="pattern" pattern="0.00" /></div>
								</div>
								<div class="hospital-detail-row5">
									<div class="hospital-detail-head5" title="안전성: 마취과유무, 수술건수,최신의료기기 보유,수술클레임(정부공개 및 언론기사 등)으로 판단합니다.">안정성(30%)</div>
									<div class="hospital-detail-value"><fmt:formatNumber value="${hospitalModel.safePoint}" type="pattern" pattern="0.00" /></div>
								</div>
								<div class="hospital-detail-row5">
									<div class="hospital-detail-head5" title="만족성: 홈페이지 전후사진수,클레임,후기만족도,연예인방문여부,수상여부,붓기치료,주차별프로그램관리로 판단합니다.">만족성(30%)</div>
									<div class="hospital-detail-value"><fmt:formatNumber value="${hospitalModel.satisfyPoint}" type="pattern" pattern="0.00" /></div>
								</div>
								<div class="hospital-detail-row5">
									<div class="hospital-detail-head5" title="규모성: 의료진수,병워사이즈,통역유무,픽업서비스,사회공헌여부로 판단합니다.">규모성(10%)</div>
									<div class="hospital-detail-value"><fmt:formatNumber value="${hospitalModel.sizePoint}" type="pattern" pattern="0.00" /></div>
								</div>
								<div class="hospital-detail-row5">
									<div class="hospital-detail-head5" title="편의성: 온라인상담건수, 수술후 고객게시판 여부, 입원실 및 회복실 여부, 시설퀄리티, 가상성형지원 여부로 판단합니다.">편의성(10%)</div>
									<div class="hospital-detail-value"><fmt:formatNumber value="${hospitalModel.convenientPoint}" type="pattern" pattern="0.00" /></div>
								</div>
							</div>
							※ 제목에 마우스를 올리면 각각 항목들에 대한 설명을 볼 수 있습니다.
						</td>
					</tr>
					<tr>
						<td><%-- //////////////// HOSPITAL GALLERY //////////////// --%>
							<div style="height:20px;margin-top:10px;border-top: 1px solid #ccc;"></div>
							<div class="info-title"><img src="${imageHandler.g_right_subtitle_icon}"> ${hospitalModel.name} 성형외과 세부정보</div>
							<div class="hospital-detail1">
								<div class="hospital-detail-row">
									<div class="hospital-detail-head">주요수술1<br>/ 주요수술2</div>
									<div class="hospital-detail-value">${hospitalModel.mostOperation1}</div>
									<div class="hospital-detail-value">${hospitalModel.mostOperation2}</div>
								</div>
								<div class="hospital-detail-row">
									<div class="hospital-detail-head">전문의수<br>/ 마취과수</div>
									<div class="hospital-detail-value">${hospitalModel.specialistCount}명</div>
									<div class="hospital-detail-value">${hospitalModel.anestheticCount}명</div>
								</div>
								<div class="hospital-detail-row">
									<div class="hospital-detail-head">온라인상담<br>/ 전후사진</div>
									<div class="hospital-detail-value">${hospitalModel.counselCount}여건</div>
									<div class="hospital-detail-value">${hospitalModel.reviewPicCount}여건</div>
								</div>
								<div class="hospital-detail-row">
									<div class="hospital-detail-head">외국인유치<br>/ 통역여부</div>
									<div class="hospital-detail-value">${hospitalModel.foreignerReg}</div>
									<div class="hospital-detail-value"><c:if test="${userType !=null}">${hospitalModel.interpreter}</c:if><c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if></div>
								</div>
								<div class="hospital-detail-row">
									<div class="hospital-detail-head">병원크기<br>/ 픽업서비스</div>
									<div class="hospital-detail-value"><c:if test="${userType !=null}">${hospitalModel.scale}</c:if><c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if></div>
									<div class="hospital-detail-value"><c:if test="${userType !=null}">${hospitalModel.pickupService}</c:if><c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if></div>
								</div>
								<div class="hospital-detail-row">
									<div class="hospital-detail-head">입원실<br>/ 회복실</div>
									<div class="hospital-detail-value"><c:if test="${userType !=null}">${hospitalModel.patientRoom}</c:if><c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if></div>
									<div class="hospital-detail-value"><c:if test="${userType !=null}">${hospitalModel.recoveryRoom}</c:if><c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if></div>
								</div>
							</div>
							
							<c:if test="${hospitalModel.specialistCount > 0}">
							<div class="hospital-detail3">
								<div class="hospital-detail-head2">과별수술</div>
								<div class="hospital-detail-value2">
									<c:if test="${userType !=null}">
									<ul class="hospital-info-sublist1">
										<c:if test="${hospitalStatsModel.oralDoctorCount > 0}"><li>구강과 ${hospitalStatsModel.oralDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.dentalDoctorCount > 0}"><li>치과 ${hospitalStatsModel.dentalDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.breastDoctorCount > 0}"><li>가슴 ${hospitalStatsModel.breastDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.orthodonticDoctorCount > 0}"><li>교정 ${hospitalStatsModel.orthodonticDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.otolaryngologyDoctorCount > 0}"><li>이비후과 ${hospitalStatsModel.otolaryngologyDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.surgeryDoctorCount > 0}"><li>외과 ${hospitalStatsModel.surgeryDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.plasticSurgeryDoctorCount > 0}"><li>성형외과 ${hospitalStatsModel.plasticSurgeryDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.anestheticDoctorCount > 0}"><li>마취과 ${hospitalStatsModel.anestheticDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.familyMedicineDoctorCount > 0}"><li>가정의과 ${hospitalStatsModel.familyMedicineDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.generalDoctorCount > 0}"><li>일반 ${hospitalStatsModel.generalDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.clinicalDoctorCount > 0}"><li>임상 ${hospitalStatsModel.clinicalDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.obesityDoctorCount > 0}"><li>비만 ${hospitalStatsModel.obesityDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.dermatologistDoctorCount > 0}"><li>피부과 ${hospitalStatsModel.dermatologistDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.prostheticDoctorCount > 0}"><li>보철 ${hospitalStatsModel.prostheticDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.implantsDoctorCount > 0}"><li>임플란트 ${hospitalStatsModel.implantsDoctorCount}명</li></c:if>
										<c:if test="${hospitalStatsModel.obstetricsDoctorCount > 0}"><li>산부인과 ${hospitalStatsModel.obstetricsDoctorCount}명</li></c:if>
									</ul>
									</c:if>
									<c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if>
								</div>
							</div>
							</c:if>
							
							<div class="hospital-detail3">
								<div class="hospital-detail-head2">가능수술</div>
								<div class="hospital-detail-value2">
									<c:if test="${userType !=null}">${hospitalModel.possibleSurgery}</c:if><c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if>
								</div>
							</div>
							
							<div class="hospital-detail2">
								<div class="hospital-detail-head2">진료시간</div>
								<div class="hospital-detail-value2">
									<c:if test="${userType !=null}">${hospitalModel.hours}</c:if><c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if>
								</div>
							</div>
							
							<div style="height:20px;border-bottom: 1px solid #ccc;"></div>
							
						</td>
					</tr>
				</table>
				<table style="margin-top:25px;">
					<tr>
						<td><%-- //////////////// HOSPITAL INTRODUCTION //////////////// --%>
							<div class="info-title"><img src="${imageHandler.g_right_subtitle_icon}"> ${hospitalModel.name} 성형외과 코멘트</div>
							<div class="hospital-introduction">
							${hospitalModel.introduction }
							</div>
						</td>
					</tr>
				</table>
				
				<table style="margin-top:10px;">
					<tr>
						<td>
							<div class="info-title"><img src="${imageHandler.g_right_subtitle_icon}"> ${hospitalModel.name} 성형외과 가격정보</div>
							<table class="table_noborder" border="0" cellspacing="0" cellpadding="0" width="100%">
							<tr><td>
							<%-- //////////////// OPERATION PRICE //////////////// --%>
							<div class="operation-header">
								<div class="header-part">부위</div>
								<div class="header-name">시술/수술명</div>
								<div class="header-price">가격</div>
							</div>
							</td></tr>
							
								<c:forEach var="operationFirst" items="${operationPriceRootCategory.children}">
								<tr><td class="operation-list-separate">
								<div class="operation-left">
									<c:choose>
										<c:when test="${operationFirst.id == 33}"><img src="${imageHandler.g_hospital_icon_eye}" alt="${operationFirst.name}"></c:when>
										<c:when test="${operationFirst.id == 40}"><img src="${imageHandler.g_hospital_icon_nose}" alt="${operationFirst.name}"></c:when>
										<c:when test="${operationFirst.id == 45}"><img src="${imageHandler.g_hospital_icon_face}" alt="${operationFirst.name}"></c:when>
										<c:when test="${operationFirst.id == 49}"><img src="${imageHandler.g_hospital_icon_body}" alt="${operationFirst.name}"></c:when>
										<c:when test="${operationFirst.id == 55}"><img src="${imageHandler.g_hospital_icon_breast}" alt="${operationFirst.name}"></c:when>
										<c:when test="${operationFirst.id == 58}"><img src="${imageHandler.g_hospital_icon_toxin}" alt="${operationFirst.name}"></c:when>
										<c:when test="${operationFirst.id == 62}"><img src="${imageHandler.g_hospital_icon_filler}" alt="${operationFirst.name}"></c:when>
										<c:otherwise>${operationFirst.name}</c:otherwise>
									</c:choose>
								
								</div>
								<div class="operation-right">
									<ul class="operation-price-list">
										<c:forEach var="operationSecond" items="${operationFirst.children}">
											<li><div class="operation-name">${operationSecond.name}</div><div class="operation-price"><c:if test="${userType !=null}">${operationSecond.renderedData.price}</c:if><c:if test="${userType ==null}"><img src="${imageHandler.g_ranking_lock}" alt="locked" title="로그인을 하시면 상세 정보를 조회할 수 있습니다." style="margin-top: 5px;"></c:if></div></li>
										</c:forEach>
									</ul>
								</div>
							</td></tr>
								</c:forEach>
							<!-- </div> -->
						
							</table>
						</td>
					</tr>
				</table>
				
				
				
			</td>
			<td align="left" valign="top">
				<table><tr><td>
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
				
					</td></tr>
					<tr><td>
						<jsp:include page="/WEB-INF/jsp/givus/givus_ranking_portlet.jsp"/>
					</td></tr>
				</table>
			</td>
		</tr>
	</table>
</td></tr></table>