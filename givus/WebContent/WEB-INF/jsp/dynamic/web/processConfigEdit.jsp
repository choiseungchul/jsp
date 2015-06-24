<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>

<script>
function processConfigEdit_Init( params){
	var process = $('td#TD_'+params.code);
	var popup = $('#process-config-window');
	popup.find('#code').html( process.find('[name=code]:input').val());
	popup.find('#name').html( process.find('[name=name]:input').val());
	popup.find('#standard').html( process.find('[name=standard]:input').val());
	popup.find('#percentage').val( process.find('[name=data]:input').val());
}

function createDefective(){
	var code = $('#process-config-window').find( '#code').html();
	var percentage = $('#process-config-window').find('[name=percentage]:input').val();
	if( percentage == null || percentage.length == 0){
		$('#percentage_error').show();
		return;
	}
	
	dynamic.sjax.call('kr.co.sinshin.loss.sjax.SjaxService.createDefective(' + code + ',' + percentage + ')');
	alert( '등록되었습니다.');
	
	document.location.reload();
}

function calculateQuantity(){
	var quantity = $('#product-calculate-window').find('[name=quantity]:input').val();
	if( quantity == null || quantity.length == 0){
		$('#quantity_error').show();
		return;
	}
	var reservePercentage = $('#product-calculate-window').find('[name=reservePercentage]:input').val();
	if( reservePercentage == null || reservePercentage.length == 0){
		$('#reservePercentage_error').show();
		return;
	}
	var param = {
		fid : 'WB'
		//,code : '${workModel.productModel.code}'
		,code : '${dispatcher.data.productModel.code}'
		,quantity : quantity
		,reservePercentage : reservePercentage
	};
	dynamic.util.move( '/work.do', param);
}

</script>

<%-- 발주 수량 계산 팝업 --%>
<div id="product-calculate-window" style="display:none;width:590px;height:350px;">
	<div class="table-title-div">
		<span class="table-title" style="color:#000;">수주 정보 설정</span>
	</div>
	<table class="property-list">
		<tr>
			<td class="property-title-td">수주량</td>
			<td class="property-value-td">
				<input type="text" id="quantity" name="quantity" value="20000" size="10px;" class="input-text" style="text-align:left;">
				<span id="quantity_error" style="display:none;color:red;" class="error">이 항목을 입력해 주십시오.</span>
			</td>
		</tr>
		<tr>
			<td class="property-title-td">예비율</td>
			<td class="property-value-td">
				<input type="text" id="reservePercentage" name="reservePercentage" value="3" size="10px;" class="input-text" style="text-align:left;"> %
				<span id="reservePercentage_error" style="display:none;color:red;" class="error">이 항목을 입력해 주십시오.</span>
			</td>
		</tr>
	</table>
	<div class="process-config-window-buttons">
		<span class="button button-create" onclick="calculateQuantity()">계산</span>
		<span class="button button-close">닫기</span>
	</div>
</div>

<%-- 공정 설정 팝업 --%>
<div id="process-config-window" style="display:none;width:590px;height:350px;">
	<div class="table-title-div">
		<span class="table-title" style="color:#000;">공정 정보 설정</span>
	</div>
	<table class="property-list">
		<tr>
			<td class="property-title-td">코드</td>
			<td class="property-value-td"><span id="code"></span></td>
		</tr>
		<tr>
			<td class="property-title-td">공정명</td>
			<td class="property-value-td"><span id="name"></span></td>
		</tr>
		<tr>
			<td class="property-title-td">규격</td>
			<td class="property-value-td"><span id="standard"></span></td>
		</tr>
		<tr>
			<td class="property-title-td">불량률</td>
			<td class="property-value-td">
				<input type="text" id="percentage" name="percentage" value="" size="10px;" class="input-text" style="text-align:left;"> %
				<span id="percentage_error" style="display:none;color:red;" class="error">이 항목을 입력해 주십시오.</span>
			</td>
		</tr>
	</table>
	<div class="process-config-window-buttons">
		<span class="button button-create" onclick="createDefective()">등록</span>
		<span class="button button-close">닫기</span>
	</div>
</div>