<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%-- 푸터 공통부분 --%>
 
 <div class="foot_bg clear">
 	<div class="footer">
 		<div class="company left">
			<ul>
				<li><a href="${contextPath }/___/renew/intro/aboutus">About us</a></li>
				<li>
				<%
					if(um.getEmail() != null){
				%>
				<a href="${contextPath }/___/renew/hospital/add1" class="">병원등록</a>
				<% }else { %>
				<a href="javascript:alert('로그인이 필요합니다.')" class="">병원등록</a>
				<% } %>
				</li>				
				<li><a href="${contextPath }/___/renew/board/15">고객센터</a></li>
				<li><a href="">제휴문의</a></li>								
				<li><a href="${contextPath }/___/renew/privacy">개인정보보호정책</a></li>
				<li><a href="${contextPath }/___/renew/agreement">서비스이용약관</a></li>
			</ul>
		</div>
		<div class="right sns_link">
			<a href="https://www.facebook.com/pages/GIVUS/441206982691214" target="_blank"><img src="${contextPath }/img/common/fb_icon.png" alt="페이스북"></a>
		</div>
 	</div>
</div>
<%
%>
