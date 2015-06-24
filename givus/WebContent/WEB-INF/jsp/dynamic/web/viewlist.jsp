<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>

<div class="property-view">
	<!-- title -->
	<div class="property-title-div">
		<c:if test="${dispatcher.function.title != null}">
			<span class="table-title">${dispatcher.function.title}</span> 
		</c:if>
	</div>
	
	<div class="property-buttons">
		<c:forEach var="button" items="${dispatcher.buttons}">
			<span class="button"><a href="${button.link}" target="${button.target}">
				<span>${button.title}</span></a>
			</span>
		</c:forEach>
	</div>
	
	<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
		<table class="property-list">
			<c:forEach var="head" items="${dispatcher.headers}">
			<tr>
				<td class="property-title-td"><span class="property-title">${head.title}</span></td>
				<td class="property-value-td" style="height:${head.width}">
					<span class="property-value ${head.className}">
					<c:if test="${data.renderedData[head.name] != null}">
						${data.renderedData[head.name]}
					</c:if>
					<c:if test="${data.renderedData[head.name] == null}">
						${data[head.name]}
					</c:if>
					</span>
				</td>
			</tr>
			</c:forEach>
		</table>
	</c:forEach>
</div>