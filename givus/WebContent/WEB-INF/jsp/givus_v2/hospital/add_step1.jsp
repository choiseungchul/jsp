<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<%@include file="../inc/loginchecker.jsp" %>
<%@include file="inc/add_hospital_script.jsp" %>
<script type="text/javascript">

var hnameDuplicate = true;

$(document).ready(function(){
	
	if(!Browser.ie7){
		$('input').corner('keep 5px');	
	}
	
	
	$('#srch_addr').keyup(function(e){
		if(e.which === 13){
			getZipcode();
		}
	});
});

function add_step1(){
	var msg = validate(); 
	if(msg == 'OK'){
		$('#frm').attr('action', '${contextPath}/___/renew/hospital/addproc/step1');
		$('#frm').attr('method', 'post');		
		$('#frm').submit();
		
	}else{
		alert(msg);
	}
}

function validate(){
	
	if($('#hos_name').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.input.hname.empty")%>';
	}
	
	if($('#busy_id_num').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.input.businessId.empty")%>';		
	}
	if($('#tel1').val() == '' || $('#tel2').val() == '' || $('#tel3').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.input.tel.empty")%>';
	}
	if($('#address1').val() == '' || $('#address2').val() == '' || $('#post1').val() == '' || $('#post2').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.input.address.empty")%>';
	}
	if($('#locations option:selected').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.input.location.empty")%>';
	}
	
	if(hnameDuplicate){
		return '<%=MessageHandler.getMessage("join.hospital.duplicate.name")%>';
	}	
	
	return 'OK';
}
</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title pt25">
		<h1>병원등록</h1>
	</div>
	<div class="content">

		<div class="addr_layer addhos">
			<div class="addr_input">
				<span class="close_btn" onclick="closeZipcode();">X</span>
				<h3 class="addr_layer_title">검색할 읍/면/동 이름을 여기에 입력해주세요</h3>			
				<div class="myinfo_addr pt10">
					<input type="text" class="addr_layer_input" id="srch_addr">
					<a href="javascript:getZipcode()" class="btn_find_bg">검색</a>
				</div>
			</div>
			<div class="zipcode_list">
				<ul id="zipcode">				
				</ul>
			</div>
		</div><!-- addr_layer -->
	
		<div class="hospital_tab add_form">
			<ul>
				<li class="on white"><span>STEP 01.</span><strong>기본정보등록</strong></li>
				<li class="divide"><span>STEP 02.</span><strong>병원소개등록</strong></li>
				<li><span>STEP 03.</span><strong>등록완료</strong></li>
			</ul>
		</div>
		<form id="frm" name="frm">
		<div class="hos_add_form">
			<table cellpadding="0" cellspacing="0" class="hos_add_form_tb">
				<colgroup>
					<col width="178">
					<col width="375"> 
					<col width="407">
				</colgroup>
				<tbody>
				<tr>
					<td class="tit">병원명</td>
					<td class="cont">
						<input type="text" class="hos_add_input" name="name" id="hos_name">						
					</td>
					<td class="cont">
						<a href="javascript:checkName();" class="btn_hos_check_bg">병원명 중복확인</a>
						<span class="hos_name_alert"></span>
					</td>
				</tr>
				<tr>
					<td class="tit">사이트주소</td>
					<td class="cont">
						<input type="text" class="hos_add_input" name="homepage" id="homepage">						
					</td>
					<td class="cont"></td>
				</tr>
				<tr>
					<td class="tit">사업자등록번호</td>
					<td class="cont">
						<input type="text" class="hos_add_input" name="busy_id_num" id="busy_id_num">						
					</td>
					<td class="cont"></td>
				</tr>				
				<tr>
					<td class="tit">전화번호</td>
					<td class="cont">
						<input type="text" class="hos_num_input" name="tel1" maxlength="3" id="tel1">
						-
						<input type="text" class="hos_num_input" name="tel2" maxlength="4" id="tel2">
						-
						<input type="text" class="hos_num_input" name="tel3" maxlength="4" id="tel3">
					</td>
					<td class="cont"></td>
				</tr>
				<tr>
					<td class="tit">팩스번호</td>
					<td class="cont">
						<input type="text" class="hos_addr_input" name="fax" id="fax">
					</td>
					<td class="cont"></td>
				</tr>
				<tr>
					<td class="tit" rowspan="2">주소</td>
					<td class="cont" colspan="2">
						<a href="javascript:openZipcode()" class="btn_find_bg">찾기</a>
						<input type="text" class="hos_num_input" name="post1" maxlength="3" id="post1">
						-
						<input type="text" class="hos_num_input" name="post2" maxlength="3" id="post2">
						
						<input type="text" class="hos_addr_input" name="addr1" id="address1">
					</td>
					<td class="cont"></td>
				</tr>
				<tr>
					<td class="cont" colspan="2">
						<span>상세주소</span>
						<input type="text" class="hos_addr_input" name="addr2" id="address2">
					</td>
				</tr>
				<tr>
					<td class="tit" >지역</td>
					<td class="cont" colspan="2">						
						<select id="locations" name="location" class="hos_add_input">
							<option value="">--지역선택--</option>
							<%
								List<HashMap<String, Object>> location = (List<HashMap<String, Object>>)request.getAttribute("location");
								
								for(int i = 0 ; i < location.size(); i++){
									HashMap<String, Object> data = location.get(i);
							%>							
							<option value="<%=data.get("code").toString()%>"><%=data.get("name").toString() %></option>
							<% } %>
						</select>
					</td>
				</tr>
				</tbody>
			</table>
		</div><!-- hos_add_form -->
		
		<div class="add_hos_btns">
			<a href="javascript:add_step1();" class="btn_myinfo_send on">확인</a>
			<a href="javascript:location.href='${contextPath }/___/renew/main'" class="btn_myinfo_send">취소</a>
		</div>
		
		</form>
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>