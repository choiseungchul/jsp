<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>
<style>
.table{margin-bottom:10px;}
body {
  font-family: "Malgun Gothic", "Helvetica Neue", Helvetica, Arial, sans-serif;
  padding-top:0px;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
	margin-bottom:3px;
	font-size:9pt;
	font-family: "Malgun Gothic", "Helvetica Neue", Helvetica, Arial, sans-serif;
	padding-top:1px;
	padding-bottom:1px;
	width:150px;
	min-height:18px;
	height:18px;
}
.operationFirst{
	font-weight: bold;
}
.operationSecond{
	padding-left: 20px;
	width: 200px;
}
.digit_display{
	width: 200px;
	font-weight: bold;
}
</style>
<script>
$(function(){
	$("input[name^=operation]").keyup(function(){
		var value = $(this).val();
		if( value){
			if( isNaN( value)){
				$('#'+$(this).attr('name')+"_display").html( '숫자를 입력해 주세요.');
				return;
			}
			var hangul = dynamic.util.digitToHangul( value);
			$('#'+$(this).attr('name')+"_display").html( hangul + '원');
		}
	}).each( function(){
		if( $(this).val()){
			$(this).keyup();
		}
	});
	
	$('.btn-submit').click( function(){
		// check validation
		var nodes = [];
		$("input[name^=operation]").each(function(){
			if( $(this).val()){
				var node = {};
				node.id = $(this).attr('name').split('_')[1];
				node.price = $(this).val();
				nodes.push( node);
			}
		});
		if( nodes.length > 0){
			$.ajax({
				type : 'POST',
				url : '/givus/___/operationprice/save/${param.id}',
				data : 'infos=' + $.toJSON( nodes),
				success : function( json){
					alert( json.message);
					if( json.result == 'true'){
						dynamic.jstree.displayAllNodeNormal();
					}else{
						
					}
				}
			});
		}
		alert( $.toJSON( nodes));
	});
});
</script>
<div style="height:20px;width:600px;">
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

<form:form id="form" enctype="multipart/form-data">
	<div class="property-form" style="width:600px">
		<table class="property-list">
		<c:forEach var="operationFirst" items="${operationCategoryRoot.children}">
			<tr>
				<td class="property-title-td operationFirst" >
					<span class="property-title">${operationFirst.name}</span><span class="${validationCss}">&nbsp;&nbsp;&nbsp;</span>
				</td>
				<td class="property-value-td" align="left">
				</td>
			</tr>
			<c:forEach var="operationSecond" items="${operationFirst.children}">
			<tr>
				<td class="property-title-td operationSecond">
					<span class="property-title">${operationSecond.name}</span><span class="${validationCss}">&nbsp;&nbsp;&nbsp;</span>
				</td>
				<td class="property-value-td" align="left">
					<input type="text" name="operation_${operationSecond.id}" value="${operationSecond.renderedData.price}">
					<span class="digit_display" id="operation_${operationSecond.id}_display">&nbsp;</span>
				</td>
			</tr>
			</c:forEach> 
		</c:forEach>
		</table>
		<div class="property-edit-buttons" style="text-align:center">
			<c:set var="button_text" value="등록"/>
			<c:if test="${dispatcher.parameter.action == 'modify'}">
				<c:set var="button_text" value="수정"/>
			</c:if>
			<a href="javascript:dynamic.util.submitForm('form')">
				<span class="btn btn-small btn-submit"><i class="icon-ok"></i> ${button_text}</span>
			</a>
		</div>
	</div>
</form:form>