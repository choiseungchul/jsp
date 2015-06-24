<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link type="text/css" href="${contextPath}/style/timeTable.css" rel="stylesheet"/>
<link type="text/css" href="${contextPath}/style/sinshin/propertyView.css" rel="stylesheet"/>
<c:set var="tableListTop" value="65"/><%-- default table's top --%>
<script>
$(function(){
	$(window).scroll(function(){
		$('div#fixArea').css('top', $(window).scrollTop());
	});
});
$(function(){
	$(':checkbox[id^=${dispatcher.function.id}_chk_]').bind('click', function(){
		var chk = $(this);
		var tr = chk.parents("tr");
		if( chk.is(':checked')){
			tr.addClass("table-tr-alert").find('span').addClass("table-td-alert");
		}else{
			tr.removeClass("table-tr-alert").find('span').removeClass("table-td-alert");
		}
	});
});
</script>
<div id="${ dispatcher.function.id}_table" class="table-div">
	<div id="fixArea" style="position:absolute;z-index:10;background-color:white;width:${dispatcher.width};top:0px;">
	<!-- button -->
	<div style="height:22px;padding-top:5px;">
		<div class="table-button-div" style="float:left">
			<c:if test="${not empty dispatcher.buttons}"><c:set var="tableListTop" value="${tableListTop + 27}"/>
			<c:forEach var="button" items="${dispatcher.buttons}">
				<span class="button">
					<a href="${button.link}" target="${button.target}"><span class="table-button-text">${button.title}</span></a>
				</span>
			</c:forEach>
			</c:if>
			<span class="button">
				<a href="${preMonthUrl}"><span class="calendar-button-text">이전달</span></a>
			</span>
			<span class="button">
				<a href="${nextMonthUrl}"><span class="calendar-button-text">다음달</span></a>
			</span>
		</div>	
	</div>
	<!-- title -->
	<div style="height:25px;z-index:10;">
		<div class="table-title-div">
			<c:if test="${dispatcher.function.title != null}">
				<%-- a href="${refreshUrl}"><span class="table-title">${dispatcher.function.title}</span></a --%> 
				<span class="table-title">${dispatcher.function.title}</span>
			</c:if>
		</div>
	</div>
	<!-- filter -->
	<c:if test="${not empty dispatcher.dateFilters || not empty dispatcher.filters}">
		<form method="post" action="${dispatcher.filterRemoveUrl}" id="searchform">
		<div class="table-filter-div" style="width:${dispatcher.width};">
	</c:if>
	<!-- date filter -->
	<c:if test="${not empty dispatcher.dateFilters}">
			<select name="date_filter_name" class="table-filter-select" tabindex="1">
				<c:forEach var="filter" items="${dispatcher.dateFilters}">
					<c:set var="selected" value=""/>
					<c:if test="${dispatcher.parameter.dateFilterName == filter.name}"><c:set var="selected" value="selected='selected'"/></c:if>
					<option value="${filter.name}" ${selected}>${filter.title}</option>
				</c:forEach>
			</select>
			<input type="text" id="date_filter_start" name="date_filter_start" value="${dispatcher.parameter.dateFilterStart}" class="input-text" style="margin-right:3px;width:80px;">
			<script type="text/javascript">
				$(document).ready( function(){ $("#date_filter_start").datepicker();});
			</script>
			~
			<input type="text" id="date_filter_end" name="date_filter_end" value="${dispatcher.parameter.dateFilterEnd}" class="input-text" style="margin-right:3px;width:80px;">
			<script type="text/javascript">
				$(document).ready( function(){ $("#date_filter_end").datepicker();});
			</script>
			<span>&nbsp;&nbsp; | &nbsp;&nbsp;</span>
	</c:if>
	<!-- text filter -->
	<c:if test="${not empty dispatcher.filters}">
			<select name="filter_name" class="table-filter-select" tabindex="1">
				<c:forEach var="filter" items="${dispatcher.filters}">
					<c:set var="selected" value=""/>
					<c:if test="${param.filter_name == filter.name}"><c:set var="selected" value="selected='selected'"/></c:if>
					<option value="${filter.name}" ${selected}>${filter.title}</option>
				</c:forEach>
			</select>
			<input class="input-text" type="text" id="filter_value" name="filter_value" onkeyup="dynamic.util.filterKeyControl('searchform', event)" value="${filter_value}" tabindex="2">
			<span>&nbsp;&nbsp; | &nbsp;&nbsp;</span>
	</c:if>
	<c:if test="${not empty dispatcher.dateFilters || not empty dispatcher.filters}">
			<span class="button" onclick="dynamic.util.submitForm('searchform')" tabindex="3"><span class="button-text">검색</span></span>
			<span class="button" onkeypress="dynamic.util.enterClick('${dispatcher.filterRemoveUrl}', event)" tabindex="4"><a id="search_cancel" href="${dispatcher.filterRemoveUrl}"><span class="button-text">전체보기</span></a></span>
			[ <span class="table-pageno">${dispatcher.parameter.pageNo}</span> / <span class="table-totalPage">${dispatcher.parameter.totalPage}</span> ]	
			<span class="table-totalCount">${dispatcher.parameter.totalCount}</span> ${msgHandler["table.total.suffix"]}
		</div>
		</form>
	</c:if>
	<c:if test="${not empty dispatcher.textFilter}">
		<div class="text-filter">
			<c:forEach items="${dispatcher.textFilter.items}" var="item">
			<div class="text-filter-item"><span><a href="${item.link}">${item.name}</a></span></div>
			</c:forEach>
		</div>
	</c:if>
	<!-- header -->
	<table class="table-list" border="0" style="width:${dispatcher.width}px">
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
	</table>
	</div>
	<table class="table-list" border="0" style="margin-top:${tableListTop}px;width:${dispatcher.width}px">
		<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
			<tr class="table-data-tr ${data.className}" id="${dispatcher.function.id}_tr_${datasLoop.count}">
				<th class="table-data-checkbox"><input type="checkbox" name="${dispatcher.function.id}_chk_${data.id}" id="${dispatcher.function.id}_chk_${datasLoop.count}" value="${data.id}"></td>
				<c:forEach var="head" items="${dispatcher.headers}">
					<th class="table-data-td ${head.className}" align="${head.align}" width="${head.width}">
						<span class="table-head-value" id="${data.id}_${head.name}_value">
							<c:choose>
								<c:when test="${data.renderedData[head.name] != null}">
								${data.renderedData[head.name]} 
								</c:when>
								<c:otherwise>
								${data[head.name]}
								</c:otherwise>
							</c:choose>
						</span>
					</th>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
</div>