<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			<!-- <a href="javascript:history.back();">
				<span style="padding:3px;border: 1px solid #cbcbcb;cursor:pointer;">뒤로가기</span>
			</a> -->
			<%-- <a href="${contextPath}/index.jsp">
				<span style="padding:3px;border: 1px solid #cbcbcb;cursor:pointer;">메인으로 가기</span>
			</a> --%> 
		</td>
	</tr>
</table>
</div>