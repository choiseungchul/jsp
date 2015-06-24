<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link type="text/css" href="/mrp/style/imagetable.css" rel="stylesheet"/>

<!-- variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="refreshUrl" value="${contextPath}/list.do?fid=${func.id}"/>
<c:set var="dataSize" value="${fn:length(datas)}"/>

<!-- title -->
<div class="table-div">
<div class="table-title-div">
	<c:if test="${func.title != null}">
		<a href="${refreshUrl}"><span class="table-title">${func.title}</span></a> 
	</c:if>
</div>

<!-- button -->
<div class="table-button-div">
	<c:forEach var="button" items="${buttons}">
		<span class="button">
			<a href="${button.link}" target="${button.target}"><span class="table-button-text">${button.title}</span></a></span>
	</c:forEach>
</div>

<!-- list -->
<div class="table-image-list">

	<c:forEach var="data" items="${datas}" varStatus="loop">
		<c:choose>
			<c:when test="${loop.count % 2 == 0}">
				<c:set var="className" value="table-data-last"/>
			</c:when>
			<c:otherwise>
				<c:set var="className" value=""/>
			</c:otherwise>
		</c:choose>
		
		<div class="table-data ${className}">
		<c:forEach var="head" items="${headers}">
			<div class="table-data-value">
				<span title="${head.title}">
				<c:if test="${data.renderedData[head.name] != null}">
				 ${data.renderedData[head.name]}
				</c:if>
				<c:if test="${data.renderedData[head.name] == null}">
				${data[head.name]}
				</c:if>
				</span>
			</div>
		</c:forEach>
		</div>
	</c:forEach>
	
	<c:if test="${dataSize <= 0}">
	<div class="table-nodata-div">
		<div class="table-nodata">등록된 데이터가 없습니다.</div>
	</div>
	</c:if>
</div>

<!-- filter -->
<c:if test="${not empty filters}">
	<div class="table-filter-div">
	<form method="post" action="${refreshUrl}" id="searchform">
		<select name="filter_name" class="table-filter-select">
			<c:forEach var="filter" items="${filters}">
				<c:set var="selected" value=""/>
				<c:if test="${filter_name == filter.name}"><c:set var="selected" value="selected='selected'"/></c:if>
				<option value="${filter.name}" ${selected}>${filter.title}</option>
			</c:forEach>
		</select>
		<input class="input-text" type="text" id="filter_value" name="filter_value" value="${filter_value}">
		<span class="button" onclick="dynamic.util.submitForm('searchform')"><span class="button-text">검색</span></span>
		<span class="button"><a href="${refreshUrl}"><span class="button-text">전체목록</span></a></span>
	</form>
	</div>
</c:if>

<!-- navigation -->
<div class="table-nav-div">
	<c:forEach var="nav" items="${navigations}">
			<c:if test="${nav.selected}"><a href="${nav.url}"><span class="table-nav-selected">${nav.name}</span></a></c:if>
			<c:if test="${nav.selected == false}"><a href="${nav.url}"><span class="table-nav">${nav.name}</span></a></c:if>
	</c:forEach>
</div>

<!-- pageinfo -->
<div class="table-pageinfo">
		페이지 [<span class="table-pageno">${parameter.pageNo}</span> /	<span class="table-totalPage">${parameter.totalPage}</span>]
		총 [<span class="table-totalCount">${parameter.totalCount}</span>] 건
</div>

</div>