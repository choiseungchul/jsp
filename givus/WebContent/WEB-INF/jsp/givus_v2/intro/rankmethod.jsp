<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/intro.css?noc=<%=System.currentTimeMillis() %>" />
<title>순위방식</title>
<script type="text/javascript">
$(document).ready(function(){
	$('.m6').addClass('sub on');
});
</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">	
	<div class="content">
		<h3 class="compare_tit">순위방식</h3>
		<div class="rank_info_title">
			<div class="left rank_info_title_img">
				<img alt="" src="${contextPath }/img/intro/hospital_icon.png" />
			</div>
			<div class="left rank_info_title_desc">
				<p class="givus_title">WE GIVE TRUST INFORMATION</p>
				<div class="givus_title_msg">
					<p class="left big">GIV</p>
					<p class="left big2">US</p>
					<p class="left small">성형외과 선택의 기준</p>
				</div>				
			</div>
		</div><!-- rank_info_title -->
		
		<div class="clear rankinfo_title2">
			<h4>“GIVUS” 병원랭킹 선정기준</h4>
			<div class="rank_info_bg">
				<div class="rankinf_bg_injectin">
					<img alt="" src="${contextPath }/img/intro/rank_info_center_a.png">
				</div>
				<div class="rankinfo_list list_type pos1">
					<h5>편의성(10%)</h5>
					<ul>
						<li>1. 온라인 상담건수</li>
						<li>2. 수술후 고객게시판 여부</li>
						<li>3. 입원실규모 및 유무
						</li>
						<li>4. 회복실규모 및 유무</li>
						<li>5. 시설 퀄리티</li>
						<li>6. 가상성형지원</li>
					</ul>
				</div>
				
				<div class="rankinfo_list list_type pos2">
					<h5>규모성(10%)</h5>
					<ul>
						<li>1. 의료진수</li>
						<li>2. 병원사이즈</li>
						<li>3. 번역사이트 유무</li>
						<li>4. 통역유무</li>
						<li>5. 픽업서비스</li>
						<li>6. 사회공헌여부</li>
					</ul>
				</div>
				
				<div class="rankinfo_list list_type pos3">
					<h5>만족성(30%)</h5>
					<ul>
						<li>1. 홈페이지 전후사진 수</li>
						<li>2. 서비스클레임 유무</li>
						<li>3. 후기만족도</li>
						<li>4. 연예인 방문여부</li>
						<li>5. 수상여부</li>
						<li>6. 붓기치료 여부</li>
						<li>7. 주차별 프로그램관리</li>
					</ul>
				</div>
				
				<div class="rankinfo_list list_type pos4">
					<h5>전문성(20%)</h5>
					<ul>
						<li>1. 성형외과 전공의 여부</li>
						<li>2. 과별수술진행</li>
						<li>3. 신수술법</li>
						<li>4. 업계평판</li>						
						<li>(언론기사,봉사활동 등)</li>
					</ul>
				</div>
				
				<div class="rankinfo_list list_type pos5">
					<h5>안전성(30%)</h5>
					<ul>
						<li>1. 마취과 유무</li>
						<li>2. 수술건수</li>
						<li>3. 최신의료기기 보유여부</li>
						<li>4. 수술클레임 <br/></li>
						<li>(정부공개 및 언론기사 등)</li>						
					</ul>
				</div><!-- rankinfo_list -->
				
				<div class="rankinfo_bottom">
					5가지 카테고리, 27개 평가 지표 기준
				</div>
			</div>
		</div><!-- rankinfo_title2 -->
		
		<div class="clear rankinfo_title2">
			<h4 class="pb68">“GIVUS” 등급정의</h4>
			
			<div class="grade_infomation">
				<div class="left grade_icn_bg">AAA</div>
				<div class="left grade_desc_list">
					<h4>국내 Top Class 수준 병원</h4>
					<p>전국 성형외과 <span class="grade_info_color">상위 5% 이내</span> 수준 병원 </p>
					<p>“ AAA ” 그룹 병원들은 평가지표 순위에 따라 “+, 0, -” 등급으로 재 분류 됩니다.</p>
				</div>
			</div>
			
			<div class="grade_infomation clear">
				<div class="left grade_icn_bg">AA</div>
				<div class="left grade_desc_list">
					<h4>국내 High Class 수준 병원</h4>
					<p>전국 성형외과 <span class="grade_info_color">상위 5%~10%  이내</span> 수준 병원 </p>
					<p> “ AA ” 그룹 병원들은 평가지표 순위에 따라 “+, 0, -” 등급으로 재 분류 됩니다.</p>
				</div>
			</div>
			
			<div class="grade_infomation clear">
				<div class="left grade_icn_bg">A</div>
				<div class="left grade_desc_list">
					<h4>안정적인 성형 서비스 제공 병원</h4>
					<p>전국 성형외과 <span class="grade_info_color">상위 10%~20% 이내</span> 수준 병원 </p>
					<p>“ A ” 그룹 병원들은 평가지표 순위에 따라 “+, 0, -” 등급으로 재 분류 됩니다.</p>
				</div>
			</div>
		</div><!-- rankinfo_title2 -->
		
		<div class="rankinfo_final">
			<p>“GIVUS”의 모든 평가는 전문가, 패널, 설문조사 등의 객관적인 평가와 </p>
			<p>자사 주관적 평가 5%를 통합하여 이루어집니다.</p>
		</div>
		
	</div>
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>