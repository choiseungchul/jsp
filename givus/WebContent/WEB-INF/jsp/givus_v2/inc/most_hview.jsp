<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<HashMap<String, Object>> datas = (List<HashMap<String, Object>>)request.getAttribute("most");
%>
<script type="text/javascript">
$(document).ready(function(){
	// 슬라이드 작동
	$('.mh_img_cont_ul').width(216 * 3);
	
	$('.mh_nav_btn a').click(function(){
		$('.mh_nav_btn a').removeClass('on');
		$(this).addClass('on');
		
		var idx = $('.mh_nav_btn a').index(this);
		$('.mh_img_cont_ul').stop(true,true).animate({left : -(216 * idx) + 'px'}, 300, function(){
			
		});
	});
	
	
});

$(function(){
	var speed = 500;
	var autoInterval = 5000;
	
	timer = setInterval(function(){
		
		var curr = parseInt($('.mh_img_cont_ul').css('left').replace('px',''))/216;
		
		if(curr > -2){
			curr--;
			$('.mh_img_cont_ul').stop(true,true).animate({left : (216 * curr) + 'px'}, speed, function(){
				$('.mh_nav_btn a').removeClass('on');
				$('.mh_nav_btn a').eq(curr).addClass('on');
			});
		}else{
			$('.mh_img_cont_ul').stop(true,true).animate({left : '0px'}, speed, function(){
				$('.mh_nav_btn a').removeClass('on');
				$('.mh_nav_btn a').eq(curr).addClass('on');
			});
		}
	}, autoInterval);
	
});
</script>
<div class="mh_title">이 병원을 본 사람들이 많이 본 병원</div>
<div class="mh_cont">
	<div class="mh_nav_btn">
		<a href="javascript:" class="on"></a>
		<a href="javascript:" class=""></a>
		<a href="javascript:" class=""></a>
	</div>
	<div class="mh_img_cont">
		<ul class="mh_img_cont_ul">
			<%
				for (int i = 0 ; i < datas.size(); i++){
			%>
			<li>
				<div><a href="${contextPath }/___/renew/hospital/info/<%=datas.get(i).get("id")%>"><img src="${contextPath}/___/file/get/<%=datas.get(i).get("thumb_id") == null ? request.getContextPath() + "/img/no_img.png" : datas.get(i).get("thumb_id") %>" ></a></div>
				<div class="mh_name"><a href="${contextPath }/___/renew/hospital/info/<%=datas.get(i).get("id")%>"><%=datas.get(i).get("name") %></a></div>				
			</li>
			<% } %>
		</ul>
	</div>
</div>