<%@page import="java.util.Calendar"%>
<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="kr.co.zadusoft.contents.util.RelativeDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>
<%-- 헤더 삽입 --%>
<%@include file="inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/main.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	
	/*
	$('.visual').animate({
		height: 368+'px'
	},1000, function(){
		$('.current_info').fadeIn(400, function(){
			$('.link_icons').fadeIn(400);
		});
	});
	*/
	
	// 메인 비쥬얼2번째 버전
	$('.vis_v2_overlay').mouseenter(function(){
		$('.vis_v2_slide_btn').show();
	});
	$('.vis_v2_overlay').mouseleave(function(){
		$('.vis_v2_slide_btn').hide();
	});
	
	$('.vs_v2_btn').mouseenter(function(){		
		$(this).addClass('on');
	});
	$('.vs_v2_btn').mouseleave(function(){
		$(this).removeClass('on');
	});
	
	$('.vs_v2_bot_btn_cont a').mouseenter(function(){
		$(this).stop(true,true).animate({			
			'margin-top' : '0px',
			'padding-top' : '24px'
		}, 300);
	});
	$('.vs_v2_bot_btn_cont a').mouseleave(function(){
		$(this).stop(true,true).animate({			
			'margin-top' : '18px',
			'padding-top' : '15px'
		}, 300);
	});
	
	$('#ranking_sort').change(function(){
		var val = $('#ranking_sort option:selected').val();
		if(val != ''){
			if(val != 'ALL'){
				var type = val.split(":")[0];
				var code = val.split(":")[1];
				
				location.href="${contextPath}/___/renew/main?type=" + type + "&code=" + code;
			}else{
				location.href="${contextPath}/___/renew/main";
			}			
		}
	});
});

var _curr_vs_v2 = 1;

function change_vis_v2_img(){
	//$('.vis_v2').removeClass('bg1 bg2 bg3');
	//$('.vis_v2').addClass('bg' +_curr_vs_v2);
	
	if(_curr_vs_v2 == 1){
		gotoStep1();
	}else if(_curr_vs_v2 == 2){
		gotoStep2();
	}else if(_curr_vs_v2 == 3){
		gotoStep3();
	}
	
	_curr_vs_v2++;
	
	if(_curr_vs_v2 > 3){
		_curr_vs_v2 = 1;
	}
}


