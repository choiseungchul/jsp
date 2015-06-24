<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.ranking-portlet{
	height:340px;
	width:337px;
	margin-left:30px;
	margin-top:10px;
	border-top:1px solid #ccc;
	padding-top: 3px;
}
.ranking-portlet-title{
	width:335px;
	height:30px;
	text-align:center;
	padding-top:10px;
	border: 1px solid #DBDEE6;
	background: #ECEFF8;
}
.ranking-portlet-title > span{
	font-weight: bold;
}
.ranking-portlet-left{
	width:104px;
	float:left;
	border-left: 1px solid #CCCCCC;
	border-right: 1px solid #CCCCCC;
}
.ranking-type-list, .ranking-subtype-list{
	list-style:none;
	padding:0px;
	margin:0px;
}
.ranking-portlet-right{
	width:229px;
	height:364px;
	float:left;
	border-left: 1px solid #CCCCCC;
	border-right: 1px solid #CCCCCC;
	
	
	border-bottom: 1px solid #CCCCCC;
}

.ranking-type-list > li{
	border-bottom: 1px solid #CCCCCC;
	background-color: #FBFCFC;
	padding:5px;
	cursor: pointer;
}
.ranking-subtype-list > li{
	padding-left:10px;
}
.ranking-portlet li{
	line-height:170%;
}
.ranking-hospital-list{
	list-style:none;
	margin-top:20px;
	margin-left:20px;
}
.ranking-subtype-list > li{
}
.ranking-hospital-list > li{
	width:180px;
	height:24px;
	margin-top:3px;
	border-bottom: 1px solid #CCCCCC;
}
.ranking-type-selected {
	border: 1px solid #fff;
	background-color: #fff;
	font-weight: bold;
}
.ranking-portlet-right .table-nav-div{
	width:200px;
	text-align: right;
}
</style>
<script>
$(function(){
	$('.ranking-type-list li[rankingType]').click(function(){
		var rankingType = $(this).attr('rankingType');
		var rankingLocationCode = $(this).attr('rankingLocationCode');
		var rankingPartCode = $(this).attr('rankingPartCode');
		var url = '${contextPath}/___/ranking/getRecent/' + rankingType;
		if( rankingLocationCode){
			url += '/'+rankingLocationCode;
		}
		if( rankingPartCode){
			url += '/'+rankingPartCode;
		}
		$('.ranking-portlet-right').load( url, function( responseText){
		});
		$('.ranking-type-list li').removeClass('ranking-type-selected');
		$(this).addClass('ranking-type-selected');
	})[0].click();
})
</script>
<div class="ranking-portlet">
	<div class="ranking-portlet-title"><span>GIVUS 금주의 순위</span> [ <fmt:formatDate value="${rankingModel.startDate}"/> ~ <fmt:formatDate value="${rankingModel.endDate}"/> ]</div>
	<div class="ranking-portlet-left">
		<ul class="ranking-type-list">
			<li rankingType="A">전국 TOP 100</li>
			<li rankingType="B">서울 TOP 50</li>
			<li>광역 TOP 10
				<ul class="ranking-subtype-list">
					<li rankingType="C" rankingLocationCode="B">- 인천</li>
					<li rankingType="C" rankingLocationCode="C">- 대구</li>
					<li rankingType="C" rankingLocationCode="D">- 대전</li>
					<li rankingType="C" rankingLocationCode="E">- 광주</li>
					<li rankingType="C" rankingLocationCode="F">- 울산</li>
					<li rankingType="C" rankingLocationCode="G">- 부산</li>
				</ul>
			</li>
			<li>부위 TOP 10
				<ul class="ranking-subtype-list">
					<li rankingType="D" rankingLocationCode="Z" rankingPartCode="A">- 눈</li>
					<li rankingType="D" rankingLocationCode="Z" rankingPartCode="B">- 코</li>
					<li rankingType="D" rankingLocationCode="Z" rankingPartCode="C">- 안면윤곽</li>
					<li rankingType="D" rankingLocationCode="Z" rankingPartCode="D">- 가슴</li>
					<li rankingType="D" rankingLocationCode="Z" rankingPartCode="E">- 체형</li>
					<li rankingType="D" rankingLocationCode="Z" rankingPartCode="F">- 쁘띠</li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="ranking-portlet-right">
	</div>
	</div>
</div>