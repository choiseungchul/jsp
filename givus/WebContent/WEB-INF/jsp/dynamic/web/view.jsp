<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>

<div class="property-view">
	<!-- title -->
	<div class="property-title-div">
		<c:if test="${dispatcher.function.title != null}">
			<span class="table-title">${dispatcher.function.title}</span> 
		</c:if>
	</div>
	
	<table class="property-list">
		<c:forEach var="head" items="${dispatcher.headers}">
		<tr>
			<td class="property-title-td"><span class="property-title">${head.title}</span></td>
			<td class="property-value-td" style="height:${head.width}">
				<span id="${head.name}_value" class="property-value ${head.className}">
				<c:choose>
					<c:when test="${head.name == 'description' }">
						${fn:replace(dispatcher.data.description, newLineChar, "<br/>")}
					</c:when>
					<c:otherwise>
						<c:if test="${dispatcher.data.renderedData[head.name] != null}">
							${dispatcher.data.renderedData[head.name]}
						</c:if>
						<c:if test="${dispatcher.data.renderedData[head.name] == null}">
							${dispatcher.data[head.name]}
						</c:if>
					</c:otherwise>
				</c:choose>
				</span>
			</td>
		</tr>
		</c:forEach>
	</table>
	
	<div class="property-buttons">
		<c:forEach var="button" items="${dispatcher.buttons}">
			<a class="button" href="${button.link}" target="${button.target}">${button.title}</a>
		</c:forEach>
	</div>
</div>