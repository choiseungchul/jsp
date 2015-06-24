<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="/mrp/style/property.css" rel="stylesheet"/>

<!-- variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- title -->
<div class="property-title-div">
	<c:if test="${func.title != null}">
		<span class="table-title">${func.title}</span> 
	</c:if>
</div>

<form:form enctype="multipart/form-data" id="form">
	<div class="property-form">
	<table class="property-list">
		<c:forEach var="head" items="${headers}">
			<c:set var="render" value="${renders[head.name]}"/>
			<c:set var="validationCss" value=""/>
			<c:forEach var="field" items="${func.validator.notnull}">
				<c:if test="${field == head.name}"><c:set var="validationCss" value="notnull"/></c:if>	
			</c:forEach>
			
			<tr>
				<td class="property-title-td"><span class="property-title">${head.title}</span><span class="${validationCss}"></span></td>
				<td class="property-value-td">
					<span class="property-value">
					<c:choose>
						<c:when test="${render == null || render.type == 'text'}">
							<form:input path="${head.name}" cssClass="input-text" size="50"/>
						</c:when>
						
						<c:when test="${render.type == 'date'}">
							<input type="text" id="${head.name}" name="${head.name}" value="${data.renderedData[head.name]}" class="input-text" style="margin-right:3px">
							<script type="text/javascript">
								$(document).ready( function(){ $("#${render.name}").datepicker();});
							</script>
						</c:when>
						
						<c:when test="${render.type == 'image'}">
							<span>${data.renderedData[head.name]}</span>
							<span>
								<input size="50" type="file" id="file_${head.name}" name="file_${head.name}" value="" class="input-text">
							</span>
						</c:when>
						
						<c:when test="${render.type == 'type'}">
							<form:radiobuttons path="${head.name}" items="${items[head.name]}"/>
						</c:when>
						
						<c:when test="${render.type == 'relation'}">
							<c:set var="renderedValue" value=""/>
							<c:if test="${data.renderedData[head.name] != 'null'}"><%-- hashmap 에서는 null 객체가 아닌 null text 가 나온다. --%>
								<c:set var="renderedValue" value="${data.renderedData[head.name]}"/>
							</c:if>
							<input id="suggest_${head.name}" name="suggest_${head.name}" type="text" size="50" class="input-text" value="${renderedValue}">
							<form:hidden path="${head.name}"/>
							<script>
								$(function(){
									$('#suggest_${head.name}').autocomplete({
										serviceUrl : '${contextPath}/ajax.do', minChars: 1,
										params:{ fid:'${func.id}', field:'${head.name}'},
										onSelect: function( value, data){ $('#${head.name}').val( data);}
									});
								});
							</script>
						</c:when>
					</c:choose>
					</span>
					
					<form:errors path="${head.name}" cssClass="property-error"/>
				</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	
	<c:forEach var="hidden" items="${hiddenFields}">
		<input type="hidden" name="${hidden.name}" value="${hidden.value}"/>
	</c:forEach>
	
	<div class="property-edit-buttons">
		<c:set var="button_text" value="등록"/>
		<c:if test="${parameter.action == 'modify'}">
			<c:set var="button_text" value="수정"/>
		</c:if>
		
		<span class="button">
			<span class="button-text" onclick="dynamic.util.submitForm('form')">${button_text}</span>
		</span>
		<c:forEach var="button" items="${buttons}">
			<span class="button">
				<a href="${button.link}" target="${button.target}"><span class="button-text">${button.title}</span></a>
			</span>
		</c:forEach>
	</div>
</form:form>

<script type="text/javascript">
	$(function() {
		// block enter submit
		$("form input").keypress(function (e) {
			if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
				$('button[type=submit] .default').click();
				return false;
			} else {
				return true;
			}
	   });
	});
</script>