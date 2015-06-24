<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<link type="text/css" href="${contextPath}/style/base.css" rel="stylesheet"/>
</head>
<body>
<table align="center" style="width:100%;">
	<tr>
		<td style="text-align:center;padding-top:50px;">
			<img src=" ${contextPath}/images/result_error.jpg"><span class="error-message">${exception.message}</span>
		</td>
	</tr>
	<tr>
		<td style="text-align:center;">
			<a href="javascript:history.back();">
				<span style="padding:3px;border: 1px solid #cbcbcb;cursor:pointer;">뒤로가기</span>
			</a>
		</td>
	</tr>
</table>
</body>
</html> 