<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- variable -->
<c:set var="refreshUrl" value="${contextPath}/${dispatcher.function.url}?fid=${dispatcher.function.id}"/>
<c:set var="headerSize" value="${fn:length(dispatcher.headers)}"/>

<link type="text/css" href="${contextPath}/style/table.css" rel="stylesheet"/>

<div class="table-div">
	<!-- list -->
	<table class="table-list" border="0">
	
		<tr class="table-header-tr">
			<th colspan="${colspansize}">${dispatcher.function.title}</th>
		</tr>
		
		<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
			<tr class="table-data-tr">
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
</div>