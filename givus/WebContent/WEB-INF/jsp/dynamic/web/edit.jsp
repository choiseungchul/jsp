<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>

<!-- variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="func" value="${dispatcher.function}"/>

<!-- title -->
<div class="property-title-div">
	<c:if test="${dispatcher.function.title != null}">
		<span class="table-title">${func.title}</span> 
	</c:if>
</div>

<form:form id="form" enctype="multipart/form-data">
	<div class="property-form">
	<form:errors path="${id}" cssClass="property-error"/>
	<table class="property-list">
		<c:forEach var="head" items="${dispatcher.headers}">
			<c:set var="render" value="${dispatcher.renders[head.name]}"/>
			<%-- 
			<c:set var="validationCss" value=""/>
			<c:forEach var="field" items="${dispatcher.function.validator.notnulls}">
				<c:if test="${field == head.name}"><c:set var="validationCss" value="notnull"/></c:if>	
			</c:forEach>
			--%>
			<tr>
				<td class="property-title-td"><span class="property-title">${head.title}</span><span class="${validationCss}">&nbsp;&nbsp;&nbsp;</span></td>
				<td class="property-value-td">
					<span class="property-value">
					<c:choose>
						<c:when test="${head.name == 'description'}">
							<form:textarea path="${head.name}" cssClass="input-text" cssStyle="width:305px;height:100px;"/>
						</c:when>
						<c:when test="${head.name == 'password' || head.name == 'passwd'}">
							<form:password path="${head.name}" cssClass="input-text"/>
						</c:when>
						<c:when test="${render == null || render.type == 'text' || render.type == 'number'}">
							<form:input path="${head.name}" cssClass="input-text" size="50"/>
						</c:when>
						<c:when test="${render.type == 'date'}">
							<input type="text" id="${head.name}" name="${head.name}" value="${dispatcher.data.renderedData[head.name]}" class="input-text" style="margin-right:3px">
							<script type="text/javascript">
								$(document).ready( function(){ $("#${render.name}").datepicker();});
								//$(document).ready( function(){ $("#${render.name}").datepicker().datepicker('setDate', new Date())});
							</script>
						</c:when>
						<c:when test="${render.type == 'image' || render.type == 'file'}">
							<span id="${head.name}">${dispatcher.data.renderedData[head.name]}</span><br/>
							<span>
								<input size="50" type="file" id="file_${head.name}" name="file_${head.name}" value="" class="input-text">
								<!-- 
								<input type="hidden" name="file_${head.name}_delete" id="file_${head.name}_delete" value="N">
								<br/><input type='button' class='button' value='삭제' style='margin-top:3px;margin-bottom:3px;' onclick="dynamic.util.delFile('${head.name}')"/>
								 -->
							</span>
						</c:when>
						<c:when test="${render.type == 'type'}">
							<form:radiobuttons path="${head.name}" items="${items[head.name]}"/>
						</c:when>
						<c:when test="${render.type == 'select'}">
							<c:set var="itemsName" value="${head.name}_items"/>
							<form:select path="${head.name}" items="${requestScope[itemsName]}"/>
						</c:when>
						<c:when test="${render.type == 'radio'}">
							<c:set var="itemsName" value="${head.name}_items"/>
							<form:radiobuttons path="${head.name}" items="${requestScope[itemsName]}"/>
						</c:when>
						<c:when test="${render.type == 'combo'}">
							<c:set var="itemsName" value="${head.name}_items"/>
							<form:select path="${head.name}">
								<form:options items="${requestScope[itemsName]}"/>
							</form:select>
						</c:when>
						<c:when test="${render.type == 'relation'}">
							<c:set var="renderedValue" value=""/>
							<c:if test="${dispatcher.data.renderedData[head.name] != 'null'}"><%-- hashmap 에서는 null 객체가 아닌 null text 가 나온다. --%>
								<c:set var="renderedValue" value="${dispatcher.data.renderedData[head.name]}"/>
							</c:if>
							<input id="suggest_${head.name}" name="suggest_${head.name}" type="text" size="50" class="input-text" value="${renderedValue}">
							<form:hidden path="${head.name}"/>
							<script>
								$(function(){
									$('#suggest_${head.name}').autocomplete({
										serviceUrl : '${contextPath}/ajax.do', minChars: 2,
										params:{ fid:'${func.id}', field:'${head.name}'},
										onSelect: function( value, data){ $('#${head.name}').val( data).change();}
									});
								});
							</script>
						</c:when>
					</c:choose>
					</span>
					<form:errors path="${head.name}" cssClass="property-error"/>
					<c:set var="msgKey" value="${func.messageKey}.${head.name}"/>
					<c:if test="${msgHandler[msgKey] != null}">
						<span class="tipTip" title="${msgHandler[msgKey]}"><img src="${imageHandler.memo}"/></span>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	
	<c:forEach var="hidden" items="${dispatcher.hiddenFields}">
		<input type="hidden" name="${hidden.name}" value="${hidden.value}"/>
	</c:forEach>
	
	<div class="property-edit-buttons">
		<c:set var="button_text" value="등록"/>
		<c:if test="${dispatcher.parameter.action == 'modify'}">
			<c:set var="button_text" value="수정"/>
		</c:if>
		
		<a class="button" href="javascript:dynamic.util.submitForm('form')">${button_text}</a>
		<c:forEach var="button" items="${dispatcher.buttons}">
			<a class="button" href="${button.link}" target="${button.target}">${button.title}</a>
		</c:forEach>
	</div>
</form:form>