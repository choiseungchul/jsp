<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<style>
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
}

.table-nav-div {
	text-align: center;
	margin-top: 20px;
}
.table-nav, .table-nav-selected{
	margin-left: 5px;
	padding: 3px;
	border: 1px solid white;
	width: 18px;
}
.table-nav-prev, .table-nav-next{
	margin-left: 5px;
	margin-right: 5px;
}
.table-nav-selected {
	border: 1px solid #cbcbcb;
	font-weight: bold;
}

.gray_r {
	color: #666;
	font-family: "나눔고딕 ExtraBold";
	font-size: 18px;
}
.today_news{
	background: url(${imageHandler.g_surgeryinfo_today_hbar}) no-repeat;
	vertical-align: middle;
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
	width:134px;
	height:39px;
	float: left; 
	display: block;
	vertical-align: middle;
	padding-top: 10px;
	margin-bottom: 5px;
}
.bestmenus > li a:visited, .bestmenus > li a:link, .bestmenus > li a:hover{
	text-decoration:none;
}
.bestmenus > li a:hover{
	color: #19498C;
}

.tab_selected {
	background: url(${imageHandler.g_surgeryinfo_tab_front});
	color: #19498C;
	font-family: "나눔고딕 ExtraBold";
	font-size: 16px;
	width:134px;
	height:49px;
	float: left;
	vertical-align: middle;
	font-weight: bold;
}
.tab_selected a{
	color: #19498C;
	font-family: "나눔고딕 ExtraBold";
	height:49px;
	vertical-align: middle;
}
.tab_not_selected {
	background: url(${imageHandler.g_surgeryinfo_tab_back});
	color: #7d7d7d;
	font-size: 16px;
	font-family: "나눔고딕 ExtraBold";
	width:134px;
	height:49px;
	float: left;
	vertical-align: middle;
	font-weight: bold;
}
.tab_not_selected a{
	color: #7d7d7d;
	font-family: "나눔고딕 ExtraBold";
	height:49px;
	vertical-align: middle;
}

#bestTab{
	list-style:none;
}
#bestnews_list > li, #bestinfo_list > li{
	margin-bottom: 10px;
	display: block;
	float: left; 
	display: inline;
}

.news_title {
	color: #000;
	font-family: "나눔고딕 ExtraBold";
	font-size: 22px;
	text-align: left;
	margin-left: 30px;
}
.news_title_content{
	margin-left: 30px;
	margin-right: 30px;
}
.news, .news_title_content{
	color: #707070;
	font-family: "나눔고딕";
	font-size: 12px;
	text-align: left;
}
.news_subject {
	color: #404040;
	font-family: "나눔고딕 ExtraBold";
	font-size:14px;
	font-weight: bold;
}
.best_no{
	color: #FFFFFF;
	width:15px;
	height:14px;
	font-family: "나눔고딕";
	font-size: 11px;
	background: url(${imageHandler.g_surgeryinfo_no_bg_gray});
	float: left;
	margin-left:10px;
	margin-right:10px;
	margin-top:2px;
}
.best_no_top3{
	color: #FFFFFF;
	width:15px;
	height:14px;
	font-family: "나눔고딕";
	font-size: 11px;
	background: url(${imageHandler.g_surgeryinfo_no_bg_blue});
	float: left;
	margin-left:10px;
	margin-right:10px;
	vertical-align: middle;
}
.best_subject{
	text-align: top;
}
.portlet_subject{
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
	text-align: left;
} 
</style>

<SCRIPT type=text/javascript>
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
			$("#bestinfo_list").hide();
			$("#bestnews_list").show();
		}).click();
		
		$("#topmenuTab2").click( function(){
			$("#topmenuTab2").removeClass("tab_not_selected").addClass( "tab_selected");
			$("#topmenuTab1").removeClass("tab_selected").addClass( "tab_not_selected");
			$("#bestnews_list").hide();
			$("#bestinfo_list").show();
		});	
	});
