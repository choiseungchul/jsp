<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${dispatcher.function.onlyViewPage == false}">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ include file="header.jsp" %> 
<%@ include file="css.jsp" %> 
<body>

<c:if test="${dispatcher.function.headerPage != null}">
	<jsp:include page="/WEB-INF/jsp/${dispatcher.function.headerPage}.jsp"/>
</c:if>

<!-- <br/>  -->

<jsp:include page="/WEB-INF/jsp/${dispatcher.function.view}.jsp"/>

<!-- <br/>  -->
<c:if test="${dispatcher.function.footerPage != null}">
	<jsp:include page="/WEB-INF/jsp/${dispatcher.function.footerPage}.jsp"/>
</c:if>
</body>
</html>
</c:if>
<c:if test="${dispatcher.function.onlyViewPage == true}">
	<jsp:include page="/WEB-INF/jsp/${dispatcher.function.view}.jsp"/>
</c:if>