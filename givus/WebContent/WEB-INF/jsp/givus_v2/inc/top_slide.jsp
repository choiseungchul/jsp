<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${contextPath }/script/jqueryui/plugin/jquery.BxSlider.min.js"></script>
<script type="text/javascript" src="${contextPath }/script/jqueryui/plugin/jquery.corner.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var slider = $('.top_slide_ul').bxSlider({
		auto: false,
		speed : 400,
		pause : 10000,
		controls :false,
		pager:false,
		infiniteLoop : false
	});	
	
	$('.menu ul li').mouseenter(function(){
		var idx = $('.menu ul li').index(this);
		
		slider.goToSlide(idx);
	});
	
});
</script>
<div class="top_slide_bg">
	<div class="top_slide">
		<ul class="top_slide_ul">
			<li><img src="${contextPath }/img/slide/slide1.png"></li>
			<li><img src="${contextPath }/img/slide/slide2.png"></li>
			<li><img src="${contextPath }/img/slide/slide3.png"></li>
			<li><img src="${contextPath }/img/slide/slide4.png"></li>
			<li><img src="${contextPath }/img/slide/slide5.png"></li>				
		</ul>
	</div>
</div>