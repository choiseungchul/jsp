<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
<%
	if(um.getEmail() == null){
%>
alert('<%=MessageHandler.getMessage("posting.msg.recommend_needlogin")%>');
location.href = '${contextPath}/___/renew/login';
<%
	}
%>
</script>