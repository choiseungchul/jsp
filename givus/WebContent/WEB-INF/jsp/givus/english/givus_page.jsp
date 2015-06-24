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
<script type="text/javascript">
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-49755305-1', 'givus.co.kr');
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');

</script>
<jsp:include page="/WEB-INF/jsp/givus/english/givus_header.jsp"/>

<div calss="body_wrapper">
<table style="margin:0 auto;">
	<tr>
		<%-- SIDE MENU LEFT --%>
		<td width="130" valign="top">
			
 
		</td>
		<td valign="top">
	<jsp:include page="/WEB-INF/jsp/givus/english/${body_page}.jsp"/>
		</td>
		<%-- SIDE MENU RIGHT --%>
		<td width="130" valign="top"><jsp:include page="/WEB-INF/jsp/givus/english/givus_sidebar_left.jsp"/></td>
	</tr>
</table>
</div>

<jsp:include page="/WEB-INF/jsp/givus/english/givus_footer.jsp"/>

</body>
</html>
