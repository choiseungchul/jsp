<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- variable --%>
<c:set var="refreshUrl" value="${dispatcher.defaultUrl}"/>
<c:set var="workModel" value="${dispatcher.data}"/>
<c:set var="func" value="${dispatcher.function}"/>

<link type="text/css" href="${ contextPath}/style/table.css" rel="stylesheet"/>
<link type="text/css" href="${contextPath}/style/workPlan.css" rel="stylesheet"/>

<jsp:useBean id="roleHandler" class="dynamic.util.RoleHandler"></jsp:useBean>

<script>
$(document).ready(function(){
	$('td:has(.process-config)').each( function(){
		$(this).hover( function(e){
				$(this).find( '.process-config').show('fast');
			}, function(e){
				$(this).find( '.process-config').hide('fast');
			}
		);
	});
});
</script>

<div id="${dispatcher.function.id}_table" class="table-div">
	<%-- title 
	<div style="height:50px;">
		<div class="workplan-title-div">
			<span>${workModel.productModel.name}</span>
		</div>
	</div>
	--%>
	
	<%-- button --%>
	<div class="table-button-div">
		<c:forEach var="button" items="${dispatcher.buttons}">
			<span class="button">
				<a href="${button.link}" target="${button.target}"><span class="table-button-text">${button.title}</span></a></span>
		</c:forEach>
	</div>
	
	<%-- Process Info --%>
	<c:if test="${workModel.partWorkModels != null}">
	<div style="width:${dispatcher.width}px">
		<div class="table-title-div">
			<span class="table-title">${func.title}</span>
		</div>
		<table class="table-list" border="0">
			<tr class="table-header-tr">
				<th class="table-header-checkbox"><input type="checkbox" name="${dispatcher.function.id}_chkall" id="${dispatcher.function.id}_chkall"></th>
				<c:forEach var="head" items="${dispatcher.headers}" varStatus="headersLoop">
					<th class="table-header-td" width="${head.width}">
						<span class="table-head-title">${head.title}</span>
					</th>
				</c:forEach>
			</tr>
			
			<%-- PartList --%>
			<c:forEach var="part" items="${workModel.partWorkModels}" varStatus="datasLoop">
				<c:set var="data" value="${part.productModel}"/>
				<tr class="table-data-tr">
					<td class="table-data-checkbox"><input type="checkbox" name="${dispatcher.function.id}_chk_${data.code}" id="${dispatcher.function.id}_chk_${data.code}" value="${data.code}"></td>
					<td class="table-data-td tipTip" style="word-wrap:keep-all;" title="${data.name} <br/> 제품코드 : ${data.code}">
						<div class="partInfo">
							<div>${data.name}</div>
							<div style="margin-top:3px;">${data.code}</div>
							<div style="margin-top:3px">${data.renderedData.fileId}</div>
						</div>
						<% if( roleHandler.checkUserRole("processManager")){ %>
						<div class="process-config" style="display:none;position:relative;">
							<a href="javascript:sinshin.process.showProcessConfigPopup('${data.code}')"><img src="${imageHandler.plus}" title="공정추가"></a>
							<a href="javascript:sinshin.product.showPartProductCreatePopup('/edit.do?fid=${funcHandler.funcPartProductEdit.id}&action=modify&code=${data.code}')"><img src="${imageHandler.config}" title="제품 정보 수정"></a>
							<a href="javascript:sinshin.product.showPartProductDeletePopup('${data.id}')"><img src="${imageHandler.delete}" title="삭제"></a>
						</div>
						<% } %>
					</td>
					<%-- processes --%> 
					<c:forEach var="process" items="${part.processWorkModels}">
						<c:set var="processModel" value="${process.processModel}"/>
						<c:set var="productModel" value="${process.processProductModel}"/>
						<c:set var="dispatcher" value="${process.data}"/>
						<c:choose>
							<c:when test="${productModel == null}">
								<td id="TD_${processModel.processProductCode}_${processModel.id}" class="table-data-td" style="border:1px solid #d7dce5;background-color:#efefef;"></td>
							</c:when>
							<c:otherwise> 
								<td id="TD_${processModel.processProductCode}_${processModel.id}" class="table-data-td" style="border:1px solid #d7dce5;">
									<input type="hidden" name="code" value="${productModel.code}"/>
									<input type="hidden" name="name" value="${productModel.name}"/>
									<input type="hidden" name="standard" value="${productModel.standard}"/>
									<input type="hidden" name="data" value="${process.data}"/>
									<div class="data" style="text-align:center;">
										<div class="process-title">
											<span style="font-weight:bold;">${process.processTypeName}</span>
											<c:set var="action" value="modify"/>
											<c:if test="${ dispatcher == null}">
												<c:set var="action" value="create"/>
											</c:if>
											<% if( roleHandler.checkUserRole("processManager")){ %>
											<div id="process-config-${processModel.processProductCode}" class="process-config" style="display:none;">
												<a href="javascript:sinshin.process.moveLeft('TD_${processModel.processProductCode}_${processModel.id}')"><img src="${imageHandler.arrow_left}" title="앞의 공정으로 이동"></a>
												<a href="javascript:sinshin.process.moveRight('TD_${processModel.processProductCode}_${processModel.id}')"><img src="${imageHandler.arrow_right}" title="다음 공정으로 이동"></a>
												<a href="javascript:sinshin.process.showProcessConfig('${processModel.id}')"><img src="${imageHandler.config}" title="등록 / 수정"></a>
												<a href="javascript:sinshin.process.showProcessDelete('${processModel.id}')"><img src="${imageHandler.delete}" title="삭제"></a>
												<c:if test="${processModel.renderedData.hasHistory}">
												<a href="javascript:sinshin.changerecord.showChangeRecordPopup('Process', '${processModel.id}')"><img src="${imageHandler.history}" title="변경이력"></a>
												</c:if>
											</div>
											<% } %>
										</div>
										<div class="property-view">
											<table class="property-list" style="padding-top:0px;margin-top:0px;border-top:2px solid #cbcbcb;border-bottom:2px solid #cbcbcb;">
												<c:forEach var="head" items="${dispatcher.headers}">
												<tr style="height:20px;">
													<td class="property-title-td" style="width:80px;"><span class="property-title">${head.title}</span></td>
													<td class="property-value-td" style="height:${head.width}">
														<span id="${head.name}_value" class="property-value ${head.className}">
															<c:if test="${dispatcher.data.renderedData[head.name] != null}">
																${dispatcher.data.renderedData[head.name]}
															</c:if>
															<c:if test="${dispatcher.data.renderedData[head.name] == null}">
																${dispatcher.data[head.name]}
															</c:if>
														</span>
													</td>
												</tr>
												</c:forEach>
											</table>
										</div><!-- properview-view -->
									</div>
								</td>
							</c:otherwise>
						</c:choose>
					</c:forEach><%-- Processes --%>
				</tr>
			</c:forEach><%-- Part List --%>
		</table>
	</div>
	</c:if>
	<%-- Process Info End--%>
</div> 

<jsp:include page="/WEB-INF/jsp/dynamic/web/processConfigEdit.jsp"/>