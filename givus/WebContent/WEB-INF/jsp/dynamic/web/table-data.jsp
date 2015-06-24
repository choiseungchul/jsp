<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!-- variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="headerSize" value="${fn:length(dispatcher.headers)}"/>

<table class="table-list" border="0">
	<tr class="table-header-tr">
		<th class="table-header-checkbox"><input type="checkbox" name="${dispatcher.function.id}_chkall" id="${dispatcher.function.id}_chkall"></th>
		<c:forEach var="head" items="${dispatcher.headers}" varStatus="headersLoop">
			<th class="table-header-td" width="${head.width}">
				<c:choose>
					<c:when test="${dispatcher.sorts[head.name] != null}">
						<a href="${dispatcher.sortUrl}&${dispatcher.function.id}_sort=${head.name}_${dispatcher.sorts[head.name]}">
							<span class="table-head-title">${head.title}</span> <span class="sort_${dispatcher.sorts[head.name]}">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						</a>
					</c:when>
					<c:when test="${dispatcher.sorts[head.name] == null}">
						<span class="table-head-title">${head.title}</span>
					</c:when>
				</c:choose>
			</th>
		</c:forEach>
	</tr>
	<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
		<tr class="table-data-tr">
			<td class="table-data-checkbox"><input type="checkbox" name="${dispatcher.function.id}_chk_${data.id}" id="${dispatcher.function.id}_chk_${data.id}" value="${data.id}"></td>
			<c:forEach var="head" items="${dispatcher.headers}">
				<td class="table-data-td" align="${head.align}">
					<span class="table-head-value" id="${data.id}_${head.name}_value">
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
	</c:forEach>
	
	<c:if test="${empty dispatcher.datas}">
		<c:set var="colspansize" value="${headerSize + 1}"/>
		<tr>
			<td align="center" colspan="${colspansize}" height="100px"><div class="table-nodata"><span>${messageHandler["table.nodata"]}</span></div></td>
		</tr>
	</c:if>
</table>