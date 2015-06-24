<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/jquery.blockUI.js"></script>
<script src="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.min.js"></script>
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.theme.css">

<style>
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
}
.carousel-wrapper{
	width:980px;
	text-align:center;
	margin-bottom:20px;
	float:left;
}
.carousel{
	width:980px;
	float:left;
}
.carousel .item img{
	display:block;
}
.posting-contents-title{
	height:25px;
	border-bottom: 2px solid #ccc;
	margin-bottom: 10px;
	width:660px;
}
.posting-portlet-title{
	width:300px;
	color: #214579;
	font-size: 14px;
	font-weight: bold;
	font-family: "나눔고딕";
	vertical-align: bottom;
	padding-bottom: 5px;
}
.button-more{
	width:660px;
	text-align:center;
}
</style>
<script>
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
	
	var url_portlet = '${contextPath}/___/posting/portlet/17';	
	$('.posting-portlet').load( url_portlet, function( responseText){
	});
	var url_contents = '${contextPath}/___/posting/contents/17';	
	$('.posting-contents').load( url_contents, function( responseText){
	});
	
	$('.button-more').click( function(){
		var nextPageNo = $(this).attr('nextPageNo');
		var url_more = '${contextPath}/___/posting/contents/17?${funcHandler.funcPostingListContents.id}_pageno=' + nextPageNo;
		
		$('.button-more').block({
			message: ' '
		});
		$(".posting-contents").append($("<div>").load(url_more, function(){
			$('.button-more').unblock();
		}));
		
		$(this).attr('nextPageNo', parseInt(nextPageNo) + 1);
	}).css('cursor','pointer');
});

function loadInterviewDetail( id){
	var url = '${contextPath}/___/posting/detail/' + id;
	$('.posting-detail').load( url, function( responseText){
	});
}
</script>
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;margin-bottom:3px;">
		<tr>
			<td class="path_info" align="left"> 우리병원 PR </td>
		</tr>
	</table>
	<table width="980" style="margin:auto;maring-top:20px;">
		<tr>
			<td>
				<div class="carousel-wrapper">
					<div class="carousel" >
						<c:forEach var="file" items="${files}">
						<div class="item"><img src="/___/file/get/${file.id}" width="980"></div>
						</c:forEach>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;maring-top:20px;">
		<tr>
			<td class="posting-detail" width="680" valign="top" align="left">
				<div class="posting-contents-title">
					<img src="${imageHandler.g_hospitalpr_title_interview}">
				</div>
				<div class="posting-contents"></div>
				<div class="button-more" nextPageNo="2">
					<img src="${imageHandler.g_hospitalpr_button_more}">
				</div>
			</td>
			<td width="300" valign="top" align="left">
				
				<div class="posting-portlet-title"><img src="${imageHandler.g_right_subtitle_icon}" alt="" width="8" height="8" />LIST</div>
				<div class="posting-portlet"></div>
			</td>
		</tr>
	</table>
</td></tr></table>