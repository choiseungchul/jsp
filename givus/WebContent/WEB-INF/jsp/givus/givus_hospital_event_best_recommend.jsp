<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.best-recommend-item{
	width:148px;
	float:left;
	margin-right:9px;
}
.best-recommend-item .recommendCount{
	height:18px;
}
.best-recommend-item .band{
	position:absolute;
	width:58px;
	height:58px;
	background:url(${imageHandler.g_hospitalevent_best_recommend_band}) no-repeat;
	text-align: left;
}
.band-text{
	font-weight: bold;
	font-size: 24px;
	color: #fff;
	margin-left:10px;
}
.best-recommend-item .photo{
	height:95px;
}
.best-recommend-item .event{
	font-weight: bold;
	color: #F00;
	margin-bottom:2px;
}
.best-recommend-item .hospitalName{
	font-weight: bold;
	font-size: 14px;
	font-family: "나눔고딕 ExtraBold";
	color: #0059A4;
	margin-bottom:2px;
}
.best-recommend-item .hospitalAddress{
	text-overflow: ellipsis; /* for browsers that supports it */  
	overflow: hidden;
	white-space:nowrap;
	margin-bottom:2px;
}
.event-info{
	padding:5px;
}
</style>
<div class="best-recommend-div">
	<c:forEach var="data" items="${dispatcher.datas}">
	<c:set var="hospital" value="${data.hospitalModel}"/>
	<div class="best-recommend-item">
		<div class="photo">
			<div class="band"><span class="band-text">${data.rnum}</span></div>
			<c:choose>
				<c:when test="${data.fileId != null}">
					<img src="${contextPath}/___/file/get/${data.fileId}" width="147" height="95">
				</c:when>
				<c:when test="${hospital.thumbFileId > 0}">
					<img src="${contextPath}/___/file/get/${hospital.thumbFileId}" width="147" height="95">
				</c:when>
				<c:otherwise>
					<img src="${imageHandler.g_ranking_no_image}" width="147" height="95">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="recommendCount"><img src="${imageHandler.g_hospitalevent_recommend}"> ${data.recommendCount}</div>
		<div class="event-info">
			<div class="hospitalName">${hospital.name}</div>
			<div class="hospitalAddress">${hospital.address}</div>
			<div class="hospitalTel">${hospital.tel}</div>
			<div class="event">[${data.name}] ${data.renderedData.eventPrice}</div>
			<div class="period">
				<c:choose>
					<c:when test="${data.renderedData.progress == 'I'}">
						<img src="${imageHandler.g_hospitalevent_event_ing}">
					</c:when>
					<c:when test="${data.renderedData.progress == 'E'}">
						<img src="${imageHandler.g_hospitalevent_event_end}">
					</c:when>
				</c:choose>
				${data.renderedData.startDate} ~ ${data.renderedData.endDate}
			</div>
		</div>
	</div>
	</c:forEach>
</div>