<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<style>
.posting-contents-list{
	margin-bottom:10px;
}
.posting-contents-list .posting-item{
	width:650px;
	padding:5px;
	border: 1px solid #ccc;
	position:relative;
}
.posting-contents-list .posting-photo{
	width:310px;
	float:left;
}
.posting-contents-list .subject{
	font-weight:bold;
}
.posting-contents-list .contents{
	font-size:12px;
}
.posting-contents-list .createDate{
	font-size:11px;
	text-align:left;
}
.posting-contents-list .count{
	text-align:right;
	heigth:30px;
}
td{
	line-height:170%;
}
.posting-contents-list .posting-photo{
	position:relative;
}
.posting-contents-list .posting-info{
	padding-bottom:30px;
}
.posting-contents-list .posting-photo img{
	display:block;
	float:left;
}
.photo-tag{
	position:absolute; left:0; width:300px;bottom:0;
	height:50px;
	background-color:#000;
	opacity:0.65;
	text-align:center;	
}
.button-detail{
	position:absolute; left:0; width:100%;bottom:0;
	height:28px;
	text-align:right;
}
.photo-tag div{
	color:#fff;
	font-weight:bold;
	padding: 5px;
}
</style>
<script>
$(function(){
	$('.button-detail').click(function(){
		loadInterviewDetail( $(this).attr('postingId'));
	}).css('cursor', 'pointer');
});
</script>
<c:forEach var="data" items="${dispatcher.datas}" varStatus="count">
<table class="posting-contents-list">
	<tr><td class="posting-item">
		<c:set var="fileSize" value="${fn:length(data.files)}"/>
		<c:if test="${ data.files != null && fileSize > 0}">
			<div class="posting-photo">
				<img src="${contextPath}/___/file/get/${data.files[0].id}" width="300">
				<div class="photo-tag"><div>${data.subject}</div></div>
			</div>
		</c:if>
			<div class="posting-info">
				<div class="createDate">${data.renderedData.createDate}</div>
				<div class="contents">${data.renderedData.contents}</div>
				<div class="count">
					<img src="${imageHandler.g_hospital_view}"> <span>${data.viewCount}</span>
					<img src="${imageHandler.g_hospital_good}"> <span>${data.recommendCount}</span>
				</div>
			</div>
			<div class="button-detail" postingId="${data.id}">
				<img src="${imageHandler.g_hospitalpr_button_detail}">
			</div>
	</td></tr>
</table>
</c:forEach>