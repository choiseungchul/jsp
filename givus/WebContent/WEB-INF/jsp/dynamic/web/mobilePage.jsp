<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<%@ include file="mobileHeader.jsp" %> 
<body>
<div data-role="page">
<div data-role="header">
	<h1>신신화학공업(주)</h1>
</div>
<c:if test="${dispatcher.function.headerPage != null}">
	<jsp:include page="/WEB-INF/jsp/${dispatcher.function.headerPage}.jsp"/>
</c:if>

<!-- <br/>  -->

<jsp:include page="/WEB-INF/jsp/${dispatcher.function.view}.jsp"/>

<!-- <br/>  -->
<c:if test="${dispatcher.function.footerPage != null}">
	<jsp:include page="/WEB-INF/jsp/${dispatcher.function.footerPage}.jsp"/>
</c:if>
</div>
</body>
</html>