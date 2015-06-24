<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userType = um.getUserType();
%>
<div class="mypage_submenu">
	<ul>
		<li><a href="${contextPath }/___/renew/mypage/board/0"><strong>내가 쓴 게시물</strong></a></li>
		<li class=""><a href="${contextPath }/___/renew/mypage/myinfo"><strong>기본정보 변경</strong></a></li>
		<%
			if(userType.equals("H")){
		%>
		<li class=""><a href="${contextPath }/___/renew/mypage/myhinfo"><strong>병원정보 변경</strong></a></li>
		<%
			}
		%>
		<li><a href="${contextPath }/___/renew/mypage/chpass"><strong>비밀번호 변경</strong></a></li>
		<%
			if(userType.equals("H")){
		%>
		<li><a href="${contextPath }/___/renew/mypage/myhintro"><strong>병원소개 변경</strong></a></li>
		<li><a href="${contextPath }/___/renew/mypage/myhprice"><strong>가격정보 변경</strong></a></li>
		<%
			}
		%>		
		<li><a href="${contextPath }/___/renew/mypage/contact"><strong>일대일 문의내역</strong></a></li>
		<li class="last"><a href="${contextPath }/___/renew/mypage/withraw"><strong>회원탈퇴</strong></a></li>
	</ul>
</div>