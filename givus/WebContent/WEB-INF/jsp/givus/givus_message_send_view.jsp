<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.message-send-view{
	width:380px;
	padding:0px;
}
.message-send-view-title{
	padding:3px;
	border-bottom:1px solid #d4d4d4;
	background-color: #fafbfc;
	background: url("${imageHandler.g_right_msg_contents_title_bg}");
	color: #444444;
	font-weight:bold;
}
.message-send-view-head{
	text-align:center;
	width:80px;
	height:22px;
	font-weight:bold;
}
.message-send-view-value{
	text-align:left;
}
.message-send-view-contents{
	line-height:170%;
	margin-top:10px;
	padding-left:15px;
	width:320px;
	text-align:left;
}
</style>
<div class="message-send-view">
	<div class="message-send-view-title">
		<table>
			<tr>
				<td class="message-send-view-head">받는사람</td>
				<td class="message-send-view-value">
				<c:forEach var="receiveInfo" items="${receiveInfos}" varStatus="count">
					<c:if test="${count.count > 1}">, </c:if>
					${receiveInfo.receiveUserName}
				</c:forEach>
				</td>
			</tr>
			<tr>
				<td class="message-send-view-head">보낸시간</td>
				<td class="message-send-view-value">${data.renderedData.createDate}</td>
			</tr>
		</table>
	</div>
	<div class="message-send-view-contents">
		${data.renderedData.message}
	</div>
</div>
