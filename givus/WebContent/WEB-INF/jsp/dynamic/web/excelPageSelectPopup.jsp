<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>

<!-- title -->
<div class="property-title-div">
	<span class="table-title">저장할 페이지 선택</span> 
</div>

<form:form id="form" enctype="multipart/form-data">
<input type="hidden" name="action" value="download"/>
<div class="property-view" style="margin-top:10px;">
	<table class="property-list" style="padding-top:0px;margin-top:0px;">
		<tr>
			<td class="property-title-td" style="width:80px;"><span class="property-title">페이지범위</span></td>
			<td class="property-value-td">
				<input class="input-radio" type="radio" name="type" value="C" id="C" checked> <label for="C">현재페이지</label>
				<input class="input-radio" type="radio" name="type" value="A" id="A"> <label for="A">전체페이지</label>
				<input class="input-radio" type="radio" name="type" value="S" id="S"> <label for="S">페이지지정</label>
			</td>
		</tr>
		<tr>
			<td class="property-title-td" style="width:80px;"><span class="property-title">페이지지정</span></td>
			<td class="property-value-td">
				시작페이지 <input type="text" size="10" id="startPage" name="startPage" class="input-text"/> ~ 끝페이지 <input type="text" size="10" id="endPage" name="endPage" class="input-text"/> 
			</td>
		</tr>
	</table>
</div>
<div style="text-align:center;margin-top:10px;">
	<span class="button button-text button-submit">저장</span>
	<span class="button button-text" onclick="javascript:self.close();">닫기</span>
</div>
</form:form>

<script>
$(function(){
	$(".input-radio").bind('click', function(){
		var checkedVal = $(".input-radio:checked").val();
		if( checkedVal == 'S'){
			$('#startPage').attr('disabled', false).removeClass('disabled');
			$('#endPage').attr('disabled', false).removeClass('disabled');
		}else{
			$('#startPage').attr('disabled', true).addClass('disabled');
			$('#endPage').attr('disabled', true).addClass('disabled');
		}
	});
	$('.input-radio:checked').click();
	$('.button-submit').bind('click', function(){
		var url = dynamic.url.removeParam( '${serviceUrl}', 'action');
		var fid = dynamic.url.getParam( url, 'fid');
		var PARAM_PAGENO = fid + "_pageno";
		var type = $('.input-radio:checked').val();
		var startPageNo = -1, endPageNo = -1;
		if( type == 'S'){
			url = dynamic.url.removeParam( url, 'pageno');
			startPageNo = $('#startPage').val();
			endPageNo = $('#endPage').val();
			if( startPageNo > endPageNo){
				alert('시작페이지 숫자를 끝페이지 숫자보다 작은 값을 입력하세요.');
				return;
			}
			url += '&'+PARAM_PAGENO+'='+ startPageNo + '&endpageno=' + endPageNo;
		}else if( type == 'A'){
			url = dynamic.url.removeParam( url, PARAM_PAGENO);
			url += '&' + PARAM_PAGENO + '=0';
		}else if( type == 'C'){
			var pageno = dynamic.url.getParam( url, PARAM_PAGENO);
			if( !pageno){
				url += '&' + PARAM_PAGENO + '=1'; // 메뉴를 클릭하고 나서 첫페이지 화면에는 pageno 파라미터가 존재하지 않는다.
			}
		}
		opener.location.href = url;
		alert( '엑셀파일 다운로드중입니다. 잠시 기다려 주세요.\n다운로드가 완료되면 확인을 클릭해주세요.');
		self.close();
	});
});
</script>