<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/jquery.blockUI.js"></script>
<script src="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.min.js"></script>
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.theme.css">
<script src="${contextPath}/script/jqueryui/plugin/jquery.simplemodal-1.4.4-patched.js"></script>

<style type="text/css">
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
}
.body_style{
	color: #000;
	font-size: 12px;
	vertical-align: top;
	width: 980px;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
}
.portlet_title, .portlet_title a{
	color:#444444;
	font-size: 15px;
	font-weight: bold;
	vertical-align: middle;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
}
.ranking_title, .ranking_title a{
	text-align: left;
	color:#005EA6;
	font-size: 13px;
	font-weight: bold;
	margin-left: 6px;
	vertical-align: middle;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
}
.plus_icon{
	color:#ABABAB;
	margin-left: 5px;
	margin-right:5px;
}
.portlet_subject, .portlet_subject2{
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
	text-align: left;
	float:left;
	color: #444444;
} 
.portlet_subject2{
	margin-left: 3px;
} 
.portlet_contents{
	color: #a2a2a2;
}
.portlet_createDate{
	white-space:nowrap;
	width:65px;
	float:left;
	overflow:hidden;
	color: #828083;
}
.carousel-wrapper{
	width:243px;
	text-align:left;
}
.carousel{
	width:243px;
	float:left;
}
.carousel .item img{
	display:block;
}

.carousel2-wrapper2{
	width:420px;
	text-align:left;
	float:left;
}
.carousel2{
	width:420px;
	float:left;
}
.carousel2 .item2 img{
	display:block;
}
/* .no_bg_gray{
	background: url(${imageHandler.g_main_no_bg_gray}) no-repeat;
	text-align: center;
	color: #FFFFFF;
	margin-left: 6px;
}
.no_bg_blue{
	background: url(${imageHandler.g_main_no_bg_blue}) no-repeat;
	text-align: center;
	color: #FFFFFF;
	margin-left: 6px;
} */
.no_bg_gray, .no_bg_blue{
	text-align: center;
	height:14px;
	width:15px;
	float:left;
	margin-top:0px;
	margin-right:5x;
	padding-top:2px;
}
.no_bg_gray{
	background: url(${imageHandler.g_main_no_bg_gray}) no-repeat ;
}
.no_bg_blue{
	background: url(${imageHandler.g_main_no_bg_blue}) no-repeat ;
}
.no_font{
	color: #FFFFFF;
	font-size:10px;
}
.event_detail{
	display:none;
	height:510px; width:880px;
}
/* Overlay */
#simplemodal-overlay {background-color:#000;}

/* Container */
#simplemodal-container {height:520px; width:890px;background-color:#fff;border:1px solid #ccc; padding:12px;}
#simplemodal-container a.modalCloseImg {background:url(${imageHandler.g_popup_icon_close}) no-repeat; width:25px; height:29px; display:inline; z-index:3200; position:absolute; top:0px; right:0px; cursor:pointer;}

/** 병원이벤트 관련 시작 **/
.best_font{
	font-weight: bold;
}
.bestmenus {
	list-style:none;
	padding:0px;
	margin:0px;	
}
.bestmenus > li{
	list-style:none;
	padding:0px;
	margin:0px;	
	float: left; 
	display: block;
	vertical-align: middle;
	text-align: center;
	padding-top: 5px;
}
.bestmenus > li a:visited, .bestmenus > li a:link, .bestmenus > li a:hover{
	text-decoration:none;
}
.bestmenus > li a:hover{
	color: #005ea6;
}
.tab_selected {
	background: #ffffff;
	color: #005ea6;
	font-family: "나눔고딕 ExtraBold";
	font-size: 13px;
	width:119px;
	height:23px;
	float: left;
	vertical-align: middle;
	font-weight: bold;
	border: 1px solid #005ea6;
	cursor: pointer;
}
.tab_selected a{
	color: #005ea6;
	font-family: "나눔고딕 ExtraBold";
	height:23px;
	vertical-align: middle;
}
.tab_not_selected {
	background: #f4f4f4;
	color: #535353;
	font-size: 13px;
	font-family: "나눔고딕 ExtraBold";
	width:119px;
	height:23px;
	float: left;
	vertical-align: middle;
	font-weight: bold;
	border: 1px solid #cccccc;
	cursor: pointer;
}
.tab_not_selected a{
	color: #535353;
	font-family: "나눔고딕 ExtraBold";
	height:23px;
	vertical-align: middle;
}

