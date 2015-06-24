<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="size" value="${fn:length(results)}"/>
{
	query: "${query}",
	suggestions : [
		<c:forEach var="result" items="${results}" varStatus="loop">
			"<c:forEach var="field" items="${displayfields}">${result[field]} </c:forEach>"
			<c:if test="${loop.count < size}">,</c:if>
		</c:forEach>
	],
	data : [
		<c:forEach var="result" items="${results}" varStatus="loop">
		"${result[codefield]}"<c:if test="${loop.count < size}">,</c:if>
		</c:forEach>
	]
}