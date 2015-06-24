<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- contextPath 가 필요한 css 를 정의한다. --%>
<style>
/* table */
.table-title, .portal-title, .calendar-title{
	font-weight: bold;
	background: url(${imageHandler.bullet_title}) left center no-repeat;
	padding-left: 15px;
}

.table-nodata, .portlet-nodata{
	width: 200px;
	height: 50px;
	padding-top:30px;
	background: url(${imageHandler.search}) left center no-repeat;
	text-align: left;
	padding-left: 50px; 
}
.button{
	background: url(${imageHandler.button_bullet}) 3px center no-repeat;
}
.notnull{
	width: 13px;
	background: url(${contextPath}/images/ico_essential.gif) right center no-repeat;
}
.sort_asc{
	background: url(${contextPath}/images/ref/bullet_arrow_down.png) left center no-repeat;
}
.sort_desc{
	background: url(${contextPath}/images/ref/bullet_arrow_up.png) left center no-repeat;
}
</style>