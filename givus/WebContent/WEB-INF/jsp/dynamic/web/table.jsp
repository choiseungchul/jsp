<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<script>
$(function(){
	$('#filter_value').focus();
});
</script>
<c:if test="${dispatcher.function.trAdditionalPageURL != null }">
<script>
$(function(){
	$(':checkbox[id^=${dispatcher.function.id}_chk_]').bind('click', function(){
		var id = $(this).attr('id').split('_')[2];
		var chk = $('#${dispatcher.function.id}_chk_' + id);
		var trAdditional = $('#${dispatcher.function.id}_chk_' + id + '_trAdditionalInfo');
		var div = $('#${dispatcher.function.id}_chk_' + id + '_trAdditionalInfo_div');
		if( chk.is(':checked')){
			trAdditional.show();
			div.html('loading...');
			$.ajax({
				url: div.attr('url'),
				success: function( responseText){
					div.html( responseText);
				},
				dataType: 'html',
				async: true,
				cache: true,
				error: function(e){
					var msg = 'Error : ' + e.status + ' ' + e.statusText; 
					alert( msg);
					throw msg;
				}
			});
		}else{
			trAdditional.hide();
		}
	});
});

</script>
</c:if>
<!-- variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="refreshUrl" value="${dispatcher.defaultUrl}"/>

<link type="text/css" href="${contextPath}/style/table.css" rel="stylesheet"/>
<link type="text/css" href="${contextPath}/style/propertyView.css" rel="stylesheet"/>

<div>
<c:choose>
	<c:when test="${dispatcher.function.width > 0}">
	<div id="${ dispatcher.function.id}_table" class="table-div" style="width:${dispatcher.function.width}px;margin:0 auto;">
	</c:when>
	<c:otherwise>
	<div id="${ dispatcher.function.id}_table" class="table-div">
	</c:otherwise>