</script>
</head>
<body>
<div class="wrap">
<%@include file="inc/top.jsp"%>
<div class="wrapper clear">
	<%
		int total = (Integer)request.getAttribute("total");
		String date = request.getAttribute("updateDate").toString();
		
		String type = request.getAttribute("type") == null ? "" : request.getAttribute("type").toString();
		String code = request.getAttribute("code") == null ? "" : request.getAttribute("code").toString();
		
	%>
	<!-- 
	<div class="visual">
		<div class="vs_container">
			<div class="current_info">
				<p><%=MessageHandler.getMessage("main.visual.hoscount") %> : <%=total %>개</p>
				<p><%=MessageHandler.getMessage("main.visual.updatedate") %> : 약 <%=date %>전</p>
			</div>
			<div class="link_icons">
				<%
					if(um.getEmail() != null){
						
						if(um.getUserType().equals("G")){
				%>
				<a href="${contextPath }/___/renew/hospital/add1" class="join_hospital">병원등록</a>
				<% 	}else if(um.getUserType().equals("H")){
							if(um.getHospitalAccepted().equals("W")){
								%>
								<a href="javascript:" class="join_hospital">병원승인대기중</a>
								<%
							}else if(um.getHospitalAccepted().equals("A")){
								%>
								<a href="${contextPath }/___/renew/mypage/myhinfo" class="join_hospital">병원수정</a>
								<%	
							}
						}
						%>
				<% }else { %>
				<a href="javascript:alert('로그인이 필요합니다.')" class="join_hospital">병원등록</a>
				<a href="${contextPath }/___/renew/join" class="join_us">회원가입</a>				
				<% } %>
				
			</div>
		</div>
	</div> visual -->
	
	<div class="vis_v2 bg1">		
		<div class="vis_v2_overlay">
			<!-- step1 -->
			<div class="vis_v2_step1_cont">
				<span class="h3">GIVUS</span>
				<span>신뢰있는 병원정보를<br/>제공하는 사이트입니다.</span>
			</div>
			<!-- step2 -->
			<div class="vis_v2_step2_cont">
				<div class="left">
					<img alt="" src="${contextPath }/img/main/vis_v2_logo.png" class="vis_v2_logo_img">
				</div>
				<div class="left">
					<div class="location_slide">
						<span>전국</span>
						<span>서울</span>
						<span>광역</span>
						<span>부위</span>
					</div>
					<div class="toup_text">순위는 매일 업데이트 됩니다.</div>
				</div>
			</div>
			<!-- step3 -->
			<div class="vis_v2_step3_cont">
				<span class="h3">등록된 성형외과 : <span id="hos_number"></span>개</span><br/>
				<span>최근 업데이트 : <span id="hos_update_time"></span></span>
			</div>
						
			<div class="vis_v2_slide_btn">
				<span class="vs_v2_btn left off"></span>
				<span class="vs_v2_btn right off"></span>
			</div>
			<div class="vs_v2_bot_btn">
				<div class="vs_v2_bot_btn_cont">
					<%
					if(um.getEmail() != null){
						
						if(um.getUserType().equals("G")){
					%>
					<a href="${contextPath }/___/renew/hospital/add1" ><img src="${contextPath }/img/main/add_hos_btn.png"></a>
					<% 	}else if(um.getUserType().equals("H")){
								if(um.getHospitalAccepted().equals("W")){
									%>
									<a href="javascript:" >병원승인대기중</a>
									<%
								}else if(um.getHospitalAccepted().equals("A")){
									%>
									<a href="${contextPath }/___/renew/mypage/myhinfo" >내병원정보</a>
									<%	
								}
							}
							%>
					<% }else { %>
					<a href="javascript:alert('로그인이 필요합니다.')" ><img src="${contextPath }/img/main/add_hos_btn.png"></a>
					<a href="${contextPath }/___/renew/join"><img src="${contextPath }/img/main/join_btn.png"></a>				
					<% } %>
				</div>
				
			</div>
		</div>		
	</div>
	
	<script type="text/javascript" src="${contextPath}/script/jquery.animateNumber.js"></script>
	<script type="text/javascript">
	
	function gotoStep1(){
		$('.vis_v2_step3_cont').animate({
			'padding-top' : '192px',
			'opacity' : 0
		}, 800, function(){
			$('.vis_v2_step1_cont').animate({
				'opacity' : 1			
			}
			,1000);	
		}); 		
	}
	
	function gotoStep2(){
		$('.vis_v2_step1_cont').animate({
			'margin-left' : '-400px',
			'opacity' : 0
		},700, function(){
			$('.vis_v2_step1_cont').css({
				'margin-left' :'-200px',
				'opacity' : 0
			});
		});
		
		$('.vis_v2_logo_img').animate({
			'margin-left' : '50px',
			'opacity' : 1
		},700, function(){
			$('.location_slide').animate({				
				'opacity' : 1	
			}, 700, function(){
				$('.location_slide').animate({
					'padding-top' : '68px'
				},700, function(){
					$('.toup_text').animate({
						'opacity' : 1,
						'padding-top' : '200px'
					},700);
				});
				
			});
		});		
	}
	
	function gotoStep3(){
		$('.vis_v2_logo_img').animate({
			'margin-left' : '-150px',
			'opacity' : 0
		},700, function(){
			
		});	
		
		$('.location_slide').animate({				
			'opacity' : 0,
			'margin-top' : '-200px'
		}, 700, function(){
			$('.location_slide').css({
				'padding-top' : '100px',
				'margin-top' : '0px'
			},700);
		});
		
		$('.toup_text').animate({
			'opacity' : 0,
			'margin-left' : '500px'
		},700, function(){
			$('.toup_text').css({
				'padding-top' : '220px',
				'margin-left' : '420px'
			});
		});
		
		var total = <%=total%>;
		var date = '<%=date%>';
		
		$('#hos_number').animateNumber({ number: total }, 1000);
		
		$('#hos_update_time').text(date);	
		
		$('.vis_v2_step3_cont').animate({
			'padding-top' : '152px',
			'opacity' : 1
		}, 800, function(){
			
		});
		
		
	}
	change_vis_v2_img();
	
	setInterval(change_vis_v2_img, 7000);
	
	</script>
	 
	<div class="content">
		<!-- ranking -->
		<div class="rank_top">
		<%
			String titleName = "";
			if(type.equals("")){
				titleName = "TOP 100";
			}else{
				if(type.equals("LC") && code.equals("AA")){
					titleName = "서울TOP";
				}else if(type.equals("LC") && code.equals("A")){
					titleName = "경기TOP";
				}else if(type.equals("LC") && code.equals("B")){
					titleName = "인천TOP";
				}else if(type.equals("LC") && code.equals("C")){
					titleName = "대구TOP";
				}else if(type.equals("LC") && code.equals("D")){
					titleName = "대전TOP";
				}else if(type.equals("LC") && code.equals("E")){
					titleName = "광주TOP";
				}else if(type.equals("LC") && code.equals("F")){
					titleName = "울산TOP";
				}else if(type.equals("LC") && code.equals("G")){
					titleName = "부산TOP";
				}
				
				if(type.equals("PT") && code.equals("eye")){
					titleName = "눈TOP";
				}else if(type.equals("PT") && code.equals("nose")){
					titleName = "코TOP";
				}else if(type.equals("PT") && code.equals("petit")){
					titleName = "쁘띠TOP";
				}else if(type.equals("PT") && code.equals("breast")){
					titleName = "가슴TOP";
				}else if(type.equals("PT") && code.equals("face")){
					titleName = "안면윤곽TOP";
				}else if(type.equals("PT") && code.equals("body")){
					titleName = "체형TOP";
				}
			}
			
			
		%>
			<h2><%=titleName %></h2>
			<div class="rank_sort">
				<select  id="ranking_sort">
					<option value="ALL" <%if(type.equals("")) out.print("selected=\"selected\""); %>>TOP 100</option>
					<option value="">--------</option>
					<option value="LC:AA" <%if(type.equals("LC") && code.equals("AA")) out.print("selected=\"selected\""); %>>서울TOP</option>
					<option value="">--------</option>
					<option value="">광역시 TOP10</option>					
					<option value="LC:B" <%if(type.equals("LC") && code.equals("B")) out.print("selected=\"selected\""); %>>인천TOP</option>
					<option value="LC:A" <%if(type.equals("LC") && code.equals("A")) out.print("selected=\"selected\""); %>>경기TOP</option>
					<option value="LC:G" <%if(type.equals("LC") && code.equals("G")) out.print("selected=\"selected\""); %>>부산TOP</option>
					<option value="LC:C" <%if(type.equals("LC") && code.equals("C")) out.print("selected=\"selected\""); %>>대구TOP</option>					
					<option value="LC:D" <%if(type.equals("LC") && code.equals("D")) out.print("selected=\"selected\""); %>>대전TOP</option>
					<option value="LC:E" <%if(type.equals("LC") && code.equals("E")) out.print("selected=\"selected\""); %>>광주TOP</option>
					<option value="LC:F" <%if(type.equals("LC") && code.equals("F")) out.print("selected=\"selected\""); %>>울산TOP</option>
					<option value="">--------</option>
					<option value="">부위별 TOP10</option>
					<option value="PT:eye" <%if(type.equals("PT") && code.equals("eye")) out.print("selected=\"selected\""); %>>눈TOP</option>
					<option value="PT:nose" <%if(type.equals("PT") && code.equals("nose")) out.print("selected=\"selected\""); %>>코TOP</option>
					<option value="PT:petit" <%if(type.equals("PT") && code.equals("petit")) out.print("selected=\"selected\""); %>>쁘띠TOP</option>
					<option value="PT:breast" <%if(type.equals("PT") && code.equals("breast")) out.print("selected=\"selected\""); %>>가슴TOP</option>
					<option value="PT:face" <%if(type.equals("PT") && code.equals("face")) out.print("selected=\"selected\""); %>>안면윤곽TOP</option>
					<option value="PT:body" <%if(type.equals("PT") && code.equals("body")) out.print("selected=\"selected\""); %>>체형TOP</option>					
				</select>
			</div>
			<div class="ranking_list clear">
				<table cellpadding="0" cellspacing="0" class="ranking_list_tb">
					<colgroup>
						<col width="64">
						<col width="134">
						<col width="108">
						<col width="107">
						<col width="91">
						<col width="91">
						<col width="91">
						<col width="91">					
						<col width="91">
						<col width="92">
					</colgroup>
					<thead>
					<tr>
						<th class="first_bg">순위</th>
						<th>병원</th>
						<th>등급</th>
						<th>평균</th>
						<th>전문성<br/>(20%)</th>
						<th>안전성<br/>(30%)</th>
						<th>만족성<br/>(30%)</th>
						<th>규모성<br/>(10%)</th>
						<th>편의성<br/>(10%)</th>
						<th class="last_bg">지역랭킹</th>
					</tr>
					</thead>
					<tbody id="top100ranking">
					<%
						List<HashMap<String, Object>> data = (List<HashMap<String, Object>>)request.getAttribute("top50list");
					
						for ( int i = 0 ; i < data.size() ; i++){
							HashMap<String, Object> item = data.get(i);
							String tdclass = "";
							String overClass = "";
							if(i < 3){
								tdclass = "top123";
							}
							if(i %2 == 1){
								overClass = "back2";
							}
							
							String tr_class = "";
							
							if(i > 9){
								tr_class = "blind";
							}
					%>
					<tr class="<%=tr_class%>">
						<td class="<%=tdclass%> <%=overClass%>"><%=i+1 %></td>
						<td class="<%=tdclass%> <%=overClass%>"><a class="blue" href="${contextPath }/___/renew/hospital/info/<%=item.get("id")%>"><%=item.get("hospitalname") == null ? item.get("name") : item.get("hospitalname") %></a></td>
						<td class="<%=overClass%> red"><%=item.get("grade") %></td>
						<td class="<%=overClass%> skyblue"><%=String.format("%.2f", item.get("totalPoint"))  %></td>
						<td class="<%=overClass%>"><%=String.format("%.2f", item.get("safePoint")) %></td>
						<td class="<%=overClass%>"><%=String.format("%.2f", item.get("expertPoint")) %></td>
						<td class="<%=overClass%>"><%=String.format("%.2f", item.get("satisfyPoint")) %></td>					
						<td class="<%=overClass%>"><%=String.format("%.2f", item.get("sizePoint")) %></td>
						<td class="<%=overClass%>"><%=String.format("%.2f", item.get("convinientPoint")) %></td>
						<td class="<%=overClass%>"> - </td>
					</tr>
					<%} %>
					</tbody>
				</table>
				<script type="text/javascript">
				var curr_rot = 0;
				var rot_time = 3000;
				function top_ranking_rotation(){
					var first = curr_rot * 10;
					if(first == -1 ) first = 0;
					var end = first + 10;
					//console.log(first);
					//console.log(end);
					
					$('#top100ranking > tr').addClass('blind');
					$('#top100ranking > tr').slice(first, end).removeClass('blind');
					curr_rot++;
					if(curr_rot == 10) curr_rot = 0;
				}
				
				function start_rotation(){										
					setTimeout(start_rotation , rot_time );
					top_ranking_rotation();
				}
				
				start_rotation();
				</script>
			</div><!-- ranking_list -->
			
			<div class="all_ranking">
				<a href="${contextPath }/___/renew/hospital/list" class="goto_hospital_list">병원 리스트보기 &nbsp;&nbsp;  ▶</a>
				<a href="${contextPath }/___/renew/rank100" class="rank_all_link">모든 순위보기 &nbsp;&nbsp;  ▶</a>
			</div>
			
		</div><!-- rank_top -->
		
		<!-- 배너 -->
		<div class="banner_container">
			<img alt="" src="${contextPath }/img/slide/banner1.gif">
		</div>
		
		<div class="rank_top">
			<h3>정보 수정된 병원</h3>
			<div class="ranking_list">
				<table cellpadding="0" cellspacing="0" class="ranking_list_tb">
					<colgroup>
						<col width="64">
						<col width="134">
						<col width="108">
						<col width="107">
						<col width="91">
						<col width="257">
						<col width="199">
					</colgroup>
					<thead>
					<tr>
						<th class="first_bg">순위</th>
						<th>병원</th>
						<th>등급</th>
						<th>평균</th>
						<th>지역랭킹</th>
						<th>정보수정</th>
						<th class="last_bg">수정날짜</th>
					</tr>
					</thead>
					<tbody>
					<%
						List<HashMap<String, Object>> updated = (List<HashMap<String, Object>>)request.getAttribute("updated");
					
						for ( int i = 0 ; i < updated.size() ; i++){
							HashMap<String, Object> item = updated.get(i);
							
							String tdClass = "";
							if(i<3) tdClass = "top123";
					%>
					<tr>
						<td class="<%=tdClass%>"><%=i+1 %></td>
						<td class="<%=tdClass%> blue"><a class="blue" href="${contextPath }/___/renew/hospital/info/<%=item.get("id")%>"><%=item.get("name") %></a></td>
						<td class="red"><%=item.get("grade") %></td>
						<td class="skyblue"><%=String.format("%.2f",item.get("totalPoint") )%></td>
						<td>-</td>
						<td>가격정보, 병원정보</td>
						<td><%=item.get("updateDate") %>전</td>
					</tr>										
					<%}%>
					</tbody>
				</table>
			</div><!-- ranking_list -->
			
			<div class="all_ranking">
				<a href="${contextPath }/___/renew/hospital/list" class="goto_hospital_list">병원 리스트보기 &nbsp;&nbsp;  ▶</a>
				<a href="${contextPath }/___/renew/rank100" class="rank_all_link">모든 순위보기 &nbsp;&nbsp;  ▶</a>
			</div>
			
		</div><!-- rank_top -->
		
		<!-- 배너 -->
		<div class="banner_container">
			<img alt="" src="${contextPath }/img/slide/banner2.gif">
		</div>
		
		<!-- ranking -->
		<div class="rank_top">
			<h3><img src="${contextPath }/img/main/clock_icon.png">&nbsp; 최근 업데이트 된 병원</h3>
			<div class="ranking_list">
				<table cellpadding="0" cellspacing="0" class="ranking_list_tb">
					<colgroup>
						<col width="64">
						<col width="134">
						<col width="108">
						<col width="107">
						<col width="91">
						<col width="455">
					</colgroup>
					<thead>
					<tr>
						<th class="first_bg">순위</th>
						<th>병원</th>
						<th>등급</th>
						<th>평균</th>
						<th>지역랭킹</th>
						<th class="last_bg">병원소개</th>
					</tr>
					</thead>
					<tbody>
					<%
					List<HashMap<String, Object>> recent = (List<HashMap<String, Object>>)request.getAttribute("recent");
					
					for ( int i = 0 ; i < updated.size() ; i++){
						HashMap<String, Object> item = updated.get(i);
						
						String tdClass = "";
						if(i<3) tdClass = "top123";
					%>
					<tr>
						<td class="<%=tdClass%>"><%=i+1 %></td>
						<td class="<%=tdClass%> blue"><a class="blue" href="${contextPath }/___/renew/hospital/info/<%=item.get("id")%>"><%=item.get("name") %></a></td>
						<td class="red"><%=item.get("grade") %></td>
						<td class="skyblue"><%=String.format("%.2f",item.get("totalPoint") )%></td>
						<td>-</td>
						<%
							String intro = (String)item.get("introduction") == null ? "" : item.get("introduction").toString();
						
							if(intro.length() > 82){
								intro = intro.substring(0, 82) + "...";
							}
						%>
						<td class="update_info"><%=intro %></td>
					</tr>
					<%} %>
					</tbody>
				</table>
			</div><!-- ranking_list -->
			
			<div class="all_ranking">
				<a href="${contextPath }/___/renew/hospital/list" class="goto_hospital_list">병원 리스트보기 &nbsp;&nbsp;  ▶</a>
				<a href="${contextPath }/___/renew/rank100" class="rank_all_link">모든 순위보기 &nbsp;&nbsp;  ▶</a>
			</div>
			
		</div><!-- rank_top -->
	
	</div><!-- content -->
	
</div>
</div><!-- wrap -->
<%@include file="inc/footer.jsp"%>
</body>
</html>