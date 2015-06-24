<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.best-view-item{
	width:148px;
	float:left;
	margin-right:9px;
}
.best-view-item .viewCount{
	height:18px;
}
.best-view-item .band{
	position:absolute;
	width:58px;
	height:58px;
	background:url(${imageHandler.g_hospitalevent_best_view_band}) no-repeat;
	text-align: left;
}
.band-text{
	font-weight: bold;
	font-size: 24px;
	color: #fff;
	margin-left:10px;
}
.best-view-item .photo{
	height:95px;
}
.best-view-item .event{
	font-weight: bold;
	color: #F00;
	margin-bottom:2px;
}
.best-view-item .hospitalName{
	font-weight: bold;
	font-size: 14px;
	font-family: "나눔고딕 ExtraBold";
	color: #0059A4;
	margin-bottom:2px;
}
.best-view-item .hospitalAddress{
	text-overflow: ellipsis; /* for browsers that supports it */  
	overflow: hidden;
	white-space:nowrap;
	margin-bottom:2px;
}
.hospital-info{
	padding:5px;
}
.button_detail{
	text-align:center;
	margin-top:5px;
}
</style>
<div class="best-view-div">
	<c:forEach var="data" items="${dispatcher.datas}">
	<div class="best-view-item">
		<div class="photo">
			<div class="band"><span class="band-text">${data.rnum}</span></div>
			<c:choose>
				<c:when test="${data.thumbFileId != null}">
					<img src="${contextPath}/___/file/get/${data.thumbFileId}" width="147" height="95">
				</c:when>
				<c:otherwise>
					<img src="${imageHandler.g_ranking_no_image}" width="147" height="95">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="viewCount"><img src="${imageHandler.g_hospitalevent_view}"> ${data.viewCount} &nbsp;</div>
		<div class="hospital-info">
			<div class="hospitalName">${data.name}</div>
			<div class="hospitalAddress">${data.address}</div>
			<div class="hospitalTel">${data.tel}</div>
			<div class="button_detail">
				<a href="${contextPath}/___/p/hospital/${data.id}"><img src="${imageHandler.g_hospitalevent_button_hospital_detail}"></a>
			</div>
		</div>
	</div>
	</c:forEach>
</div>