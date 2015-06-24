<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<style type="text/css">
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
}
.body_title_name {
	border: 1px solid #CCCCCC;
	background:url('${imageHandler.g_left_title_bg}') no-repeat;
	color: #FFFFFF;
	font-size: 15px;
	text-shadow: 1px 1px 1px #0C0C0C;
}
.body_title_desc {
	border: 0px solid #CCCCCC;
	color: #444444;
	font-size: 13px;
	padding-left: 25px; 
	font-weight: bold;
}

.outline_blue{
	width:978;
	border: 2px solid #cfcfcf;
	background: #e7eaf3;border-radius: 0px 10px 10px 0px;
}
.outline_gray{
	width:980;border-left: 2px solid #cfcfcf; background: #fafafa;
}

.header{
	text-align:center;
	font-weight:bold;
	font-size:13px;
	background: url('${imageHandler.g_price_bg_left}') center right repeat-y;
	border-right: 1px solid #ccc;
}

.header-white{
	text-align:center;
	font-weight:bold;
	font-size:13px;
	background-color:#FAFAFA;
	border-right: 1px solid #ccc;
}
.value{
	text-align:center;
	width:268px;
	padding:3px;
}
.bg-white, .bg-white-end{
	background-color:#FAFAFA;
}
.bg-white-end{
	border-right: none;
}
.bg-other, .bg-other-end{
}
.bg-other-end{
}
.hospital-info{
	width:215px;
	text-align:center;
	padding-top:10px;
	padding-bottom:10px;
	margin:0 auto;
}
.hospital-info .name{
	font-weight:bold;
	font-size:14px;
	color: #005EA6;
	height:54px;
	padding-top:10px;
	padding-left:40px;
}
.comment{
	font-weight:bold;
	font-size:14px;
	color: #636364;
}
.hospital-info .address{
	text-align:left;
	height:40px;
}
.hospital-info .tel{
	text-align:left;
	height:25px;
	padding-top:5px;
}
.hospital-info .ranking{
	font-size:13px;
	color: #266dad;
	text-align:left;
	padding-top:10px;
}
.ranking{
	font-size:13px;
	color: #266dad;
}
.delemeter{
	font-size:12px;
	color: #8d8f91;
}
.grade{
	font-size:13px;
	color: #c70000;
	font-weight: bold;
}
.count{
	font-size:12px;
	color: #666666;
}
.select-hospital{
	width:90%;
}

.price-list{
	list-style:none;
}
.price-list li{
	line-height:170%;
}
.price-name, .price-value{
	width:120px;
	float:left;
	height:25px;
	font-weight:bold;
	color: #005EA6;
}
.price-line{
	float:left;
	border-top: 1px dashed #CCCCCC;
	width:240px;
	height:5px;
	margin: 2px;
}
input, select{
	font-size: 12px;
	height: 20px;
	background-color: white;
	color: #454545;
	padding-left: 2px;
	padding-top: 2px;
	border: 1px solid #CCCCCC;
}
select{
	height:100%;
	padding:3px;
}
</style>
<script type="text/javascript">
$(function(){
	$('.select-hospital').each( function(){
		var input = $(this);
		input.autocomplete({
			serviceUrl : '${contextPath}/ajax.do', minChars: 1,
			params:{ fid:'${funcHandler.funcHospitalAjaxSearch.id}', field:'hospitalId'},
			onSelect: function( value, data){ 
				// 병원 정보를 가져온후 해당 정보를 채운다.
				getHospitalInfo( input.attr('no'), data);
			}
		});
	});
	
	<c:forEach var="hmodel" items="${hmodels}" varStatus="status">
		getHospitalInfo("${status.count}", "${hmodel.id}");
	</c:forEach>
});

