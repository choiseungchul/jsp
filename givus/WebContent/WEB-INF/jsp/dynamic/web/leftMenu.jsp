<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${dispatcher.menus != null}">
<link type="text/css" href="${contextPath}/style/table.css" rel="stylesheet"/>
<link type="text/css" href="${contextPath}/style/propertyView.css" rel="stylesheet"/>
<div class="table-div" style="margin:0px;">
	<!-- list -->
	<table class="table-list" border="0" style="margin:0px;border-bottom: 1px solid #d7dce5;" >
	
		<tr class="table-header-tr">
			<th colspan="${colspansize}">${dispatcher.function.title}</th>
		</tr>
		
		<c:forEach var="menu" items="${dispatcher.menus}" varStatus="datasLoop">
			<tr class="table-data-tr">
				<td class="table-data-td" align="left">
					<span class="table-head-value" id="${data.id}_${head.name}_value">
						<a href="${menu.url}" target="${menu.target}"><img src="${menu.icon}"> ${menu.title}</a>
					</span>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
</c:if>