<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<ul data-role="listview" data-theme="d" data-divider-theme="d">
	<li>
		<c:forEach var="head" items="${dispatcher.headers}">
		<li data-role="list-divider">${head.title}</li>
		<li><p><string>
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
		<string></p></li>
		</c:forEach>
	<li>
</ul>