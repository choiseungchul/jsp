<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul data-role="listview" data-theme="c" data-inset="true">
	<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
		<c:forEach var="head" items="${dispatcher.headers}">
		<li>
			<c:choose>
				<c:when test="${data.renderedData[head.name] != null}">
				${data.renderedData[head.name]} 
				</c:when>
				<c:otherwise>
				${data[head.name]}
				</c:otherwise>
			</c:choose>
		</li>
		</c:forEach>
	</c:forEach>
</ul>