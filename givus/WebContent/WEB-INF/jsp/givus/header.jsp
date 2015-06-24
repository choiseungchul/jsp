<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>

	<%-- GIVUS PAGE를 위한 header --%>
	<%-- ///////////////////// JQUERY  ///////////////////// --%>
	<%@ include file="/WEB-INF/jsp/dynamic/web/jqueryui.jsp" %> 
	<%-- ///////////////////// GOOGLE  ///////////////////// --%>
<!-- <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false&language=ko"></script> -->
	<%-- ///////////////////// BOOTSTRAP  ///////////////////// --%>
	<%--script src="${contextPath}/plugin/bootstrap-2.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${contextPath}/plugin/bootstrap-2.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="${contextPath}/plugin/bootstrap-2.3.2/css/bootstrap-responsive.min.css"--%>
	<%-- ///////////////////// DYNAMIC ///////////////////// --%>
	<link type="text/css" href="${contextPath}/style/base.css" rel="stylesheet"/>
	<script type="text/javascript" src="${contextPath}/script/dynamic.js"></script>
	<script type="text/javascript" src="${contextPath}/script/givus/givus.js"></script>
	<script type="text/javascript" src="${contextPath}/style/styleScript.js"></script>
	<jsp:include page="/WEB-INF/jsp/dynamic/web/script.jsp"/>
	
	<%-- <script type="text/javascript" src="${contextPath}/script/placeholders/placeholders.min.js"></script> --%>
	<script type="text/javascript" src="${contextPath}/script/placeholders/placeholders.jquery.min.js"></script>
	<title>${msgHandler["window.title"]}</title>

	<meta property="fb:admins" content="givus@givus.co.kr" />
	<meta property="fb:app_id" content="724203754269433" />

	<meta property="og:title" content="GIVUS TOP 100 - 성형외과 선택의 기준"/> 
	<meta property="og:type" content="website"/> 
	<meta property="og:image" content="http://www.givus.co.kr${imageHandler.g_bottom_logo}"/> 
	<meta property="og:description" content="국내 전국 성형외과들의 위치, 전문의 수, 마취과 여부, 서비스 퀄리티, 전문의 평가등 이해하기 위한 정보들을 제공합니다. ※ 각 성형외과 홈페이지에 제공하는 정보와 공식적인 통계자료를 기준으로 기재합니다."/> 
	<meta property="og:site_name" content="GIVUS TOP 100"/>

</head>