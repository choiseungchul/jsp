<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.text.DecimalFormat" %>
<%
	HashMap<String, Object> data = (HashMap<String, Object>)request.getAttribute("hos");
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	var slide;
	$('.ranklist').load('${contextPath}/___/renew/tile/rankbox');
	$('.most_view_hos').load('${contextPath}/___/renew/hospital/mostview/<%=data.get("id")%>');
	
	if(!Browser.ie7){
		$('.h_t_slide').corner('keep 5px');	
	}
	
	
	$('.h_t_slide_ul li').mouseenter(function(){
		$('.h_t_slide_ul li').removeClass('on');
		$(this).addClass('on');
	});
	
	$('.h_t_slide_ul li img').click(function(){
		var src = $(this).attr('src');
		$('.h_thumb img').attr('src', src);
	});
});

function showPickupService(){
	$('.pickup_service_content').show();
}
function closePickupService(){
	$('.pickup_service_content').hide();
}

</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<!-- 서브 타이틀 -->
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title hosinfo_top">		
		<h1>Top 100 병원정보</h1>	
		<div class="sub_page_navi hosinfo_top">
			<ul>
				<li><a href="#">Top 100</a></li>
				<li>&gt;</li>
				<li><a href="#">Top 100 병원리스트</a></li>
				<li>&gt;</li>
				<li><a href="#"><%=data.get("name") %>성형외과</a></li>		
			</ul>
		</div>
	</div>
	
	<div class="content">
		<div class="hospital_cont left">			
			<div class="hospital_infomation clear">
				<div class="h_name"><%=data.get("name") %>성형외과</div>
				<div class="h_info">
					<div class="left hbox">
						<div class="h_infobox">
							<div class="h_thumb left">
								<% 
									if(data.get("fid") != null){
								%>
								<img alt="" src="/___/file/get/<%=data.get("fid")%>">
								<% }else { %>
								<img alt="" src="${contextPath }/img/no_img.png">
								<% } %>
							</div>
							<div class="h_contact left">
								<ul>
									<li>
										<img src="${contextPath }/img/hospital/hos_info_list_img.png">
										<div class="right hospital_homepage">
											<h3>URL</h3>
											<a href="<%=data.get("homepage") %>" target="_blank"><%=data.get("homepage") %></a>
										</div>
									</li>
									<li class="f13">
										<img src="${contextPath }/img/hospital/hos_info_list_img.png">
										<div class="right hospital_homepage">
											<h3>주소</h3>
											<p><%=data.get("address") %></p>	
										</div>
									</li>
									<li>
										<img src="${contextPath }/img/hospital/hos_info_list_img.png">
										<div class="right hospital_homepage">
											<h3>대표전화 / FAX</h3>
											<p><%=data.get("tel") %></p>
											<p><%=data.get("fax") %></p>	
										</div>
									</li>
								</ul>								
								<!-- <a href="" class="mod_hospital">정보수정하기</a> -->
							</div>
						</div>
						<div class="h_t_slide clear">												
							<ul class="h_t_slide_ul">							
							<%
								List<HashMap<String, Object>> thumbList = (List<HashMap<String, Object>>)request.getAttribute("thumb5");
							
								for(int k = 0 ; k < thumbList.size(); k++){
									HashMap<String, Object> thumb = thumbList.get(k);
							%>							
								<li><img src="${contextPath }/___/file/get/<%=thumb.get("id")%>"></li>
							<% } %>
							</ul>
						</div>
						<div class="clear"></div>
					</div><!-- hbox -->
					<div class="left h_ranking">
						<div class="rank_info">
							<span class="r_info_locRank">전국 <%=data.get("ranking") %>위 / </span>
							<span class="r_info_grade"><%=data.get("grade") %></span>
						</div>
					</div>
				</div>				
			</div><!-- hospital_infomation -->
			<div class="h_sns_btn clear">
				<!-- 페이스북 좋아요, 공유하기 버튼 -->
				<div id="fb-root"></div>
				<script>(function(d, s, id) {
				  var js, fjs = d.getElementsByTagName(s)[0];
				  if (d.getElementById(id)) return;
				  js = d.createElement(s); js.id = id;
				  js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&appId=1427018384229922&version=v2.0";
				  fjs.parentNode.insertBefore(js, fjs);
				}(document, 'script', 'facebook-jssdk'));</script>
				<div class="fb-like" data-href="http://givus.co.kr/___/renew/hospital/<%=data.get("id") %>" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
				<div class="fb-share-button" data-href="http://givus.co.kr/___/renew/hospital/<%=data.get("id") %>" data-type="button"></div>
			</div>
			
			<div class="hospital_tab">
				<ul>
					<li class="on"><a href="${contextPath}/___/renew/hospital/info/<%=data.get("id")%>">병원정보</a></li>
					<li class="divide"><a href="${contextPath}/___/renew/hospital/epilogue/<%=data.get("id")%>">수술후기</a></li>
					<li><a href="${contextPath}/___/renew/hospital/review/<%=data.get("id")%>">병원리뷰</a></li>
				</ul>
			</div><!-- hospital_tab -->
			
			<div class="h_info_cont pt30">
				<h5><img src="${contextPath }/img/hospital/hospital_view_icon.png" class="h_info_icon"><%=data.get("name") %> 성형외과 카테고리별 평점</h5>
				<div class="h_info_box">
					<table cellpadding="0" cellspacing="0" class="h_info_box_tb bg0">
						<colgroup>
							<col width="109">
							<col width="109">
							<col width="109">
							<col width="110">
							<col width="110">
							<col width="110">
						</colgroup>
						<thead>
						<tr>
							<th>평균(5점만점)</th>
							<th>전문성(20%)</th>
							<th>안전성(30%)</th>
							<th>만족성(30%)</th>
							<th>규모성(10%)</th>
							<th>편의성(10%)</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td class="totalp"><%=String.format("%.2f",data.get("totalPoint")) %></td>
							<td><%=String.format("%.2f",data.get("safePoint")) %></td>	
							<td><%=String.format("%.2f",data.get("expertPoint")) %></td>	
							<td><%=String.format("%.2f",data.get("satisfyPoint")) %></td>	
							<td><%=String.format("%.2f",data.get("sizePoint")) %></td>
							<td><%=String.format("%.2f",data.get("convenientPoint")) %></td>															
						</tr>
						</tbody>
					</table>
				</div><!-- h_info_box -->
				<div class="h_info_box_alert">- 제목에 마우스를 올리면 각각 항목들에 대한 설명을 볼 수 있습니다.</div>
			</div><!-- h_info_cont -->
						
						
			<div class="h_info_cont pt30">
				<h5><img src="${contextPath }/img/hospital/hospital_view_icon.png" class="h_info_icon"><%=data.get("name") %> 성형외과 세부정보</h5>
				<div class="h_info_box">
					<table cellpadding="0" cellspacing="0" class="h_info_box_tb bg3">
						<colgroup>
							<col width="109">
							<col width="109">
							<col width="109">
							<col width="110">
							<col width="110">
							<col width="110">
						</colgroup>
						<thead>
						<tr>
							<th>주요수술1</th>
							<th>주요수술2</th>
							<th>전문의수</th>
							<th>마취과수</th>
							<th>전후사진수</th>
							<th>온라인상담건수</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=data.get("mostOperation1") %></td>
							<td><%=data.get("mostOperation2") %></td>	
							<td><%=data.get("specialistCount") == null ? "0" : data.get("specialistCount") %></td>	
							<td><%=data.get("anestheticCount") == null ? "0" : data.get("anestheticCount")  %></td>	
							<td><%=data.get("reviewPicCount") == null ? "0" : data.get("reviewPicCount")  %></td>
							<td><%=data.get("counselCount") == null ? "0" : data.get("counselCount") %></td>								
						</tr>						
						</tbody>
						<thead>
						<tr>
							<th>외국인유치</th>
							<th>통역여부</th>
							<th>병원크기</th>
							<th>픽업서비스</th>
							<th>입원실(침대수)</th>
							<th>회복실(침대수)</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=data.get("foreignerReg") %></td>
							<td><%=data.get("interpreter") %></td>	
							<td><%=data.get("scale") %></td>
							<%
								String pickupService = data.get("pickupService").toString();
								if(!pickupService.equals("없음")){
									%>									
							<td>조건부 <img src="${contextPath }/img/hospital/pick_up_icon.png" onclick="showPickupService();">
								<div class="pickup_service_content">
									<img alt="X" src="${contextPath }/img/hospital/pick_up_close.png" onclick="closePickupService();">
									<pre><%=pickupService %></pre>
								</div>
							</td>
									<%
								}else{
									%>
							<td><%=data.get("pickupService") %></td>
									<%
								}
							%>	
								
							<td><%=data.get("patientRoom") %></td>
							<td><%=data.get("recoveryRoom") %></td>															
						</tr>	
					</table>
				</div><!-- h_info_box -->
				
				<div class="h_info_box mt16">
					<table cellpadding="0" cellspacing="0" class="h_info_box_tb bg2">
						<colgroup>
							<col width="657">
						</colgroup>
						<thead>
						<tr>
							<th>과별수술</th>							
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>
								<% 
									if(data.get("specialistCount") != null ){
										if(Integer.parseInt(data.get("specialistCount").toString()) > 0){
								%>								
									<div class="hos_stats">																
										<c:if test="${hos_stat.oralDoctorCount > 0}"><span>구강과 ${hos_stat.oralDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.dentalDoctorCount > 0}"><span>치과 ${hos_stat.dentalDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.breastDoctorCount > 0}"><span>가슴 ${hos_stat.breastDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.orthodonticDoctorCount > 0}"><span>교정 ${hos_stat.orthodonticDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.otolaryngologyDoctorCount > 0}"><span>이비인후과 ${hos_stat.otolaryngologyDoctorCount}명</span></c:if>
										
										<c:if test="${hos_stat.surgeryDoctorCount > 0}"><span>외과 ${hos_stat.surgeryDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.plasticSurgeryDoctorCount > 0}"><span>성형외과 ${hos_stat.plasticSurgeryDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.anestheticDoctorCount > 0}"><span>마취과 ${hos_stat.anestheticDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.familyMedicineDoctorCount > 0}"><span>가정의과 ${hos_stat.familyMedicineDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.generalDoctorCount > 0}"><span>일반 ${hos_stat.generalDoctorCount}명</span></c:if>
										
										<c:if test="${hos_stat.clinicalDoctorCount > 0}"><span>임상 ${hos_stat.clinicalDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.obesityDoctorCount > 0}"><span>비만 ${hos_stat.obesityDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.dermatologistDoctorCount > 0}"><span>피부과 ${hos_stat.dermatologistDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.prostheticDoctorCount > 0}"><span>보철 ${hos_stat.prostheticDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.implantsDoctorCount > 0}"><span>임플란트 ${hos_stat.implantsDoctorCount}명</span></c:if>
										<c:if test="${hos_stat.obstetricsDoctorCount > 0}"><span>산부인과 ${hos_stat.obstetricsDoctorCount}명</span></c:if>																				
									</div>
									<% } %>
								<%} %>
							</td>
						</tr>						
						</tbody>
					</table>
				</div><!-- h_info_box -->	
				
				<div class="h_info_box mt16">
					<table cellpadding="0" cellspacing="0" class="h_info_box_tb bg2">
						<colgroup>
							<col width="657">
						</colgroup>
						<thead>
						<tr>
							<th>가능수술</th>							
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=data.get("possibleSurgery") %></td>
						</tr>						
						</tbody>
					</table>
				</div><!-- h_info_box -->	
				
				<div class="h_info_box mt16">
					<table cellpadding="0" cellspacing="0" class="h_info_box_tb bg2">
						<colgroup>
							<col width="657">
						</colgroup>
						<thead>
						<tr>
							<th>진료시간</th>							
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>${data.hours }</td>
						</tr>						
						</tbody>
					</table>
				</div><!-- h_info_box -->
								
			</div><!-- h_info_cont -->
			
			<!-- 코멘트 -->
			<div class="h_info_cont pt30">
				<h5><img src="${contextPath }/img/hospital/hospital_view_icon.png" class="h_info_icon"><%=data.get("name") %> 성형외과 코멘트</h5>				
				<div class="h_c_inner">
					<div class="h_comment"><%=data.get("introduction") %></div>	
				</div>
				<script type="text/javascript">
				//console.log(browser);
				if(Browser.ie7 || Browser.ie8){
					$('.h_comment').corner('round 5px').parent().css('padding','1px').corner('round 6px');					
				}else{
					$('.h_comment').corner('round 5px');
					$('.h_c_inner').css('background-color','#ffffff');
				}
				</script>
			</div><!-- h_info_cont -->		
		
			<%			
				List<HashMap<String, Object>> surg_cate = (List<HashMap<String, Object>>)request.getAttribute("surg_cate");
				List<HashMap<String, Object>> price = (List<HashMap<String, Object>>)request.getAttribute("price");
			
				DecimalFormat moneyFormat = new DecimalFormat("#,###,###");
				
				if(price.size() == 28){			
			%>
		
		
			<div class="h_info_cont pt30">
				<h5><img src="${contextPath }/img/hospital/hospital_view_icon.png" class="h_info_icon"><%=data.get("name") %> 성형외과 가격정보</h5>
				<%
				if(um != null){
					if(um.getEmail() != null){			
					}else{
						%>
						<div class="rank_alert_text">
							※ 가격정보는 로그인 후 열람하실 수 있습니다.
						</div>
						<%
					}
				}else{
					%>
					<div class="rank_alert_text">
							※ 가격정보는 로그인 후 열람하실 수 있습니다.
						</div>
					<%
				}
				%>
				<div class="h_price_info">
					<div class="h_price_info_head">
						<span class="tit1">부위</span>
						<span class="tit2">시술/수술명</span>
						<span class="tit3">가격</span>
					</div><!-- h_price_info_head -->
					<%--가격정보 --%>
					<table cellpadding="0" cellspacing="0" class="price_info_tb">
						<colgroup>
							<col width="276">
							<col width="381">
						</colgroup>
						<tbody>
						
						<%
							for(int a = 0 ; a < surg_cate.size() ; a++){
								
								HashMap<String, Object> keys = surg_cate.get(a);
								
								int s_cate_id = (Integer)keys.get("id");
								
						%>
						
						<tr>
							<td class="tit">
								<img alt="" src="${contextPath }/img/hospital/hospital_price<%=a+1 == 7 ? 6 : a+1 %>_icon.png"><span class="icon_title"><%=keys.get("name") %></span>
							</td>
							<td>
								<div class="price_list clear">
									<ul class="price_list_ul">
										<%
											for(int aa = 0 ; aa < price.size(); aa++){
												HashMap<String, Object> price_data = price.get(aa);
												
												//out.println(price_data);
												
												int price_kwId = (Integer)price_data.get("keywordId");
												
												if(s_cate_id == price_kwId){
													String price_str = "-";
													
													String price_a = price_data.get("price") == null ? "0" : price_data.get("price").toString() ;
													
													 if(!price_a.equals("0")){
														 price_str = moneyFormat.format( Integer.parseInt( price_data.get("price").toString())); 
													 }
													
										%>
										<li><span class="tit2"><%=price_data.get("name") %></span>
											<span class="tit3">
											<%
											if(um != null){
												if(um.getEmail() != null){
											%>
												<%=price_str %> 원
											<%
												}else{
													%>
													<img alt="" src="${contextPath }/img/hospital/lock_icon.png" class="price_lock">
													<%
												}
											}else{
												%>
												<img alt="" src="${contextPath }/img/hospital/lock_icon.png" class="price_lock">
												<%
											}
											%>
											</span></li>
										<%
												}
										} //for %>										
									</ul>
								</div>
							</td>
						</tr>
						
						<% } %>
						
						</tbody>
					</table>
				</div><!-- h_price_info -->
			</div><!-- h_info_cont -->	
			<%}else{ %>
			<div class="price_empty">가격정보가 등록되지 않았습니다.</div>
			<%} 
			
			%>
		</div><!-- hospital_cont -->			
		
		<div class="hospital_aside left">
			<div class="most_view_hos"></div>
			<div class="ranklist"></div>
		</div><!-- hospital_aside -->
	</div><!-- content -->
	
</div>
</div><!-- wrap -->
<%@include file="../inc/footer.jsp"%>
</body>
</html>