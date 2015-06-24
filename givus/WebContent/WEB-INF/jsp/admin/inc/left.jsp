<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(sub.equals("hospital")){
%>
<ul class="nav nav-sidebar">
  <li class="active"><a href="#">병원목록</a></li>
  
</ul>
<ul class="nav nav-sidebar">
  
</ul>
<ul class="nav nav-sidebar">
  
</ul>
<%} else if( sub.equals("ranking")) {%>

<ul class="nav nav-sidebar">
  <li class="active"><a href="#">랭킹</a></li>
  
</ul>
<%} else if( sub.equals("board")) {%>
<ul class="nav nav-sidebar">
  <li class="active"><a href="#">게시판</a></li>
  
</ul>
<% }%>