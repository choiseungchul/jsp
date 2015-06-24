<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<%-- ///////////////////// JQUERY  ///////////////////// --%>
	<%@ include file="jqueryui.jsp" %> 
	<%-- ///////////////////// GOOGLE  ///////////////////// --%>
<!-- <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false&language=ko"></script> -->
	<%-- ///////////////////// BOOTSTRAP  ///////////////////// --%>
	<script src="${contextPath}/plugin/bootstrap-2.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${contextPath}/plugin/bootstrap-2.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="${contextPath}/plugin/bootstrap-2.3.2/css/bootstrap-responsive.min.css">
	<style><%-- ///////////////////// BOOTSTRAP STYLE PATCH ///////////////////// --%>
	ul{ margin:0px;}
	body {line-height: 100%;}
	p{margin: 0px;}
	</style>
	<%-- ///////////////////// DYNAMIC ///////////////////// --%>
	<link type="text/css" href="${contextPath}/style/base.css" rel="stylesheet"/>
	<script type="text/javascript" src="${contextPath}/script/dynamic.js"></script>
	<script type="text/javascript" src="${contextPath}/style/styleScript.js"></script>
	<jsp:include page="/WEB-INF/jsp/dynamic/web/script.jsp"/>
	<title>${msgHandler["window.title"]}</title>
</head>