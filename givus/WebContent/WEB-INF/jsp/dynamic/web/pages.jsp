<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<%@ include file="header.jsp" %> 
<%@ include file="css.jsp" %> 
<body>

<c:forEach var="dispatcher" items="${dispatchers}" varStatus="dispatcherLoop">
	<c:set var="dispatcher" value="${dispatcher}" scope="request"/>
	
	<c:if test="${dispatcher.function.headerPage != null}">
		<jsp:include page="/WEB-INF/jsp/${dispatcher.function.headerPage}.jsp"/>
	</c:if>
	
	<jsp:include page="/WEB-INF/jsp/${dispatcher.function.view}.jsp"/>
	
	<c:if test="${dispatcher.function.footerPage != null}">
		<jsp:include page="/WEB-INF/jsp/${dispatcher.function.footerPage}.jsp"/>
	</c:if>
</c:forEach>

</body>
</html>