<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="refreshUrl" value="${contextPath}/portal.do?fid=${func.id}"/>
<c:set var="portletSize" value="${fn:length(portletinfos)}"/>

<!-- css -->
<link type="text/css" href="${contextPath}/style/table.css" rel="stylesheet"/>
<link type="text/css" href="${contextPath}/style/portal.css" rel="stylesheet"/>
<link type="text/css" href="${contextPath}/style/calendar.css" rel="stylesheet"/>

<script>
$(function(){
	$('div.portlet-list-hidden').hide();
});
</script>

<!-- portal page title -->
<!-- 
<div class="portal-title-div">
	<c:if test="${func.title != null}">
		<a href="${refreshUrl}"><span class="portal-title">${func.title}</span></a> 
	</c:if>
</div>
-->
<%--
<!-- button -->
<div class="calendar-button-div">
	<span class="button">
		<a href="${calendar.preMonthUrl}"><span class="calendar-button-text">이전달</span></a>
	</span>
	<span class="button">
		<a href="${calendar.nextMonthUrl}"><span class="calendar-button-text">다음달</span></a>
	</span>
</div>
<div class="calendar-dateinfo">
	<span class="calendar-year">${calendar.yearNum}</span>
	<span class="calendar-month">${calendar.monthNum}</span>
</div>
 --%>
 
<!-- portlets -->

<div class="portlets">

<c:forEach var="portletInfo" items="${portletinfos}" varStatus="portletInfoLoop">
	<c:set var="portlet" value="${portletInfo.portlet}"/>
	<c:set var="dispatcher" value="${portletInfo.dispatcher}"/>
	<c:set var="alignCss" value="portlet-left"/>
	<c:if test="${portletInfoLoop.count % 2 == 0}">
		<c:set var="alignCss" value="portlet-right"/>
	</c:if>
	
	<!-- portlet -->
	<div class="portlet portlet-${portlet.id} ${alignCss}" style="width:${portlet.width}px;">
	
	<!-- portlet header -->
	<div class="portlet-header" style="width:${portlet.width}px">
		<div class="portlet-title"><span class="portal-title">${portlet.title}</span></div>
		<c:if test="${portlet.icons != null}">
		<div class="portlet-icons">
			<c:forEach var="icon" items="${protlet.icons}">
			<div class="portlet-icon"><a href="${icon.link}"><img src="${imageHandler[icon.image]}"/></a></div>
			</c:forEach>
		</div>
		</c:if>
		<c:if test="${portlet.url != null && portlet.target != null}">
		<div class="portlet-buttons">
			<div class="portlet-button-more"><a href="${contextPath}${portlet.url}" target="${portlet.target}">더보기</a></div>
		</div>
		</c:if>
	</div>
	
	<!-- portlet body -->
	<div class="portlet-body" style="width:${portlet.width}px">
		<table class="portlet-list portlet-list-${portlet.id}" border="0" width="100%">
			<!-- list header -->
			<tr class="portlet-header-tr">
				<c:forEach var="head" items="${dispatcher.headers}" varStatus="datasLoop">
					<th class="portlet-header-td" width="${head.width}"><span class="portlet-head-title">${head.title}</span></th>
				</c:forEach>
			</tr>
			
			<!-- list body -->
			<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
				<c:if test="${portlet.row == datasLoop}"><div class="portlet-list-hidden"></c:if>
				<tr class="portlet-data-tr-${portlet.name} portlet-data-tr">
					<c:forEach var="head" items="${dispatcher.headers}">
						<td class="portlet-data-td-${portlet.name} portlet-data-td" align="${head.align}">
							<span class="portlet-head-value-${portlet.name} portlet-head-value">
								<c:if test="${data.renderedData[head.name] != null}">
								${data.renderedData[head.name]}
								</c:if>
								<c:if test="${data.renderedData[head.name] == null}">
								${data[head.name]}
								</c:if>
							</span>
						</td>
					</c:forEach>
				</tr>
				<c:if test="${fn:length(dispatcher.datas) == datasLoop}"></div></c:if>
			</c:forEach>
			<%-- sum --%>
			<c:if test="${dispatcher.sumData != null}">
			<c:set var="data" value="${dispatcher.sumData}"/>
			<tr class="table-data-tr">
				<c:forEach var="head" items="${dispatcher.headers}">
					<td class="table-data-td" align="${head.align}">
						<span class="table-head-value" id="${data.id}_${head.name}_value">
							<c:choose>
								<c:when test="${data.renderedData[head.name] != null}">
								${data.renderedData[head.name]}
								</c:when>
								<c:otherwise>
								<c:catch>${data[head.name]}</c:catch>
								</c:otherwise>
							</c:choose>
						</span>
					</td>
				</c:forEach>
			</tr>
			</c:if>
			<c:if test="${empty dispatcher.datas}">
				<c:set var="headerSize" value="${fn:length(dispatcher.headers)}"/>
				<tr>
					<td align="center" colspan="${headerSize}" height="100px"><div class="portlet-nodata-${portlet.name} portlet-nodata">${msgHandler["table.nodata"]}</div></td>
				</tr>
			</c:if>
		</table>
	</div>
	</div><!-- portlet -->
</c:forEach>
</div><!-- portlets -->
<div class="portlets-blank"></div>