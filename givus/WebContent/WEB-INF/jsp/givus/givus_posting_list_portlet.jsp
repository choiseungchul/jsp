<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<style>
.posting-portlet-list{
	list-style:none;
	border-bottom: 1px solid #ccc;
	border-top: 2px solid #ccc;
}
.posting-portlet-list .posting-item{
	width:300px;
	padding-top:10px;
	padding-bottom:10px;
	border-bottom: 1px dashed #ccc;
}
.posting-portlet-list .posting-photo{
	float:left;
	width:100px;
}
.posting-portlet-list .subject{
	font-weight:bold;
}
.posting-portlet-list {
	font-size:12px;
}
.posting-portlet-list .createDate .contents{
	font-size:11px;
	text-align:left;
}
.posting-portlet-list .count{
	text-align:right;
}
li{
	line-height:170%;
}
.table-nav-div {
	text-align: center;
	margin-top: 20px;
	width: 300px;
}

.table-nav, .table-nav-selected{
	margin-left: 2px;
	padding: 1px;
	border: 1px solid white;
	width: 12px;

}
.table-nav-prev, .table-nav-next{
	margin-left: 1px;
	margin-right: 1px;
}
.table-nav-selected {
	border: 1px solid #cbcbcb;
	font-weight: bold;
	font-size:10px;
}
.contents, .createDate{
	color: #777777;
}
.nav {
	font-size:9px;
}
</style>
<script>
$(function(){
	$('.nav').click( function(){
		var url = $(this).attr('url');
		$('.posting-portlet').load( url, function( responseText){
			console.log( responseText);
		});
	}).css('cursor', 'pointer');
});
</script>
<table class="posting-portlet-list">
	<c:forEach var="data" items="${dispatcher.datas}" varStatus="count">
	<tr><td class="posting-item">
	<c:set var="fileSize" value="${fn:length(data.files)}"/>
	<c:if test="${ data.files != null && fileSize > 0}">
		<div class="posting-photo"><img src="${contextPath}/___/file/thumb/${data.files[0].id}/90"/></div>
	</c:if>
		<div class="posting-info">
			<div class="subject">${data.renderedData.subject}</div>
			<c:if test="${data.boardId==19}">
			<div class="contents">
				<span>${data.renderedData.contents}</span>
			</div>
			</c:if>
			<div class="createDate">${data.renderedData.createDate}</div>
			<c:if test="${data.boardId!=19}">
			<div class="count">
				<img src="${imageHandler.g_hospital_view}"> <span>${data.viewCount}</span>
				<img src="${imageHandler.g_hospital_good}"> <span>${data.recommendCount}</span>
			</div>
			</c:if>
		</div>
	</td></tr>
	</c:forEach>
</table>
<%-- navigation --%>


<c:set var="navSize" value="${fn:length(dispatcher.navigations)}"/>
<c:if test="${not empty dispatcher.navigations && navSize > 1}">
<div class="table-nav-div">
	<c:forEach var="nav" items="${dispatcher.navigations}" varStatus="count">

		<c:if test="${count.count > 1}">|</c:if>
		<c:if test="${nav.selected}"><span class="table-nav-selected">${nav.name}</span></c:if>
		<c:if test="${nav.selected == false}"><span class="nav" url="${nav.url}">${nav.name}</span></c:if>
	</c:forEach>
</div>
</c:if>