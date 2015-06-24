<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<style>
.posting-interview-header, .posting-interview-contents{
	width:650px;
	line-height:170%;
}
.posting-interview-title{
	width:650px;
	height:25px;
	border-bottom:2px solid #ccc;
	margin-bottom:10px;
}
.posting-interview-header{
	padding:5px;
}
.posting-interview-contents{
	line-height:200%;
	margin-top:10px;
	border-top: 1px solid #ccc;
	padding-top:20px;
}
.posting-interview-header .header{
	border-left: 1px solid #ccc;
	padding:10px;
}
.posting-interview-header .title{
	width: 100px;
	font-weight: bold;
	text-align: center;
}
.posting-interview-header .subject{
	font-weight: bold;
	font-size:14px;
	text-align:left;
}
.posting-interview-header .createDate{
	font-size:11px;
	text-align:left;
}
.posting-interview-header .count{
	font-size:12px;
	text-align:left;
}
.posting-interview-header .creator{
	font-size:12px;
	text-align:right;
}
</style>

<div class="posting-interview-title">
	<img src="${imageHandler.g_hospitalpr_title_detail}">
</div>
<table class="posting-interview-header">
<tr>
	<td class="title">병원인터뷰</td>
	<td>
		<div class="header">
			<div class="subject">${dispatcher.data.subject}</div>
			<div class="createDate">${dispatcher.data.renderedData.createDate}</div>
			<div class="count">
				<img src="${imageHandler.g_hospital_view}"> <span>${dispatcher.data.viewCount}</span>
				<img src="${imageHandler.g_hospital_good}"> <span>${dispatcher.data.recommendCount}</span>
			
			</div>
			<div class="creator">${dispatcher.data.renderedData.creator}</div>
		</div>		
	</td>
</tr>
</table>
<div class="posting-interview-contents">
	${dispatcher.data.contents}
</div>