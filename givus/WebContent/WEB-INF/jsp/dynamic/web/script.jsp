<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<%@ page import="dynamic.web.func.*" %>
<script>
dynamic.constants = {
		CONTEXTPATH : '${pageContext.request.contextPath}'
};
</script>
<script>
$(document).ready(function(){ dynamic.init.init();});
</script>

