<%@page import="dynamic.web.util.MessageHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%-- 상단 공통부분 --%>
 <script>
 $(function(){
	 $('.menu ul li').mouseenter(function(e){
		 $('.menu ul li').removeClass('on');
		 $(this).addClass('on');
	 });
	 $('.menu ul li').mouseleave(function(e){		 
		 if(!$(this).hasClass('sub')){
			 $(this).removeClass('on'); 
		 }		 
	 });
 });
 </script>
 <%-- 상단 --%>
 <div class="mask"></div>
 <div class="top_bg">
	<div class="site_top">
		<div class="left site_top_logo">
			<a href="${contextPath }/___/renew/main"><img src="${contextPath }/img/common/logo.png" alt="GIVUS 성형외과 선택의 기준 ranking"></a>
		</div>
		<div class="t_srch right">
			<div class="search_bg left">
				<input type="text" class="srch_input">
				<img alt="" src="${contextPath }/img/common/search_icon.png" class="search_icon">
			</div>
			<div class="left">				
			<%			
				// include file um 변수가져온것
				if(um.getEmail() != null ){
			%>
					<a href="${contextPath }/___/renew/logout"><img src="${contextPath }/img/common/logout_btn.png" alt="로그아웃"></a>
			<%
				}else{
			%>					
					<a href="${contextPath }/___/renew/login"><img src="${contextPath }/img/common/login_btn.png" alt="로그인"></a>
			<%
				}
			%>
			</div>
		</div>
	</div>
</div>
<%-- 메뉴들 --%>
<div class="menu_wrap">	
	<div class="menu">
		<ul>
			<li class="m1"><a href="${contextPath }/___/renew/rank100">Top 100</a></li>
			<li class="m2"><a href="${contextPath }/___/renew/compare">성형비용비교</a></li>
			<li class="m3"><a href="${contextPath }/___/renew/news/list">성형뉴스</a></li>
			<li class="m4"><a href="${contextPath }/___/renew/board/attendance">게시판</a></li>			
			<li class="m6"><a href="${contextPath }/___/renew/intro/ranking">순위방식</a></li>
			<%			
				if(um.getEmail() != null){
					if(um.getUserType().equals("G")){
			%>
				<li class="m7"><a href="${contextPath }/___/renew/mypage/board/0">마이페이지</a></li>
			<%		
					}else if(um.getUserType().equals("H")){
						String status = um.getHospitalAccepted();
						if(status.equals("A")){
			%>
				<li class="m7"><a href="${contextPath }/___/renew/myhospital/myinfo">병원페이지</a></li>
			<%
						}else if(status.equals("W")){
			%>
				<li class="m7"><a href="${contextPath }/___/renew/mypage/board/0">마이페이지</a></li>
			<%
							// 미승인, 대기중
						}else if(status.equals("C")){
							// 승인거부
			%>
				<li class="m7"><a href="${contextPath }/___/renew/mypage/board/0">마이페이지</a></li>
			<%
						}
					}
				}else{
			%>
				<li class="m7"><a href="javascript:alert('<%=MessageHandler.getMessage("posting.msg.recommend_needlogin")%>')">마이페이지</a></li>
			<%
				}
			%>
						
		</ul>
	</div>
</div>