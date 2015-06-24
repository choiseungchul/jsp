<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>

.zipcode-background{
	background:url("${imageHandler.g_popup_bg_search_zipcode}") no-repeat;
	font-family: "나눔고딕", "돋움", Arial Unicode MS, sans-serif;
	font-size:"12px";
	border:0px solid #ccc;
	width: 678px;
 	height: 373px;
 	padding-top:80px;
 	padding-left:20px;
}
s
.zipcode-title{
	margin-top: -47px;
	margin-right:10px;
}
.zipcode-search-box{
	margin-top:50px;
}
.zipcode-search-data{
	padding-top:500px;
}
.select-zipcode{
	width:400px;
}


.zipcode-left{
	background-color: #eceff8;
	color: #444444;
	text-shadow: 1px 1px 1px #88a0b4;
	font-size: 14px;
	font-weight: bold;
	width: 130px;
	border:1px solid #d4d4d4;
	vertical-align: middle;
	text-align: center;
}
.zipcode-right{
	vertical-align: middle;
	padding-top:3px;
	padding-left: 10px;
	border:1px solid #d4d4d4;
}

.zipcode-table{
	border-top:2px solid #d4d4d4;
}
.zipcode-input-box{
	border:1px solid #d4d4d4;
}
.zipcode-cancel{
	background: url( '${imageHandler.g_popup_bt_popup}') no-repeat;
	width: 117px;
	height: 40px;
	color: #005292;
	font-size: 16px;
	text-align: center;
	vertical-align: middle;
	font-weight: bold;
	padding-top: 7px;
	margin-left: 5px;
}
</style>

<script type="text/javascript">
$(function(){
	$('.select-zipcode').each( function(){
		var input = $(this);
		input.autocomplete({
			serviceUrl : '${contextPath}/ajax.do', minChars: 1,
			params:{ fid:'${funcHandler.funcZipcodeZibunAjaxSearch.id}', field:'zipcodeId'},
			onSelect: function( value, data){ 
				// 병원 정보를 가져온후 해당 정보를 채운다.
				getZipcodeInfo( input.attr('no'), data);
			}
		});
	});
});

function getZipcodeInfo( index, zipcodeId){
	
	// get Hospital Info Json
	var url = '${contextPath}/___/zipcode/json/'+zipcodeId;
	$.getJSON( url, function( data){
		
	});
}

$('.zipcode-close').click( function(){
	$.unblockUI();
	return false;
}).css('cursor', 'pointer');

</script>

<div class="zipcode-background">
	<div class="zipcode-title">
		<img src="${imageHandler.g_popup_icon_close}" align="right" alt="close this popup" class="zipcode-close">
	</div>
	<div class="zipcode-search-box">
		<table>
			<tr>
				<td class="header" width="145px" height="40px">우편번호검색</td>
				<td class="value bg-other" height="40px"><input type="text" class="select-zipcode" no="1" tabindex="1"></td>
			</tr>
		</table>
	</div>
	<div class="zipcode-search-data"></div>
</div>
