<%@page import="java.text.DecimalFormat" %>
<%@page import="kr.co.zadusoft.contents.util.RelativeDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	
	$('.visual').animate({
		height: 368+'px'
	},1000, function(){
		$('.current_info').fadeIn(400, function(){
			$('.link_icons').fadeIn(400);
		});
	});
	
	$('.ranklist').load('${contextPath}/___/renew/tile/rankbox');
});
</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	
	<div class="content">		
		<%
		
			List<HashMap<String, Object>> hospital100 = (List<HashMap<String, Object>>)request.getAttribute("hospital100");
			
			int pnum = (Integer)request.getAttribute("p");
			int totalCnt = (Integer)request.getAttribute("total");
			int pageCount = 10;
			int pagePerCount = 10;
			
		%>
		
		<div class="hospitallist left">
			<h2>Top 100 병원리스트 <a href="" class="rank_all_link">모든 순위보기&nbsp;&nbsp;▶</a></h2>
			<div class="hospitals">
				<ul>
					<%
						for(int i = 0 ; i < hospital100.size(); i++){
							
							HashMap<String, Object> data = hospital100.get(i);
					%>
					<li>
						<div class="left img_cont">
							<div class="hospital_counts">
								<p>주요수술1 : <%=data.get("mostOperation1") %></p>
								<p>주요수술2 : <%=data.get("mostOperation2") %></p>
								<p>전문의 : <%=data.get("specialistCount") %>명 / 마취과 : <%=data.get("anestheticCount") %>명</p>
							</div>
							<!-- 
							<img alt="" src="/___/file/get/<%=data.get("fid") %>" class="hos_thumb">
							 -->
							 <%
							 	String src = "";
							 
							 	if(data.get("thumb") == null){
							 		src ="/images/givus/ranking/no_image_thumb_214.png";
							 	}else{
							 		src="/___/file/get/" + data.get("thumb");
							 	}
							 %>
							 <img alt="" src="<%=src %>" class="hos_thumb">
						</div>
						<div class="left hos_intro">
							<div class="hos_title">
								<div class="left">
									<span class="hos_ranknum"><%=(pnum * 10) + (i+1) %></span>
								</div>
								<div class="left hos_name">
									<h5><%=data.get("name") %></h5>
									<p><%=data.get("address") %></p>
								</div>
							</div><!-- hos_title -->
							<div class="hos_desc clear">
								<pre><%=data.get("introduction") %></pre>
							</div>
						</div>
						<!-- 로그인전 -->
						<div class="notlogin clear">
							<img alt="" src="${contextPath }/img/hospital/lock_icon.png"><%=data.get("name") %>에서 제공하는 더 많은 정보와, 수술별 가격을 제공받으려면 가입해 주시기 바랍니다.
						</div>
					</li>
					<%} %>
				</ul>
			</div>
			
			<%
				if(totalCnt > pageCount){
					int pcount = (int)(totalCnt / pageCount) + 1;
					if(totalCnt %pageCount == 0) pcount--;
					
					int startIdx = pnum - ( pnum % pageCount);
					
					int ppcount = (int)(totalCnt / pageCount) / pagePerCount;			
			%>	
			<div class="page_navi pd60">
				<% if(startIdx+1 > pagePerCount) {
					int ltPnum = startIdx - pagePerCount;
					%>
				<a href="${contextPath }/___/renew/hospital/list?PN=<%=ltPnum %>" class="btn">&lt;&lt;</a>
				<% }
					int loop = pcount - (pnum);
					if(loop > pagePerCount) loop = pagePerCount;
					
					for( int a=startIdx ; a < startIdx + loop; a++){				
				%>	
				<%if(pnum == a){ %>	
				<a href="${contextPath }/___/renew/hospital/list?PN=<%=pnum %>" class="on"><%=pnum+1%></a>
				<%}else{ %>
				<a href="${contextPath }/___/renew/hospital/list?PN=<%=a %>"><%=a+1 %></a>
				<%}//else %>
				<% } %>
				<% if( startIdx+pagePerCount < pcount ) {
					int gtPnum = startIdx + pagePerCount;
				%>
				<a href="${contextPath }/___/renew/hospital/list?PN=<%=gtPnum %>" class="btn">&gt;&gt;</a>
				<%} %>
			</div>
			<%} else { %>
			<div class="page_navi pd60">
				<a href="javascript:" class="on">1</a>
			</div>
			<%} %>
			
		</div>
		<div class="hospital_aside left">
			<div class="ranklist mt81"></div>
		</div>
		
	</div><!-- content -->
	
</div>
</div><!-- wrap -->
<%@include file="../inc/footer.jsp"%>
</body>
</html>