#bestTab{
	list-style:none;
}
#bestview_list > li, #bestevent_list > li{
	/* margin-bottom: 10px; */
	display: block;
	float: left; 
	display: inline;
	padding: 7px 0px 7px 0px;
	border-bottom: 1px solid #e1e1e1;
}
/** 병원이벤트 끝 **/
</style>

<SCRIPT type="text/javascript">
$(function(){
	$(".carousel").owlCarousel({
		// navigation : true, // Show next and prev buttons
		slideSpeed : 300,
		paginationSpeed : 400,
		singleItem:true,
		autoScaleUp:false
		
		// "singleItem:true" is a shortcut for:
		// items : 1, 
		// itemsDesktop : false,
		// itemsDesktopSmall : false,
		// itemsTablet: false,
		// itemsMobile : false
	});
	$(".carousel2").owlCarousel({
		// navigation : true, // Show next and prev buttons
		slideSpeed : 300,
		paginationSpeed : 400,
		singleItem:true,
		autoScaleUp:false
		
		// "singleItem:true" is a shortcut for:
		// items : 1, 
		// itemsDesktop : false,
		// itemsDesktopSmall : false,
		// itemsTablet: false,
		// itemsMobile : false
	});
});
$(function(){
	$('.view_detail').click(function(){
		$('.event_detail').modal();
		var url = "${contextPath}/___/hospitalevent/" + $(this).data('hospitalid');
		$('.event_detail').load( url, function(){
			
		});
	}).css('cursor', 'pointer');
	
});

	/*
	* @desc : best list tab menu
	*/
	function displayTopTabMenu(menuId1, menuId2) {
		$("#"+menuId1).removeClass("tab_not_selected").addClass( "tab_selected");
		$("#"+menuId2).removeClass("tab_selected").addClass( "tab_not_selected");
	}
	
	function hideTopTabMenu(menuId1, menuId2){

		if ( $("#"+menuId1).attr('clicked') != 'true'){
			$("#"+menuId1).removeClass("tab_selected").addClass('tab_not_selected');
			$("#"+menuId2).removeClass("tab_not_selected").addClass( "tab_selected");
		}
		if ( $("#"+menuId2).attr('clicked') != 'true'){
			$("#"+menuId2).removeClass("tab_selected").addClass('tab_not_selected');
			$("#"+menuId1).removeClass("tab_not_selected").addClass( "tab_selected");
		}
	}
	
	// 각 메뉴별 click 이벤트 설정
	$(function(){
		
		$("#topmenuTab1").click( function(){
			$("#topmenuTab1").removeClass("tab_not_selected").addClass( "tab_selected");
			$("#topmenuTab2").removeClass("tab_selected").addClass( "tab_not_selected");
			$("#bestevent_list").hide();
			$("#bestview_list").show();
		}).click();
		
		$("#topmenuTab2").click( function(){
			$("#topmenuTab2").removeClass("tab_not_selected").addClass( "tab_selected");
			$("#topmenuTab1").removeClass("tab_selected").addClass( "tab_not_selected");
			$("#bestview_list").hide();
			$("#bestevent_list").show();
		});	
	});
</SCRIPT>