</SCRIPT>
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<td class="path_info" align="left"><a href="${contextPath}/___/p/surgeryinfo">정보</a></td>
		</tr>
	</table>
	
	<table width="980" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<table background="${imageHandler.g_surgeryinfo_info_bg_vbar}" width="980" border="0" cellspacing="0" cellpadding="0">
					
					<tr>
						<td width="708" height="250" align="center" valign="top">
							<%-- //////////////// Todays News //////////////// --%>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<c:forEach var="todaysPosting" items="${todaysPostings}" varStatus="status">
								<c:if test="${status.count==1}">
								<tr>
									<td height="49" class="today_news" align="center"><span class="gray_r">
									${todaysPosting.renderedData['createDate']}
									</span></td>
								</tr>
								</c:if>
								<tr>
									<td align="left">
										<div class="portlet_subject" style="width:600px;"><span class="news_title"> ${todaysPosting.renderedData['subject']} </span></div>
									</td>
								</tr>
								<tr>
									<td height="59" align="left"><div class="news_title_content"> ${todaysPosting.renderedData['contents']}</div></td>
								</tr>
								<c:if test="${status.count==1}">
								<tr>
									<td align="center" height="20" ><img src="${imageHandler.g_surgeryinfo_line}" alt="" width="608" height="1"/></td>
								</tr>
								</c:if>
								</c:forEach>
							</table>
						</td>
						<td width="2" height="240"><img src="${imageHandler.g_surgeryinfo_today_vbar}" width="2" height="240"/></td>
						<td width="270" align="center">
							<%-- //////////////// Best Surgery Info and News //////////////// --%>
							<nav id="bestTab">
								<ul id="bestmenus" class="bestmenus">
									
									<li id="topmenuTab1" onmouseover="displayTopTabMenu('topmenuTab1','topmenuTab2')" onmouseout="hideTopTabMenu('topmenuTab1','topmenuTab2')"><a href="#">Best 성형기사</a></li>
									<li id="topmenuTab2" onmouseover="displayTopTabMenu('topmenuTab2','topmenuTab1')" onmouseout="hideTopTabMenu('topmenuTab2','topmenuTab1')"><a href="#">Best 성형정보</a></li>
								</ul>
							</nav>
							<nav id="bestList">
								<ol id="bestnews_list" style="display:none;">
									<c:forEach var="bestSurgeryNewsPosting" items="${bestSurgeryNewsPostings}" varStatus="status">
										<li>
											<c:if test="${status.count<=3}"><c:set var="best_no" value="best_no_top3"/></c:if>
											<c:if test="${status.count>3}"><c:set var="best_no" value="best_no"/></c:if>
											<div class="${best_no}">${status.count}</div>
											<div class="portlet_subject" style="width:215px;">${bestSurgeryNewsPosting.renderedData['subject']} </div>
										</li>
									</c:forEach>
								</ol>
								<ol id="bestinfo_list" style="display:none;">
									<c:forEach var="bestSurgeryInfoPosting" items="${bestSurgeryInfoPostings}" varStatus="status">
										<li>
											<c:if test="${status.count<=3}"><c:set var="best_no" value="best_no_top3"/></c:if>
											<c:if test="${status.count>3}"><c:set var="best_no" value="best_no"/></c:if>
											<div class="${best_no}">${status.count}</div>
											<div class="portlet_subject best_subject" style="width:215px;">${bestSurgeryInfoPosting.renderedData['subject']}</div>
										</li>
									</c:forEach>
								</ol>
							</nav>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="3"><img src="${imageHandler.g_surgeryinfo_top_line}" width="980" ></td>
		</tr>
		<tr>
			<td height="35"></td>
		</tr>
		<tr>
			<td>
				<%-- //////////////// BOARD POSTING TABLE //////////////// --%>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="66%" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td align="left" height="3" ><img src="${imageHandler.g_surgeryinfo_line}" alt="" width="608" height="1"/></td>
								</tr>
								
								<c:forEach var="data" items="${dispatcher.datas}">
								<tr>
									<td height="118" align="left">
										<table width="90%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="76%" height="31" align="left"><span class="news">[ ${data.renderedData['categoryId']} ]</span><span class="news_subject"> ${data.renderedData['subject']}</span></td>
											</tr>
											<tr>
												<td height="60" align="left"><span class="news"> ${data.renderedData['contents']} </span></td>
											</tr>
											<tr>
												<td align="left"><span class="news"> ${data.customField1}  ${data.renderedData['createDate']}</span></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td align="left" height="10" ><img src="${imageHandler.g_surgeryinfo_line}" alt="" width="608" height="1"/></td>
								</tr>
								</c:forEach>
								
								<tr>
									<td align="center">
										<%-- navigation --%>
										<c:if test="${not empty dispatcher.navigations}">
											<div class="table-nav-div">
											<c:forEach var="nav" items="${dispatcher.navigations}">
												<c:if test="${nav.selected}"><a href="${nav.url}"><span class="table-nav-selected btn btn-small">${nav.name}</span></a></c:if>
												<c:if test="${nav.selected == false}"><a href="${nav.url}"><span class="${nav.className}">${nav.name}</span></a></c:if>
											</c:forEach>
											</div>
										</c:if>
									</td>
								</tr>
							</table>
						</td>
						<td width="34%" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr><td>
									<a href='http://www.worldvision.or.kr' target='_blank'>
									
									<img src="${imageHandler.g_ads_surgery_ad1}" alt="" width="338"/>
									
									</a>
								</td></tr>
								<tr><td height="30"></td></tr>
								<tr><td>
									<a href='http://www.worldvision.or.kr' target='_blank'>
									
									<img src="${imageHandler.g_ads_surgery_ad2}" alt="" width="338"/>
									</a>
								</td></tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</td></tr></table>