</c:choose>
	<div style="height:30px;">
		<!-- title -->
		<div class="table-title-div" style="float:left;">
			<c:if test="${dispatcher.function.title != null}">
				<%-- a href="${refreshUrl}"><span class="table-title">${dispatcher.function.title}</span></a --%> 
				<span class="table-title">${dispatcher.function.title}</span>
			</c:if>
		</div>
		<c:if test="${not empty dispatcher.buttons}">
		<!-- button -->
		<div class="table-button-div" style="float:right;">
			<c:forEach var="button" items="${dispatcher.buttons}">
				<a href="${button.link}" target="${button.target}"><span class="btn btn-small"><i class="${button.className}"></i> ${button.title}</span></a>
			</c:forEach>
		</div>	
		</c:if>
	</div>
	<!-- filter -->
	<c:if test="${not empty dispatcher.dateFilters || not empty dispatcher.filters}">
	<form method="post" action="${dispatcher.filterRemoveUrl}" id="searchform">
	<div class="table-filter-div">
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
		<c:if test="${not empty dispatcher.parameter.dateFilterName}">
			<c:set var="dateFilterStart" value="${dispatcher.parameter.dateFilterStart}"/>
			<c:set var="dateFilterEnd" value="${dispatcher.parameter.dateFilterEnd}"/>
		</c:if>
		<input type="text" id="date_filter_start" name="date_filter_start" value="${dateFilterStart}" class="input-text" style="margin-right:3px;width:80px;">
		~
		<input type="text" id="date_filter_end" name="date_filter_end" value="${dateFilterEnd}" class="input-text" style="margin-right:3px;width:80px;">
		<script type="text/javascript">$(document).ready( function(){ $("#date_filter_start").datepicker(); $("#date_filter_end").datepicker();});</script>
		<span>&nbsp;&nbsp; | &nbsp;&nbsp;</span>
	</c:if>
	<!-- text filter -->
	<c:if test="${not empty dispatcher.filters}">
		<select style="height:25px;margin-bottom:0px;" name="filter_name" class="table-filter-select" tabindex="1">
			<c:forEach var="filter" items="${dispatcher.filters}">
				<c:set var="selected" value=""/>
				<c:if test="${param.filter_name == filter.name}"><c:set var="selected" value="selected='selected'"/></c:if>
				<option value="${filter.name}" ${selected}>${filter.title}</option>
			</c:forEach>
		</select>
		<input style="height:15px;margin-bottom:0px;" class="input-text" type="text" id="filter_value" name="filter_value" onkeyup="dynamic.util.filterKeyControl('searchform', event)" value="${filter_value}" tabindex="2">
		<span>&nbsp;&nbsp; | &nbsp;&nbsp;</span>
	</c:if>
	<c:if test="${not empty dispatcher.dateFilters || not empty dispatcher.filters}">
		<span class="btn btn-mini btn-primary" onclick="dynamic.util.submitForm('searchform')" tabindex="3">검색</span>
		<span class="btn btn-mini" onkeypress="dynamic.util.enterClick('${dispatcher.filterRemoveUrl}', event)" tabindex="4"><a id="search_cancel" href="${dispatcher.filterRemoveUrl}"><span class="button-text">전체보기</span></a></span>
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
	<%-- list --%>
	<div id="${dispatcher.function.id}_table_data">
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
			<tr class="table-data-tr ${data.className}" id="${dispatcher.function.id}_tr_${data.id}">
				<td class="table-data-checkbox"><input type="checkbox" name="${dispatcher.function.id}_chk_${data.id}" id="${dispatcher.function.id}_chk_${data.id}" value="${data.id}"></td>
				<c:forEach var="head" items="${dispatcher.headers}">
					<td class="table-data-td ${head.className}" align="${head.align}">
							<c:choose>
								<c:when test="${data.renderedData[head.name] != null}">
								${data.renderedData[head.name]} 
								</c:when>
								<c:otherwise>
								${data[head.name]}
								</c:otherwise>
							</c:choose>
					</td>
				</c:forEach>
			</tr>
			<c:if test="${dispatcher.function.trAdditionalPageURL != null }">
			<!-- additional info -->
			<tr id="${dispatcher.function.id}_chk_${data.id}_trAdditionalInfo" class="table-data-tr" style="display:none;">
				<td class="table-data-td ${head.className}" align="${head.align}" colspan="${fn:length(dispatcher.headers)+1}">
					<div id="${dispatcher.function.id}_chk_${data.id}_trAdditionalInfo_div" url="${contextPath}${data.renderedData.trAdditionalPageURL}"></div>
				</td>
			</tr>
			</c:if>
		</c:forEach>
		
		<%-- sum --%>
		<c:if test="${dispatcher.sumData != null}">
		<c:set var="data" value="${dispatcher.sumData}"/>
		<tr class="table-data-tr">
			<td class="table-data-checkbox"><input type="checkbox" name="${dispatcher.function.id}_chk_${data.id}" id="${dispatcher.function.id}_chk_${data.id}" value="${data.id}"></td>
			<c:forEach var="head" items="${dispatcher.headers}">
				<td class="table-data-td" align="${head.align}">
					<span class="table-head-value" id="${data.id}_${head.name}_value">
						<c:choose>
							<c:when test="${data.renderedData[head.name] != null}">
							${data.renderedData[head.name]}
							</c:when>
							<c:otherwise>
							<c:catch>${data[head.name]}</c:catch>
							</c:otherwise>
						</c:choose>
					</span>
				</td>
			</c:forEach>
		</tr>
		</c:if>
		
		<c:if test="${empty dispatcher.datas}">
			<c:set var="colspansize" value="${fn:length(dispatcher.headers) + 1}"/>
			<tr>
				<td align="center" colspan="${colspansize}" height="100px"><div class="table-nodata"><span>${msgHandler["table.nodata"]}</span></div></td>
			</tr>
		</c:if>
	</table>
	</div>
	<%-- navigation --%>
	<c:if test="${not empty dispatcher.navigations}">
		<div class="table-nav-div">
		<c:forEach var="nav" items="${dispatcher.navigations}">
			<c:if test="${nav.selected}"><a href="${nav.url}"><span class="table-nav-selected btn btn-small">${nav.name}</span></a></c:if>
			<c:if test="${nav.selected == false}"><a href="${nav.url}"><span class="${nav.className}">${nav.name}</span></a></c:if>
		</c:forEach>
		</div>
	</c:if>
</div>
</div>