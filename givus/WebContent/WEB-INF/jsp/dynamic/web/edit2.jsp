<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- variable --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="func" value="${dispatcher.function}"/>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>

<script src="${contextPath}/plugin/jquery_fileupload/js/vendor/jquery.ui.widget.js"></script>

<%-- CKEDITOR --%>
<script src="${contextPath}/plugin/ckeditor/ckeditor.js"></script>

<style>
.table{margin-bottom:10px;}
.fileupload-buttonbar{height:30px;}

body {
  font-family: "Malgun Gothic", "Helvetica Neue", Helvetica, Arial, sans-serif;
  padding-top:0px;
}

input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
	width:500px;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
	margin-bottom:3px;
	font-size:9pt;
	font-family: "Malgun Gothic", "Helvetica Neue", Helvetica, Arial, sans-serif;
	padding-top:1px;
	padding-bottom:1px;
	min-height:23px;
	height:21px;
}
table tr{
	height:30px;
}
</style>
<script>
//$(function(){
	var ckeditor_config = {
		resize_enabled : true, // 에디터 리사이즈 여부
		autoUpdateElement : true, // 자동 textarea 업데이트 여부 (안됨)
		enterMode : CKEDITOR.ENTER_BR , // 에디터 엔터를 <br> 태그를 사용함.
		shiftEnterMode : CKEDITOR.ENTER_P , // 에디터 시프트 + 엔터를 <p> 태그를 사용함
		toolbarCanCollapse : true , // 에디터 툴바 숨기기 기능 여부
		skin:'moonocolor',
		pasteFromWordRemoveFontStyles : false,
		// 에디터 툴바를 설정함.
		toolbar : [
			[ 'Source', 'Maximize', '-' , 'NewPage', 'Preview', 'Print' ],
			[ 'Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo' ],
			[ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'],
			[ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ],
			[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote'],
			'/',
			[ 'Styles', 'Format', 'Font', 'FontSize' ],
			[ 'TextColor', 'BGColor' ],
			[ 'Image', 'Flash', 'Table' , 'SpecialChar' , 'Link', 'Unlink']
		] 
	};
	
	// CKEDITOR.replace('contents', ckeditor_config);
//});

</script>

<div class="wrapper">
<c:choose>
	<c:when test="${dispatcher.function.width > 0}">
	<div id="container" style="width:${dispatcher.function.width}px;margin:0 auto;"><style>.table{width:${dispatcher.function.width}px;}</style>
	</c:when>
	<c:otherwise>
	<div id="container">
	</c:otherwise>
</c:choose>

<div style="height:20px;">
	<!-- title -->
	<div class="property-title-div" style="width:200px;float:left;">
		<c:if test="${dispatcher.function.title != null}">
			<span class="table-title">${dispatcher.function.title}</span> 
		</c:if>
	</div>
	<div style="float:right;">
		<c:forEach var="button" items="${dispatcher.buttons}">
			<a href="${button.link}" target="${button.target}"><span class="btn btn-small"><i class="${button.className}"></i> ${button.title}</span></a>
		</c:forEach>
	</div>
</div>

<%-- input field form --%>
<form:form id="form" enctype="multipart/form-data">
	<div class="property-form">
	<form:errors path="${id}" cssClass="property-error"/>
	<table class="property-list">
		<c:forEach var="head" items="${dispatcher.headers}">
			<c:set var="render" value="${dispatcher.renders[head.name]}"/>
			<tr>
				<td class="property-title-td"><span class="property-title">${head.title}</span><span class="${validationCss}">&nbsp;&nbsp;&nbsp;</span></td>
				<td class="property-value-td">
					<span class="property-value">
					<c:choose>
						<c:when test="${head.name == 'description' || head.name == 'contents' || head.name == 'introduction'}">
							<form:textarea path="${head.name}" cssClass="input-text" cssStyle="width:90%;"/>
							<script>$(function(){CKEDITOR.replace('${head.name}', ckeditor_config);});</script>
						</c:when>
						<c:when test="${head.name == 'password' || head.name == 'passwd'}">
							<form:password path="${head.name}" cssClass="input-text"/>
						</c:when>
						<c:when test="${render == null || render.type == 'text' || render.type == 'number'}">
							<form:input path="${head.name}" cssClass="input-text ${head.className}" size="80"/>
						</c:when>
						<c:when test="${render.type == 'date'}">
							<input type="text" id="${head.name}" name="${head.name}" value="${dispatcher.data.renderedData[head.name]}" class="input-text" style="margin-right:3px">
							<script type="text/javascript">
								$(document).ready( function(){ $("#${render.name}").datepicker();});
							</script>
						</c:when>
						<c:when test="${render.type == 'image' || render.type == 'file'}">
							<span id="${head.name}">${dispatcher.data.renderedData[head.name]}</span><br/>
							<span>
								<input size="50" type="file" id="file_${head.name}" name="file_${head.name}" value="" class="input-text">
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
	
	<input type="hidden" name="fileInfos" value=""/>
	
	<div class="property-edit-buttons" style="text-align:center">
		<c:set var="button_text" value="등록"/>
		<c:if test="${dispatcher.parameter.action == 'modify'}">
			<c:set var="button_text" value="수정"/>
		</c:if>
		<%-- <a href="javascript:dynamic.util.submitForm('form')"> --%>
		<a href="javascript:dynamic.util.submitForm('form')">
			<span class="btn btn-small"><i class="icon-ok"></i> ${button_text}</span>
		</a>
	</div>
</form:form>