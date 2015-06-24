<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.text.DecimalFormat" %>
<%
	// 지역
	List<HashMap<String, Object>> codes = (List<HashMap<String, Object>>)request.getAttribute("codes");
	// 
	HashMap<String, Object> statCount = (HashMap<String, Object>)request.getAttribute("statCount");
	int avgGrade = (Integer)request.getAttribute("avgGrade");	// 평균 
	HashMap<String, String> most_surg = (HashMap<String, String>)request.getAttribute("mostSurg");
	int hCount = (Integer)request.getAttribute("hCount");	// 병원갯수
	List<HashMap<String, Object>> prices = (List<HashMap<String, Object>>)request.getAttribute("prices");
	
	List<HashMap<String, Object>> hos_names = (List<HashMap<String, Object>>)request.getAttribute("hos_names");

	String gradeStr = "";
	int a_count = (int)(avgGrade/3);
	
	int avg_flag = avgGrade % 3;
	for(int k = 0 ; k < a_count ; k++){
		gradeStr += "A";
	}
	if(avg_flag == 1){
		gradeStr += "A-";
	}else if(avg_flag == 2){
		gradeStr += "A0";
	}else{
		gradeStr += "+";
	}
	
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/script/jqueryui/plugin/jquery.selectbox.css" />
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/jquery.selectbox-0.2.js"></script>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/compare.css?noc=<%=System.currentTimeMillis() %>" />
<script type="text/javascript">
$(document).ready(function(){
	$("#locations").change(function(e){		 
		var locId = $('#locations option:selected').val();
		$.ajax({
			url : '${contextPath}/___/renew/compare/hname/' + locId,
			success: function(data){
				var obj = $.parseJSON(data);
				
				var obj = obj.hos_names;
				
				//console.log(obj);
				
				$('.h_names').empty();
				
				var html = '<option value="">선택</option>';
				for(var i = 0 ; i < obj.length ; i++){
					html += '<option value="'+obj[i].id+'">' + obj[i].name + '</option>';
				}
				
				$('.h_names').html(html);
			}
		});		
	});
	
	if(!Browser.ie7){
		$("#locations, .h_names").corner('5px');
	}
	
	
	$('.h_names').change(function(e){
		var num = $(this).attr('id').replace('hos', '');
		
		var id = $(this).find('option:selected').val();
		
		$.ajax({
			url : '${contextPath}/___/renew/compare/hinfo/' + id,
			success: function(data){
				//console.log(data);
				
				var obj = $.parseJSON(data);
				
				if(obj.code == 0){
					var hospital = obj.hos;
					var thumb = obj.thumb;
					var price = obj.price;
					
					//console.log(obj);
					
					var html = '';
					
					$('td.hos' + num).empty();
					
					var desc = '<div class="title">';
						if(hospital.ranking < 100){
							desc += '<span class="h_num_bg">'+hospital.ranking+'</span>';
						}else{
							desc += '<span class="h_num_bg2">'+hospital.ranking+'</span>';
						}
				
						desc += '<span class="h_name">'+hospital.name+'</span>';					
						desc += '</div>'; 
						desc += '<div class="h_thumb">';
						if(thumb != null)
							desc += '	<img alt="" src="/___/file/get/'+thumb.id+'">';
						else 
							desc += '	<img alt="" src="${contextPath}/img/no_img.png">';
						desc += '</div>'; 
						desc += '<div class="h_contact">'; 
						desc += '<ul>'; 
						desc += '<li><pre>'+hospital.address+'</pre></li>'; 
						desc += '<li><pre>대표전화) '+hospital.tel+'</pre></li>'; 
						desc += '</ul>'; 
						desc += '</div>';
					
					$('td.hos' + num).eq(0).html(desc);
					$('td.hos' + num).eq(1).html('<span class="red">'+hospital.grade+'</span>');
					$('td.hos' + num).eq(2).html('<span class="blue">'+hospital.totalPoint+'</span>');
					$('td.hos' + num).eq(3).html('<span class="blue">전국 '+hospital.ranking+'위</span>');
					
					if(hospital.anestheticCount == undefined) hospital.anestheticCount = 0;
					
					$('td.hos' + num).eq(4).text(hospital.mostOperation1);
					$('td.hos' + num).eq(5).text(hospital.specialistCount + '명');
					$('td.hos' + num).eq(6).text(hospital.anestheticCount + '명');
					$('td.hos' + num).eq(7).text(hospital.counselCount + '건');
					
					// 가격정보
					if(price.length == 28){
						
						var price1 = '<ul class="price_avg">';
							for(var i = 0 ; i < 6 ; i++){
								if(price[i].keyname == '눈'){
									price1 +=	'<li >'+ (price[i].price != null ? formatCurrency(''+ price[i].price) : '-' )+' 원</li>';	
								}else{
									price1 +=    '<li ></li>';
								}								
							}						
							price1 += '</ul>';					
						$('td.hos' + num).eq(8).html(price1);
						
						var price2 = '<ul class="price_avg">';
							for(var i = 6 ; i < 10 ; i++){
								if(price[i].keyname == '코'){
									price2 +=	'<li >'+ (price[i].price != null ? formatCurrency(''+price[i].price) : '-' )+' 원</li>';	
								}else{
									price2 +=    '<li ></li>';
								}										
							}						
							price2 += '</ul>';					
						$('td.hos' + num).eq(9).html(price2);
						
						var price3 = '<ul class="price_avg">';
							for(var i = 10 ; i < 13 ; i++){
								if(price[i].keyname == '안면윤곽'){
									price3 +=	'<li >'+ (price[i].price != null ? formatCurrency(''+price[i].price) : '-' )+' 원</li>';	
								}else{
									price3 +=    '<li ></li>';
								}								
							}						
							price3 += '</ul>';					
						$('td.hos' + num).eq(10).html(price3);
						
						var price4 = '<ul class="price_avg">';
							for(var i = 13 ; i < 18 ; i++){
								if(price[i].keyname == '체형'){
									price4 +=	'<li >'+ (price[i].price != null ? formatCurrency(''+price[i].price) : '-' )+' 원</li>';	
								}else{
									price4 +=    '<li ></li>';
								}								
							}						
							price4 += '</ul>';					
						$('td.hos' + num).eq(11).html(price4);
						
						var price5 = '<ul class="price_avg">';
							for(var i = 18 ; i < 20 ; i++){
								if(price[i].keyname == '가슴확대'){
									price5 +=	'<li >'+ (price[i].price != null ? formatCurrency(''+price[i].price) : '-' )+' 원</li>';	
								}else{
									price5 +=    '<li ></li>';
								}
								
							}						
							price5 += '</ul>';					
						$('td.hos' + num).eq(12).html(price5);
						
						var price6 = '<ul class="price_avg">';
							for(var i = 20 ; i < 23 ; i++){
								if(price[i].keyname == '톡신'){
									price6 +=	'<li >'+ (price[i].price != null ? formatCurrency(''+price[i].price) : '-' )+' 원</li>';	
								}else{
									price6 +=    '<li ></li>';
								}
								
							}						
							price6 += '</ul>';					
						$('td.hos' + num).eq(13).html(price6);
						
						var price7 = '<ul class="price_avg">';
							for(var i = 23 ; i < 28 ; i++){
								if(price[i].keyname == '필러'){
									price7 +=	'<li >'+ (price[i].price != null ? formatCurrency(''+price[i].price) : '-' )+' 원</li>';	
								}else{
									price7 +=    '<li ></li>';
								}
								
							}						
							price7 += '</ul>';					
						$('td.hos' + num).eq(14).html(price7);
						
					}else{
						$('td.hos' + num).eq(8).text('가격정보 없음');
						$('td.hos' + num).eq(9).text('가격정보 없음');
						$('td.hos' + num).eq(10).text('가격정보 없음');
						$('td.hos' + num).eq(11).text('가격정보 없음');
						$('td.hos' + num).eq(12).text('가격정보 없음');
						$('td.hos' + num).eq(13).text('가격정보 없음');
						$('td.hos' + num).eq(14).text('가격정보 없음');
					}
				}else{
					alert('<%=MessageHandler.getMessage("posting.msg.recommend_needlogin")%>');
					location.href = '${contextPath}/___/renew/login';
				}
				
				
				
			}
		});	
		
	});
	
	$('.m2').addClass('sub on');
	
	/*
	$("#locations").selectbox({
		onOpen: function (inst) {
			//console.log("open", inst);
		},
		onClose: function (inst) {
			//console.log("close", inst);
		},
		onChange: function (val, inst) {
			var locId = val;
	
			$.ajax({
				url : '${contextPath}/___/renew/compare/hname/' + locId,
				success: function(data){
					var obj = $.parseJSON(data);
					
					var obj = obj.hos_names;
					
					//console.log(obj);
					
					$('.h_names').empty();
					
					var html = '';
					for(var i = 0 ; i < obj.length ; i++){
						html += '<option value="'+obj[i].id+'">' + obj[i].name + '</option>';
					}
					
					$('.h_names').html(html);					
				}
			});			
		},
		effect: "slide"
	});
	*/
	
});
</script>
<title></title>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="content">
		<h3 class="compare_tit">성형비용비교</h3>
		<div class="compare_cont">
			<table cellpadding="0" cellspacing="0" class="compare_cont_tb">
				<colgroup>
					<col width="153">
					<col width="156">
					<col width="217">
					<col width="217">
					<col width="217">
				</colgroup>
				<thead>
				<tr>
					<th><span class="white">병원검색</span></th>
					<th>
						<select id="locations">	
							<option value="ALL">전체</option>
							<%
								for (int i = 0 ; i < codes.size() ; i++){
									HashMap<String, Object> data = codes.get(i);
							%>
							<option value="<%=data.get("code")%>"><%=data.get("name") %></option>
							<%} %>
						</select>
					</th>
					<th>
						<select class="h_names" id="hos1">
							<option value="">선택</option>
							<%
								for(int ii = 0 ; ii < hos_names.size(); ii++){
									HashMap<String, Object> data = hos_names.get(ii);
							%>
							<option value="<%=data.get("id")%>"><%=data.get("name") %></option>
							<%
								}
							%>							
						</select>
					</th>
					<th>
						<select class="h_names" id="hos2">
							<option value="">선택</option>
							<%
								for(int kk = 0 ; kk < hos_names.size(); kk++){
									HashMap<String, Object> data = hos_names.get(kk);
							%>
							<option value="<%=data.get("id")%>"><%=data.get("name") %></option>
							<%
								}
							%>
						</select>
					</th>
					<th class="last">
						<select class="h_names" id="hos3">
							<option value="">선택</option>
							<%
								for(int aa = 0 ; aa < hos_names.size(); aa++){
									HashMap<String, Object> data = hos_names.get(aa);
							%>
							<option value="<%=data.get("id")%>"><%=data.get("name") %></option>
							<%
								}
							%>
						</select>
					</th>
				</tr>				
				</thead>
				<tbody>
				<tr>
					<td class="tit">병원보기</td>
					<td class="avg lef_bg">
						<div class="lef_tit">GIVUS 평균</div>
						<div class="">
							<img alt="" src="${contextPath }/img/compare/lef_logo.png">
						</div>
						<div class="lef_cont">
							<h2>GIVUS</h2>
							<h4>ranking</h4>
						</div>						
					</td>
					<td class="hos1 va_t">
						
					</td>
					<td class="hos2 va_t">
						
					</td>
					<td class="hos3 va_t"></td>
				</tr>
				<!-- 점수및 랭킹 -->
				<tr>
					<td class="tit bd_1"><strong class="blue">GIVUS LEVEL</strong></td>
					<td class="avg bd_1"><span class="red"><%=gradeStr %></span></td>
					<td class="hos1 bd_1"><span class="red"></span></td>
					<td class="hos2 bd_1"><span class="red"></span></td>
					<td class="hos3 bd_1"><span class="red"></span></td>
				</tr>
				<tr>
					<td class="tit bd_1"><strong class="blue">GIVUS SCORE</strong></td>
					<td class="avg bd_1"><span class="blue"><%=String.format("%.2f", statCount.get("total")) %></span></td>
					<td class="hos1 bd_1"><span class="blue"></span></td>
					<td class="hos2 bd_1"><span class="blue"></span></td>
					<td class="hos3 bd_1"><span class="blue"></span></td>
				</tr>
				<tr>
					<td class="tit"><strong class="blue">GIVUS RANKING</strong></td>
					<td class="avg"><span class="blue"><%=hCount %>개</span></td>
					<td class="hos1"><span class="blue"></span></td>
					<td class="hos2"><span class="blue"></span></td>
					<td class="hos3"><span class="blue"></span></td>
				</tr>
				<!-- 병원정보 -->
				<tr>
					<td class="tit bd_1">주요수술</td>
					<td class="avg bd_1"><span class="blue"><%=most_surg.get("mostOperation1") %></span></td>
					<td class="hos1 bd_1"></td>
					<td class="hos2 bd_1"></td>
					<td class="hos3 bd_1"></td>
				</tr>
				<tr>
					<td class="tit bd_1">성형외과 전문의</td>
					<td class="avg bd_1"><span class="blue"><%=String.format("%.1f", statCount.get("spCnt") ) %>명</span></td>
					<td class="hos1 bd_1"></td>
					<td class="hos2 bd_1"></td>
					<td class="hos3 bd_1"></td>
				</tr>
				<tr>
					<td class="tit bd_1">마취과 전문의</td>
					<td class="avg bd_1"><span class="blue"><%=String.format("%.1f", statCount.get("anCnt") ) %>명</span></td>
					<td class="hos1 bd_1"></td>
					<td class="hos2 bd_1"></td>
					<td class="hos3 bd_1"></td>
				</tr>
				<tr>
					<td class="tit">온라인 상담건수</td>
					<td class="avg"><span class="blue"><%=statCount.get("csCnt") %>건</span></td>
					<td class="hos1"></td>
					<td class="hos2"></td>
					<td class="hos3"></td>
				</tr>
				<!-- 가격정보 -->
				<%
					DecimalFormat moneyFormat = new DecimalFormat("#,###,###");
				
					for(int a = 0 ; a < prices.size(); a++){
						HashMap<String, Object> data = prices.get(a);
						Object tmp = data.get("price");
						String formatted = moneyFormat.format(tmp);
						data.put("price", formatted);
						prices.set(a, data);
					}
				%>				
				<tr>
					<td class="tit">
						<div class="left price_tit title1">눈</div>
						<div class="left price_list">
							<ul>
								<li><%=prices.get(0).get("name") %></li>
								<li><%=prices.get(1).get("name") %></li>
								<li><%=prices.get(2).get("name") %></li>
								<li><%=prices.get(3).get("name") %></li>
								<li><%=prices.get(4).get("name") %></li>
								<li class="last"><%=prices.get(5).get("name") %></li>
							</ul>
						</div>
					</td>
					<td class="avg">
						<ul class="price_avg compare">
							<li><span class="blue"><%=prices.get(0).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(1).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(2).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(3).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(4).get("price") %>원</span></li>
							<li class="last"><span class="blue"><%=prices.get(5).get("price") %>원</span></li>
						</ul>
					</td>
					<td class="hos1">
						<div class=""></div>
					</td>
					<td class="hos2"></td>
					<td class="hos3"></td>
				</tr>
				<tr>
					<td class="tit">
						<div class="left price_tit title2">코</div>
						<div class="left price_list">
							<ul>
								<li><%=prices.get(6).get("name") %></li>
								<li><%=prices.get(7).get("name") %></li>
								<li><%=prices.get(8).get("name") %></li>
								<li class="last"><%=prices.get(9).get("name") %></li>								
							</ul>
						</div>
					</td>
					<td class="avg">
						<ul class="price_avg compare">
							<li><span class="blue"><%=prices.get(6).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(7).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(8).get("price") %>원</span></li>							
							<li class="last"><span class="blue"><%=prices.get(9).get("price") %>원</span></li>
						</ul>
					</td>
					<td class="hos1">
						<div class=""></div>
					</td>
					<td class="hos2"></td>
					<td class="hos3"></td>
				</tr>
				<tr>
					<td class="tit">
						<div class="left price_tit title3">안면<br/>윤곽</div>
						<div class="left price_list">
							<ul>
								<li><%=prices.get(10).get("name") %></li>
								<li><%=prices.get(11).get("name") %></li>
								<li class="last"><%=prices.get(12).get("name") %></li>
							</ul>
						</div>
					</td>
					<td class="avg">
						<ul class="price_avg compare">
							<li><span class="blue"><%=prices.get(10).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(11).get("price") %>원</span></li>
							<li class="last"><span class="blue"><%=prices.get(12).get("price") %>원</span></li>
						</ul>
					</td>
					<td class="hos1">
						<div class=""></div>
					</td>
					<td class="hos2"></td>
					<td class="hos3"></td>
				</tr>
				<tr>
					<td class="tit">
						<div class="left price_tit title4">체형</div>
						<div class="left price_list">
							<ul>
								<li><%=prices.get(13).get("name") %></li>
								<li><%=prices.get(14).get("name") %></li>
								<li><%=prices.get(15).get("name") %></li>
								<li><%=prices.get(16).get("name") %></li>
								<li class="last"><%=prices.get(17).get("name") %></li>
							</ul>
						</div>
					</td>
					<td class="avg">
						<ul class="price_avg compare">
							<li><span class="blue"><%=prices.get(13).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(14).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(15).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(16).get("price") %>원</span></li>
							<li class="last"><span class="blue"><%=prices.get(17).get("price") %>원</span></li>
						</ul>
					</td>
					<td class="hos1">
						<div class=""></div>
					</td>
					<td class="hos2"></td>
					<td class="hos3"></td>
				</tr>
				<tr>
					<td class="tit">
						<div class="left price_tit title5">가슴<br/>확대</div>
						<div class="left price_list">
							<ul>
								<li><%=prices.get(18).get("name") %></li>
								<li class="last"><%=prices.get(19).get("name") %></li>								
							</ul>
						</div>
					</td>
					<td class="avg">
						<ul class="price_avg compare">
							<li><span class="blue"><%=prices.get(18).get("price") %>원</span></li>							
							<li class="last"><span class="blue"><%=prices.get(19).get("price") %>원</span></li>
						</ul>
					</td>
					<td class="hos1">
						<div class=""></div>
					</td>
					<td class="hos2"></td>
					<td class="hos3"></td>
				</tr>
				<tr>
					<td class="tit">
						<div class="left price_tit title6">톡신</div>
						<div class="left price_list">
							<ul>
								<li><%=prices.get(20).get("name") %></li>
								<li><%=prices.get(21).get("name") %></li>
								<li class="last"><%=prices.get(22).get("name") %></li>								
							</ul>
						</div>
					</td>
					<td class="avg">
						<ul class="price_avg compare">
							<li><span class="blue"><%=prices.get(20).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(21).get("price") %>원</span></li>							
							<li class="last"><span class="blue"><%=prices.get(22).get("price") %>원</span></li>
						</ul>
					</td>
					<td class="hos1">
						<div class=""></div>
					</td>
					<td class="hos2"></td>
					<td class="hos3"></td>
				</tr>
				<tr>
					<td class="tit">
						<div class="left price_tit title7">필러</div>
						<div class="left price_list">
							<ul>
								<li><%=prices.get(23).get("name") %></li>
								<li><%=prices.get(24).get("name") %></li>
								<li><%=prices.get(25).get("name") %></li>
								<li><%=prices.get(26).get("name") %></li>
								<li class="last"><%=prices.get(27).get("name") %></li>								
							</ul>
						</div>
					</td>
					<td class="avg">
						<ul class="price_avg compare">
							<li><span class="blue"><%=prices.get(23).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(24).get("price") %>원</span></li>		
							<li><span class="blue"><%=prices.get(25).get("price") %>원</span></li>
							<li><span class="blue"><%=prices.get(26).get("price") %>원</span></li>							
							<li class="last"><span class="blue"><%=prices.get(27).get("price") %>원</span></li>
						</ul>
					</td>
					<td class="hos1">
						<div class=""></div>
					</td>
					<td class="hos2"></td>
					<td class="hos3"></td>
				</tr>
				</tbody>
			</table>
		</div>
		
		<div class="compare_alert_text">
			<p>※ 평균가격보다 많이 낮은 곳은 이벤트금액 또는 2곳 이상 수술 시 가격일 수 있습니다.</p>
			<p>※ GIVUS 성형비용은 전화 또는 방문하여 실제 확인한 비용이지만 개인차, 병원상황 등에 따라 가격이 다소 차이가 있을 수 있습니다.</p>
		</div>
		
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>