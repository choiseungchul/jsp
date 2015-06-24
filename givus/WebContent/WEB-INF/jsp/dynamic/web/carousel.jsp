<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${contextPath}/script/jqueryui/plugin/jquery.jcarousel.min.js"></script>

<div class="jcarousel">
	<ul>
		<c:forEach var="file" items="files">
		<li><img src="/___/file/get/${file.id}" width="600" height="400" alt=""></li>
		</c:forEach>
	</ul>
</div>