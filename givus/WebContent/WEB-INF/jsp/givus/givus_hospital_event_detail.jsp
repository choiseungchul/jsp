<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.hospital-event{
	table-layout:fixed;
}
.hospital-event th{
	background-color:#444;
	color:#fff;
	font-weight:bold;
	height:40px;
	text-align:center;
}
.hospital-event tr{
	height:30px;
}
.hospital-event td{
	height:30px;
	padding-top:3px;
	padding-bottom:3px;
}
.event-list td{
	border-bottom: 1px solid #ccc;
	padding-top:3px;
	padding-bottom:3px;
}
.col-hospital{
	text-align:center;
	width:240px;
}
.col-price{
	text-align:center;
	width:120px;
}
.col-period{
	text-align:center;
	width:180px;
}
.col-recommendCount{
	text-align:center;
	width:70px;
}
.col-buttonRecommend{
	text-align:center;
	width:80px;
}
.hospital-info{
	width:210px;
	margin:0px auto;
}
.hospital-info .hospitalName{
	text-align:left;
	color: #005EA6;
	font-weight:bold;
	font-size:14px;
	height:25px;
	margin-top:10px;
}
.hospital-info .hospitalAddress{
	text-align:left;
	line-height:150%;
}
.hospital-info .hospitalTel{
	text-align:left;
	line-height:150%;
}
</style>
<script>
$(function(){
	$('.button_recommend').click( function(){
		var hospitalEventId = $(this).data('hospitaleventid');
		var countTD = $(this).closest('tr').find('td.col-recommendCount');
		var url = "${contextPath}/___/hospitalevent/recommend/" + hospitalEventId;
		$.getJSON( url, function( data){
			if( data.result == 'true'){
				var curCount = countTD.text();
				if( curCount){
					countTD.text( parseInt( curCount) + 1);
				}else{
					countTD.text( 1);
				}
			}
			alert( data.message);	
		});
	}).css('cursor', 'pointer');
})
</script>

<table class="hospital-event" width="870px">
	<tr>
		<th class="col-hospital">병원</th>
		<th class="col-event">이벤트</th>
		<th class="col-price">가격</th>
		<th class="col-period">기간</th>
		<th class="col-recommendCount">추천수</th>
		<th class="col-buttonRecommend">추천하기</th>
	</tr>
	<tr>
		<td class="col-hospital">
			<div class="hospital-info">
				<div class="hospitalPhoto">
				<c:choose>
					<c:when test="${hospital.thumbFileId != null}">
						<img src="${contextPath}/___/file/get/${hospital.thumbFileId}" width="200" >
					</c:when>
					<c:otherwise>
						<img src="${imageHandler.g_ranking_no_image}" width="200" >
					</c:otherwise>
				</c:choose>
				
				</div>
				<div class="hospitalName">${hospital.name}</div>
				<div class="hospitalAddress">${hospital.address}</div>
				<div class="hospitalTel">대표전화) ${hospital.tel}</div>
				<div style="margin-top:10px;">
					<a href="${contextPath}/___/p/hospital/${hospital.id}"><img src="${contextPath}/images/givus/button_hospital_detail.gif"></a>
				</div>
			</div>
		</td>
		<td colspan="5" valign="top">
			<table class="event-list" width="100%">
			<c:forEach var="data" items="${dispatcher.datas}">
				<tr>
					<td class="col-event">
						- 
						<c:if test="${data.fileId != null}">
							<img src="${contextPath}/___/file/get/${data.fileId}" width="80">
						</c:if>
						${data.name}
					</td>
					<td class="col-price">${data.renderedData.eventPrice}</td>
					<td class="col-period">
						<c:choose>
							<c:when test="${data.renderedData.progress == 'I'}">
								<img src="${contextPath}/images/givus/hospitalevent/event_ing.gif">
							</c:when>
							<c:when test="${data.renderedData.progress == 'E'}">
								<img src="${contextPath}/images/givus/hospitalevent/event_end.gif">
							</c:when>
						</c:choose>
						${data.renderedData.startDate} ~ ${data.renderedData.endDate}
					</td>
					<td class="col-recommendCount">${data.recommendCount}</td>
					<td class="col-buttonRecommend">
						<div class="button_recommend" data-hospitaleventid="${data.id}">
						<img src="${contextPath}/images/givus/button_recommend.gif">
						</div>
					</td>
				</tr>
			</c:forEach>
			</table>
		</td>
	</tr>
</table>