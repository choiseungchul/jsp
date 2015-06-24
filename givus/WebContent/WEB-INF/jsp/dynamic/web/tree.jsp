<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- treeview --%>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/treeview/jquery.cookie.js"></script>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/treeview/jquery.treeview.js"></script>
<link href="${contextPath}/script/jqueryui/plugin/treeview/jquery.treeview.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/script/jqueryui/plugin/treeview/screen.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	$(function() {
		$("#tree").treeview({
			collapsed: true,
			animated: "medium",
			control:"#sidetreecontrol",
			persist: "location"
		});
	})
</script>

<ul id="tree">
	${dispatcher.html}
</ul>