<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${body_page == null && dispatcher.function != null }">
	<c:set var="body_page" value="${dispatcher.function.view}"/>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<!-- <html> -->
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/WEB-INF/jsp/givus/header.jsp" %> 

<body>
<jsp:include page="/WEB-INF/jsp/givus/givus_header.jsp"/>

<div class="body_wrapper" style="height:400px;">

<table style="margin:0 auto;">
	<tr>
		<td style="text-align:center;padding-top:50px;">
			<img src=" ${imageHandler.g_exception_givus_error}" alt="An error was occured!">
		</td>
	</tr>
	<tr>
		<td style="text-align:center;height:100px;">
			<span class="error-message">${exception.message}</span>
			<a href="javascript:history.back();">
				<span style="padding:3px;border: 1px solid #cbcbcb;cursor:pointer;">뒤로가기</span>
			</a>
			<a href="${contextPath}/index.jsp">
				<span style="padding:3px;border: 1px solid #cbcbcb;cursor:pointer;">메인으로 가기</span>
			</a>
		</td>
	</tr>
</table>
</div>

<%@ include file="/WEB-INF/jsp/givus/givus_footer.jsp" %> 

</body>
</html> 