<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<td class="path_info" align="left">
				HOME
			</td>
		</tr>
	</table>

	<table width="980" border="0" cellspacing="0" cellpadding="0" class="body_style">
		<tr>
			<td width="420" valign="top" align="left"><%-- //////////////// ADVERTISEMENT //////////////// --%>
				<table>
					<tr>
						<td>
							<div class="carousel2-wrapper2">
								<div class="carousel2" >
									<%-- <c:forEach var="hospitalprFile" items="${hospitalprFiles}">
									<div class="item"><img src="/___/file/get/${hospitalprFile.id}" width="243"></div>
									</c:forEach> --%>
									<div class="item2"><img src="${contextPath}/images/givus/main/ads/bk.gif" alt="병원광고" width="420px"></div>
									<div class="item2"><img src="${contextPath}/images/givus/main/ads/bk.gif" alt="병원광고" width="420px"></div>
									<div class="item2"><img src="${contextPath}/images/givus/main/ads/bk.gif" alt="병원광고" width="420px"></div>
								</div>
							</div>
						</td>
					</tr>
					<tr><%-- //////////////// LINK TO RANKING //////////////// --%>
						<td height="49" class="portlet_title">KOREA BEST 성형외과</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="35%" rowspan="2"><img src="${imageHandler.g_main_top100}" alt="전국 TOP 100 image" width="149" height="100" /></td>
									<td colspan="2" valign="top"><div class="ranking_title"><a href="${contextPath}/___/p/ranking/A?fid=HE">전국 TOP 100&nbsp;<img src="${imageHandler.g_hospital_icon_new}" alt="new" title="새로운 병원이 등록되었습니다"/><img src="${imageHandler.g_main_more}" alt="more" title="전국 TOP 100 더보기" align="right" /> </a></div></td>
								</tr>
								<tr>
									<td width="3%" height="43" valign="top">&nbsp;</td>
									<td width="62%" height="75" valign="top"><span class="board_">국내 전국 TOP 100 성형외과들의 위치, 전문의 수, 마취과 여부, 서비스 퀄리티, 전문의 평가 등 이해하기 위한 정보들을 제공합니다. </span></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td height="40"><img src="${imageHandler.g_main_dot_line_long}" alt="----" width="424" height="1"/></td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="35%" rowspan="2"><img src="${imageHandler.g_main_seoul50}" alt="서울 TOP 50 image" width="149" height="100" /></td>
									<td colspan="2" valign="top"><div class="ranking_title"><a href="${contextPath}/___/p/ranking/B">서울 TOP 50&nbsp;<img src="${imageHandler.g_hospital_icon_new}" alt="new" title="새로운 병원이 등록되었습니다"/><img src="${imageHandler.g_main_more}" alt="more" title="서울 TOP 50 더보기" align="right"/></a></div></td>
								</tr>
								<tr>
									<td width="3%" height="43" valign="center">&nbsp;</td>
									<td width="62%" height="75" valign="top"><span class="board_">국내 서울 TOP 50 성형외과들의 위치, 전문의 수, 마취과 여부, 서비스 퀄리티, 전문의 평가 등 이해하기 위한 정보들을 제공합니다.</span></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td height="40"><img src="${imageHandler.g_main_dot_line_long}" alt="----" width="424" height="1"/></td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="35%" rowspan="2"><img src="${imageHandler.g_main_area10}" alt="광역 TOP 10 image" width="149" height="100" /></td>
									<td colspan="2" valign="top"><div class="ranking_title"><a href="${contextPath}/___/p/ranking/C">광역 TOP 10&nbsp;<img src="${imageHandler.g_hospital_icon_new}" alt="new" title="새로운 병원이 등록되었습니다"/><img src="${imageHandler.g_main_more}" alt="more" title="광역 TOP 10 더보기" align="right"/></a></div></td>
								</tr>
								<tr>
									<td width="3%" height="43" valign="top">&nbsp;</td>
									<td width="62%" height="75" valign="top"><span class="board_">국내 광역 TOP 10 성형외과들의 위치, 전문의 수, 마취과 여부, 서비스 퀄리티, 전문의 평가 등 이해하기 위한 정보들을 제공합니다.</span></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td height="40"><img src="${imageHandler.g_main_dot_line_long}" alt="----" width="424" height="1"/></td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="35%" rowspan="2"><img src="${imageHandler.g_main_part10}" alt="부위 TOP 10 image" width="149" height="98" /></td>
									<td colspan="2" valign="top"><div class="ranking_title"><a href="${contextPath}/___/p/ranking/D">부위 TOP 10&nbsp;<img src="${imageHandler.g_hospital_icon_new}" alt="new" title="새로운 병원이 등록되었습니다"/><img src="${imageHandler.g_main_more}" alt="more" title="부위 TOP 10 더보기" align="right"/></a></div></td>
								</tr>
								<tr>
									<td width="3%" height="43" valign="top" class="board_">&nbsp;</td>
									<td width="62%" height="75" valign="top" class="board_">국내 부위별 TOP 10 성형외과들의 위치, 전문의 수, 마취과 여부, 서비스 퀄리티, 전문의 평가 등 이해하기 위한 정보들을 제공합니다.</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>

			</td>
			<td width="30" valign="top"><%-- //////////////// SPACE //////////////// --%></td>
			<td width="243" valign="top" align="left"><%-- //////////////// SURGERY INFO //////////////// --%>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="49" class="portlet_title" valign="top"><a href="${contextPath}/___/p/surgeryinfo/19/69">성형정보<img src="${imageHandler.g_main_more}" alt="more" title="성형정보 더보기" align="right"/></a></td>
					</tr>
					<tr>
						<td>
							<%-- //////////////// SURGERY INFO DATA //////////////// --%>
								<table border="0" cellspacing="0" cellpadding="0">
								<c:forEach var="surgeryInfoPosting" items="${surgeryInfoPostings}" varStatus="status">
									<c:if test="${status.count==1}">
										<c:if test="${infoFileId>0}">
								<tr>
									<td rowspan=2 width="96" height="110">
										<img src="${contextPath}/___/file/thumb/${infoFileId}/86" alt="내용사진" style="border: 2px solid #e1e1e1;margin-right: 10px;"/>
									</td>
									<td width="65%" height="25">${surgeryInfoPosting.renderedData['subject']}</td>
								</tr>
								<tr>
									<td height="60"  class="portlet_contents">${surgeryInfoPosting.renderedData['contents']}</td>
								</tr>
										</c:if>
								<tr>
									<td colspan="2" height="3" valign="bottom"><img src="${imageHandler.g_main_bold_line}" width="243" height="3" /></td>
								</tr>
										
										<c:if test="${infoFileId==0}">
								<tr>
									<td colspan="2" width="100%" height="31" ><div class="portlet_subject" style="width:243px;"><span class="plus_icon">+</span>${surgeryInfoPosting.renderedData['subject']}</div></td>
								</tr>
										</c:if>
	
									</c:if>
									
									<c:if test="${status.count>1}">
								<tr>
									<td colspan="2" width="100%" height="31" ><div class="portlet_subject" style="width:243px;"><span class="plus_icon">+</span>${surgeryInfoPosting.renderedData['subject']}</div></td>
								</tr>
									</c:if>
									<c:if test="${status.count>1 && status.count<7}">
								<tr>
									<td colspan="2"><img src="${imageHandler.g_main_slim_line}" width="243" height="1" /></td>
								</tr>
									</c:if>
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td height="40"><img src="${imageHandler.g_main_dot_line}" width="243" height="1" /></td>
					</tr>
					
					<tr>
						<td height="49" class="portlet_title" valign="top"><a href="${contextPath}/___/p/surgeryinfo/19/68">성형뉴스<img src="${imageHandler.g_main_more}" alt="more" title="성형정보 더보기" align="right"/></a></td>
					</tr>
					<tr>
						<td><%-- //////////////// SERGERY NEWS DATA //////////////// --%>
							<table border="0" cellspacing="0" cellpadding="0">
								<c:forEach var="surgeryNewsPosting" items="${surgeryNewsPostings}" varStatus="status">
									<c:if test="${status.count==1}">
										<c:if test="${newsFileId>0}">
								<tr>
									<td rowspan=2 width="96" height="110">
										<img src="${contextPath}/___/file/thumb/${newsFileId}/86" alt="내용사진" style="border: 2px solid #e1e1e1;margin-right: 10px;"/>
									</td>
									<td width="65%" height="25">${surgeryNewsPosting.renderedData['subject']}</td>
								</tr>
								<tr>
									<td height="60"  class="portlet_contents">${surgeryNewsPosting.renderedData['contents']}</td>
								</tr>
										</c:if>
								<tr>
									<td colspan="2" height="3" valign="bottom"><img src="${imageHandler.g_main_bold_line}" width="243" height="3" /></td>
								</tr>
										
										<c:if test="${newsFileId==0}">
								<tr>
									<td colspan="2" width="100%" height="31" ><div class="portlet_subject" style="width:243px;"><span class="plus_icon">+</span>${surgeryNewsPosting.renderedData['subject']}</div></td>
								</tr>
										</c:if>
	
									</c:if>
									
									<c:if test="${status.count>1}">
								<tr>
									<td colspan="2" width="100%" height="31" ><div class="portlet_subject" style="width:243px;"><span class="plus_icon">+</span>${surgeryNewsPosting.renderedData['subject']}</div></td>
								</tr>
									</c:if>
									<c:if test="${status.count>1 && status.count<7}">
								<tr>
									<td colspan="2" height="1" ><img src="${imageHandler.g_main_slim_line}" width="243" height="1"/></td>
								</tr>
									</c:if>
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td height="40"><img src="${imageHandler.g_main_dot_line}" width="243" height="1" /></td>
					</tr>
					<tr>
						<td height="49" class="portlet_title" valign="top"><a href="${contextPath}/___/p/board/1">게시판<img src="${imageHandler.g_main_more}" alt="more" title="게시판 더보기" align="right"/></a></td>
					</tr>
					<tr>
						<td><!-- //////////////// GENERAL POSTINGS //////////////// -->
							<table border="0" cellspacing="0" cellpadding="0">
								<c:forEach var="generalPosting" items="${generalPostings}" varStatus="status">
									<c:if test="${status.count==1}">
										<c:if test="${gpostingFileId>0}">
								<tr>
									<td rowspan=2 width="96" height="110">
										<img src="${contextPath}/___/file/thumb/${gpostingFileId}/86" alt="내용사진" style="border: 2px solid #e1e1e1;margin-right: 10px;"/>
									</td>
									<td width="65%" height="25">${generalPosting.renderedData['subject']}</td>
								</tr>
								<tr>
									<td height="60"  class="portlet_contents">${generalPosting.renderedData['contents']}</td>
								</tr>
										</c:if>
								<tr>
									<td colspan="2" height="3" valign="bottom"><img src="${imageHandler.g_main_bold_line}" width="243" height="3" /></td>
								</tr>
										
										<c:if test="${gpostingFileId==0}">
								<tr>
									<td colspan="2" width="100%" height="31" ><div class="portlet_subject" style="width:180px;"><span class="plus_icon">+</span>${generalPosting.renderedData['subject']}</div> <div class="portlet_createDate">${generalPosting.renderedData['createDate']}</div></td>
								</tr>
										</c:if>
	
									</c:if>
									
									<c:if test="${status.count>1}">
								<tr>
									<td colspan="2" width="100%" height="31" ><div class="portlet_subject" style="width:180px;"><span class="plus_icon">+</span>${generalPosting.renderedData['subject']}</div> <div class="portlet_createDate">${generalPosting.renderedData['createDate']}</div></td>
								</tr>
									</c:if>
									<c:if test="${status.count>1 && status.count<7}">
								<tr>
									<td colspan="2"><img src="${imageHandler.g_main_slim_line}" width="243" height="1" /></td>
								</tr>
									</c:if>
								</c:forEach>
							</table>
						</td>
					</tr> 
					
				</table>
			</td>
			<td width="30" valign="top"><%-- //////////////// SPACE //////////////// --%></td>
			<td width="243" valign="top" align="left"><%-- //////////////// HOSPITAL PR //////////////// --%>
				<table border="0" cellspacing="0" cellpadding="0">
					<tr><%-- //////////////// HOSPITAL PR //////////////// --%>
						<td height="49" class="portlet_title" valign="top"><a href="${contextPath}/___/p/hospitalpr">우리병원 PR<img src="${imageHandler.g_main_more}" alt="more" title="우리병원 PR 더보기" align="right"/></a></td>
					</tr>
					
					<tr>
						
						<td>
							<table width="243" style="margin:auto;maring-top:20px;">
								<tr>
									<td>
										<div class="carousel-wrapper">
											<div class="carousel" >
												
												<div class="item"><a href="${contextPath}/___/p/hospitalpr"><img src="${contextPath}/images/givus/main/pr/pr_photo.jpg" alt="우리병원pr" width="243px"></a></div>
												<div class="item"><img src="${contextPath}/images/givus/main/pr/pr_photo.jpg" alt="우리병원pr" width="243px"></div>
												<div class="item"><img src="${contextPath}/images/givus/main/pr/pr_photo.jpg" alt="우리병원pr" width="243px"></div>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td height="40"><img src="${imageHandler.g_main_dot_line}" width="243" height="1" /></td>
					</tr>

	

					<tr>
						<td height="49" class="portlet_title" valign="top" colspan="5"><a href="${contextPath}/___/p/event">병원이벤트<img src="${imageHandler.g_main_more}" alt="more" title="병원이벤트 더보기" align="right"/></a></td>
					</tr>
					<tr>
						<td>
							<%-- //////////////// Best Hits Hospital and Event //////////////// --%>
							<nav id="bestTab">
								<ul id="bestmenus" class="bestmenus">
									
									<li id="topmenuTab1" onmouseover="displayTopTabMenu('topmenuTab1','topmenuTab2')" onmouseout="hideTopTabMenu('topmenuTab1','topmenuTab2')"><span class="best_font">BEST 조회수 병원</span></li>
									<li id="topmenuTab2" onmouseover="displayTopTabMenu('topmenuTab2','topmenuTab1')" onmouseout="hideTopTabMenu('topmenuTab2','topmenuTab1')"><span class="best_font">BEST 추천 이벤트</span></li>
								</ul>
							</nav>
							<nav id="bestList">
								<ul id="bestview_list" style="display:none;">
									<c:forEach var="bestViewHospital" items="${bestViewHospitals}" varStatus="status">
										<li>
											<c:if test="${status.count >3 }"><c:set var="no_bg" value="no_bg_gray"/></c:if>
											<c:if test="${status.count <=3 }"><c:set var="no_bg" value="no_bg_blue"/></c:if>
											<div class="${no_bg}"><span class="no_font">${status.count}</span></div>
											<div class="portlet_subject2" style="width:115px;"> <a href="${contextPath}/___/p/hospital/${bestViewHospital.id}">${bestViewHospital.name} 성형외과</a></div>
											<div class="portlet_subject2" style="width:60px;">전국 ${bestViewHospital.ranking}위</div>
											<div class="portlet_subject2" style="width:40px;"><img src="${imageHandler.g_hospitalevent_view}" alt="조회수" /> ${bestViewHospital.viewCount}</div>
										</li>
									</c:forEach>
									
								</ul>
								<ul id="bestevent_list" style="display:none;">
									<c:forEach var="hospitalEvent" items="${hospitalEvents}" varStatus="status">
										<li>
											<c:if test="${status.count >3 }"><c:set var="no_bg" value="no_bg_gray"/></c:if>
											<c:if test="${status.count <=3 }"><c:set var="no_bg" value="no_bg_blue"/></c:if>
											<div class="view_detail" data-hospitalId="${hospitalEvent.id}">
												<div class="${no_bg}"><span class="no_font">${status.count}</span></div>
												<div class="portlet_subject2" style="width:70px;">${hospitalEvent.name}</div>
												<div class="portlet_subject2" style="width:80px;">${hospitalEvent.renderedData['eventPrice']}</div>
												<c:if test="${hospitalEvent.endStatus==1}"><c:set var="event_status" value="${imageHandler.g_hospitalevent_event_ing}"/></c:if>
												<c:if test="${hospitalEvent.endStatus==0}"><c:set var="event_status" value="${imageHandler.g_hospitalevent_event_end}"/></c:if>
												<div class="portlet_subject2" style="width:30px;"><img src="${event_status}" alt="진행여부" /></div>
												<div class="portlet_subject2" style="width:35px;"><img src="${imageHandler.g_main_recommend}" alt="추천수" /> ${hospitalEvent.recommendCount}</div>
											</div>
										</li>
									</c:forEach>
									
								</ul>
							</nav>
						</td>
					</tr>
					<tr>
						<td height="40"><img src="${imageHandler.g_main_dot_line}" width="243" height="1" /></td>
					</tr>
					
					<tr>
						<td>
							<jsp:include page="/WEB-INF/jsp/givus/givus_facebook.jsp"/>
							<div class="fb-like-box" data-href="https://www.facebook.com/pages/GIVUS/441206982691214" data-width="240" data-height="446" data-colorscheme="light" data-show-faces="true" data-header="true" data-stream="false" data-show-border="true"></div>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
	</table>
	<div class="event_detail"></div>
</td></tr></table>