function getHospitalInfo( index, hospitalId){
	// get Hospital Info Json
	var url = '${contextPath}/___/hospital/json/'+hospitalId;
	$.getJSON( url, function( data){
		
		// 데이터를 채운다.
		$('#hospital-info-'+index)
			.find('.name').html( '<a href="${contextPath}/___/p/hospital/' + hospitalId + '">' + data.name + '</a>').css('background', 'url(${contextPath}/images/givus/price/name_' + index + '.png) no-repeat').end()
			.find('.address').html( data.address).end()
			.find('.tel').html( '대표전화) '+ data.tel).end();
			
		if ( data.photo != null && data.photo > 0 ){
			$('#hospital-info-'+index)
				.find('.photo').html( '<a href="${contextPath}/___/p/hospital/' + hospitalId + '">' + '<img src="${contextPath}/___/file/get/'+ data.photo+ '" width="215" ></a>').end();
		}else{
			$('#hospital-info-'+index)
			.find('.photo').html( '<a href="${contextPath}/___/p/hospital/' + hospitalId + '">' + '<img src="${imageHandler.g_ranking_no_image_214}" width="215"></a>').end();
		}
			
		$('#ranking-' + index).html( '<span class="ranking">'+data.ranking + '위</span><span class="delemeter"> / </span><span class="grade">' + data.grade + '</span>');
		
		$('#mostOperation-' + index).html( data.mostOperation1);
		
		if( data.specialistCount && data.specialistCount > 0)
			$('#specialistCount-' + index).html( data.specialistCount + '명');
		if( data.anestheticCount && data.anestheticCount > 0)
			$('#anestheticCount-' + index).html( data.anestheticCount + '명');
		if( data.counselCount && data.counselCount > 0)
			$('#counselCount-' + index).html( data.counselCount + '여건');
		
		$('.price-index-' + index).remove();
		
		$.each( data.price, function( key, value){
			var ul = $("<ul>").addClass( 'price-list-'+ key).addClass('price-list').addClass('price-index-'+index);
			
			$.each( value, function ( key, value){
				var key = $('<div>').addClass('price-name').html( key);
				/* var value = $('<div>').addClass('price-value').html( value); */
				<c:choose>
				<c:when test="${userType ==null}">	var value = $('<div>').addClass('price-value').html( '<img src="${imageHandler.g_ranking_lock}">'); </c:when>
				<c:otherwise> var value = $('<div>').addClass('price-value').html( value); </c:otherwise>
				</c:choose>
				var li = $('<li>').append( key).append( value);
				ul.append(li);
			});
			var line = $('<div>').addClass('price-line');
			var liLine =  $('<li>').append(line);
			ul.append( liLine);
			$('#price-' + index).append( ul);
		});	 

		
	});
}
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<td class="path_info" align="left">
				성형정보 > 성형가격비교
			</td>
		</tr>
	</table>
	
	<table width="980" style="margin:auto;" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="145px" height="52px" class="body_title_name" align="center">성형 가격 비교</td>
			<td class="body_title_desc" align="left"><c:if test="${userType ==null}">로그인 후 </c:if>병원검색을 하시면 전체 시술부위에 대한 가격정보를 보실 수 있습니다. </td>
		</tr>

	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">

		<tr height="40px">
			<td>
				<div class="outline_blue">
				<table><tr>
					<td class="header" width="143px" height="40px">병원검색</td>
					<td class="value bg-other" height="40px"><input type="text" class="select-hospital" no="1" tabindex="1"></td>
					<td class="value bg-other"><input type="text" class="select-hospital" no="2" tabindex="2"></td>
					<td class="value bg-other-end"><input type="text" class="select-hospital" no="3" tabindex="3"></td>
				</tr></table>
				</div>
			</td>
		</tr>
		
		<tr height="330px">
			<td>
				<div class="outline_gray">
				<table><tr>
					<td class="header-white" width="143px" height="330px">병원보기</td>
					<td class="value bg-white" valign="top">
						<div id="hospital-info-1" class="hospital-info">
							<div class="name"></div>
							<div class="address"></div>
							<div class="tel"></div>
							<div class="photo">
							</div>
						</div>
					</td>
					<td class="value bg-white" valign="top">
						<div id="hospital-info-2" class="hospital-info">
							<div class="name"></div>
							<div class="address"></div>
							<div class="tel"></div>
							<div class="photo">
							</div>
						</div>
					</td>
					<td class="value bg-white-end" valign="top">
						<div id="hospital-info-3" class="hospital-info">
							<div class="name"></div>
							<div class="address"></div>
							<div class="tel"></div>
							<div class="photo">
							</div>
						</div>
					</td>
				</tr></table>
				</div>
			</td>
		</tr>
		<tr height="46px">
			<td>
				<div class="outline_blue">
				<table><tr>
					<td class="header" width="143px" height="46px">GIVUS RANKING</td>
					<td class="value bg-other"><div id="ranking-1" class="ranking"></div></td>
					<td class="value bg-other"><div id="ranking-2" class="ranking"></div></td>
					<td class="value bg-other-end"><div id="ranking-3" class="ranking"></div></td>
				</tr></table>
				</div>
			</td>
		</tr>
		
		<tr height="160px">
			<td>
				<div class="outline_gray">
				<table><tr>
					<td class="header-white" width="143px" height="40px">주요수술</td>
					<td class="value bg-white"><div id="mostOperation-1" class="count"></div></td>
					<td class="value bg-white"><div id="mostOperation-2" class="count"></div></td>
					<td class="value bg-white-end"><div id="mostOperation-3" class="count"></div></td>
				</tr>
				<tr>
					<td class="header-white" width="143px" height="2px"><img src="${imageHandler.g_price_line_h_mid_left}"></td>
					<td colspan="3"><img src="${imageHandler.g_price_line_h_mid_right}" align="middle"></td>
				</tr>
				<tr>
					<td class="header-white" width="143px" height="40px">성형외과 전문의</td>
					<td class="value bg-white"><div id="specialistCount-1" class="count"></div></td>
					<td class="value bg-white"><div id="specialistCount-2" class="count"></div></td>
					<td class="value bg-white-end"><div id="specialistCount-3" class="count"></div></td>
				</tr>
				<tr>
					<td class="header-white" width="143px" height="2px"><img src="${imageHandler.g_price_line_h_mid_left}"></td>
					<td colspan="3"><img src="${imageHandler.g_price_line_h_mid_right}" align="middle"></td>
				</tr>
				<tr>
					<td class="header-white" width="143px" height="40px">마취과 전문의</td>
					<td class="value bg-white"><div id="anestheticCount-1" class="count"></div></td>
					<td class="value bg-white"><div id="anestheticCount-2" class="count"></div></td>
					<td class="value bg-white-end"><div id="anestheticCount-3" class="count"></div></td>
				</tr>
				<tr>
					<td class="header-white" width="143px" height="2px"><img src="${imageHandler.g_price_line_h_mid_left}"></td>
					<td colspan="3"><img src="${imageHandler.g_price_line_h_mid_right}" align="middle"></td>
				</tr>
				<tr>
					<td class="header-white" width="143px" height="40px">온라인 상담건수</td>
					<td class="value bg-white"><div id="counselCount-1" class="count"></div></td>
					<td class="value bg-white"><div id="counselCount-2" class="count"></div></td>
					<td class="value bg-white-end"><div id="counselCount-3" class="count"></div></td>
				</tr></table>
				</div>
			</td>
		</tr>
		<tr height="800px">
			<td>
				<div class="outline_blue">
				<table><tr>
					<td class="header" width="143px" height="800px">가격</td>
					<td class="value bg-other">
						<div id="price-1"></div>
					</td>
					<td class="value bg-other">
						<div id="price-2"></div>
					</td>
					<td class="value bg-other-end">
						<div id="price-3"></div>
					</td>
				</tr></table>
				</div>
			</td>
		</tr>
		<tr height="80px">
			<td class="grade">※ 위 가격은 전화상담 및 인터뷰에 의한 가격이므로, 자세한 금액은 해당 병원으로 문의 부탁드립니다.</td>
		</tr>
	</table>


</td></tr></table>
