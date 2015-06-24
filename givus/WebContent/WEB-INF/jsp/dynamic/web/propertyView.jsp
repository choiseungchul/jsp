<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link type="text/css" href="/mrp/style/property.css" rel="stylesheet"/>

<!-- title -->
<div class="property-title-div">
	<c:if test="${func.title != null}">
		<span class="table-title">${func.title}</span> 
	</c:if>
</div>

<div class="property-buttons">
	<c:forEach var="button" items="${buttons}">
		<span class="button"><a href="${button.link}" target="${button.target}">
			<span>${button.title}</span></a>
		</span>
	</c:forEach>
</div>

<table class="property-list">
	<c:forEach var="head" items="${headers}">
	<tr>
			<td class="property-title-td"><span class="property-title">${head.title}</span></td>
			<td class="property-value-td" style="height:${head.width}">
				<span class="property-value">
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