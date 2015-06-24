<%@page import="javax.swing.text.Position"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@page import="kr.co.zadusoft.givus.util.GivusUtil"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>

<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/mypage.css?noc=<%=System.currentTimeMillis() %>" />
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<script type="text/javascript" src="${contextPath}/script/jquery.filestyle.js"></script>
<script type="text/javascript" src="${contextPath}/script/jquery.form.js"></script>
<title></title>
<script type="text/javascript">

$(document).ready(function(){
	
	// 폼 placeholder
	$('.hos_add_input').focus(function(){
		$(this).prev('label').hide();
	});
	$('.hos_add_input').blur(function(){
		if($(this).val() == ''){
			$(this).prev('label').show();
		} 
	});
	$('.hos_add_label').click(function(){
		$(this).hide();
		$(this).next('input').focus();
	});
	
	$('.hos_add_label').each(function(){
		if($(this).next().val() != ''){
			$(this).hide();
		} 
	});
	
	$('input[type=file]').change(function(){		
		var idx = $('input[type=file]').index(this);
		
		var frmid = 'frm_pic' + idx;
		var imgcontainer = $('.preview_img').eq(idx).find('img');
		
		send_file(frmid, imgcontainer, idx);
	});
	
	$('.origin_over').mouseenter(function(){
		var url = $(this).attr('origin-url');
		if(url == undefined) return false;
		
		var img = $('<img src="" />').attr('src', url);
		
		var loc = $(this).offset();
		
		$('.preview_image_content').empty()
		.append(img)
		.show().css({
			top : loc.top,
			left : loc.left + 15
		});
	});
	
	$('.origin_over').mousemove(function(e){	
		if($('.preview_image_content').is(':visible')){
			$('.preview_image_content').css({
				top : e.pageY,
				left : e.pageX + 15
			});
		}
		
	});
	
	$('.origin_over').mouseleave(function(){
		$('.preview_image_content').hide();
	})
	
	$('.doctor').show();
});

function send_info(){
	if(confirm('<%=MessageHandler.getMessage("myhospital.modify.alert")%>')){
		document.frm.submit();	
	}		
}

//이미지 업로드
function send_file(frmid, imgcontainer, idx){
	var options = {
		type:"POST",
		dataType:"text",
		beforeSubmit: function(formData, jqForm, options) {
			//console.log(formData);
        },
		success: function(responseText, statusText, xhr, $form) {
			//console.log(responseText);
            if(statusText == 'success'){
            	//console.log("res text = " + responseText);
				var obj = $.parseJSON(responseText);
				
				var list = obj.files;
				if(list.length > 0){
					var rs = list[0];
					var url = rs.url;
					var thumbUrl = rs.thumbnailUrl;
					var id = rs.id;
					
					if(idx != 0){
						$(imgcontainer).attr('src', thumbUrl);
						$(imgcontainer).attr('origin-url', url);
					}else{
						$(imgcontainer).attr('src', url);
					}
					
					$('input[name=pic' + idx + ']').val(id);
					
				}else{
					// 오류
				}			
            }
        },
        error: function(data){
	        console.log(data);
        }
    };
	$('#'+frmid).attr('action', '${contextPath }/___/file/upload');
	$("#"+frmid).ajaxSubmit(options);
}

</script>
<%
	if(um != null){
		if(um.getEmail() == null){
			// 로그인안됨
			
%>
<script>
alert('로그인 후 사용해주세요!');
history.back();
</script>
<%
		}
	}
	
%>
<%
	
	HashMap<String, Object> hospital = (HashMap<String, Object>)request.getAttribute("hospital");
	HashMap<String, Object> hos_stat = (HashMap<String, Object>)request.getAttribute("hos_stat");
	
	List<HashMap<String, Object>> thumb5 = (List<HashMap<String, Object>>)request.getAttribute("thumb5");
	List<HashMap<String, Object>> location = (List<HashMap<String, Object>>)request.getAttribute("location");

%>
<style>
input.hos_add_input{
	width: 182px !important;
}
.hos_add_form{	
	border: 4px solid #f2f2f2;
	width: 720px;
}
.hos_stat_input{
	width: 80px !important;
}
.hos_add_label{
	width: 100px;
}
.hos_add_status{
	width: 590px;
	height: 233px;
}
.hos_intro_text_ta{
	width: 555px;
}
.hos_add_status ul li{
	width: 126px;
}
.doctor{
	display: block !important;
	margin-top: 18px !important;
	position: static !important;
	line-height: 0px !important;
}
.hos_add_status ul li{
	height: 53px;
}

</style>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	
	<div class="addr_layer">
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
	
	<div class="content">
		<div class="left_menu">
			<%@include file="inc/left.jsp" %>		
		</div>
		
		<div class="right_content">
			<form id="frm" name="frm" action="${contextPath }/___/renew/mypage/myhintromod" method="post">
				<input type="hidden" name="hid" value="<%=hospital.get("id")%>">
				
				<input type="hidden" name="pic0" value="">
				<input type="hidden" name="pic1" value="">
				<input type="hidden" name="pic2" value="">
				<input type="hidden" name="pic3" value="">
				<input type="hidden" name="pic4" value="">
				<input type="hidden" name="pic5" value="">			
				
			<div class="hos_add_form">
				<table cellpadding="0" cellspacing="0" class="hos_add_form_tb">
					<colgroup>
						<col width="108">
						<col width="252">
						<col width="108">
						<col width="252">
					</colgroup>
					<tbody>
					<tr>
						<td class="tit">주요수술 1</td>
						<td class="cont">
							<label class="hos_add_label">ex)눈,코,양악,안면윤곽,쁘띠,가슴,돌출입 등</label>
							<input type="text" class="hos_add_input" name="mOper1" value="${hospital.mostOperation1 }">						
						</td>
						<td class="tit">주요수술 2</td>
						<td class="cont">
							<label class="hos_add_label">ex)눈,코,양악,안면윤곽,쁘띠,가슴,돌출입 등</label>
							<input type="text" class="hos_add_input" name="mOper2" value="${hospital.mostOperation2 }">
						</td>
					</tr>
					<tr>
						<td class="tit">진료의수</td>
						<td class="cont">
							<label class="hos_add_label type2">0 ~ 100</label>
							<input type="text" class="hos_add_input " name="sp_count" value="${hospital.specialistCount }"> 명						
						</td>
						<td class="tit">마취과수</td>
						<td class="cont">
							<label class="hos_add_label type2">0 ~ 5</label>
							<input type="text" class="hos_add_input " name="an_count" value="${hospital.anestheticCount }"> 명
						</td>
					</tr>
					<tr>
						<td class="tit">온라인상담수</td>
						<td class="cont">
							<label class="hos_add_label type2">1천건 ~ 10만건(1천단위)</label>
							<input type="text" class="hos_add_input " name="cou_count" value="${hospital.counselCount }"> 건					
						</td>
						<td class="tit">전후사진수</td>
						<td class="cont">
							<label class="hos_add_label type2">0건 ~ 1만건(1백단위)</label>
							<input type="text" class="hos_add_input " name="pic_count" value="${hospital.reviewPicCount }"> 건
						</td>
					</tr>
					<tr>
						<td class="tit">외국인유치</td>
						<td class="cont">
							<label class="hos_add_label">등록 / 미등록</label>
							<input type="text" class="hos_add_input " name="foreign" value="${hospital.foreignerReg }">					
						</td>
						<td class="tit">통역여부</td>
						<td class="cont">
							<label class="hos_add_label">영어,중국어,러시아어,일본어,몽골어...</label>
							<input type="text" class="hos_add_input " name="inter" value="${hospital.interpreter }">
						</td>
					</tr>
					<tr>
						<td class="tit">병원크기</td>
						<td class="cont">
							<label class="hos_add_label">1개층 ~ 5개층</label>
							<input type="text" class="hos_add_input " name="scale" value="${hospital.scale }">						
						</td>
						<td class="tit">픽업서비스</td>
						<td class="cont">
							<label class="hos_add_label">있음 / 조건부 / 없음</label>
							<input type="text" class="hos_add_input " name="pickup" value="${hospital.pickupService }">
						</td>
					</tr>
					<tr>
						<td class="tit">입원실</td>
						<td class="cont">
							<label class="hos_add_label type2">있음/없음</label>						
							<input type="text" class="hos_add_input " name="proom" value="${hospital.patientRoom }">					
						</td>
						
						<td class="tit">회복실</td>
						<td class="cont">
							<label class="hos_add_label type2">있음/없음</label>
							<input type="text" class="hos_add_input " name="rroom" value="${hospital.recoveryRoom }">
						</td>
					</tr>
					<tr>
						<td class="tit">과별전문의</td>
						<td class="cont" colspan="3">
							<div class="hos_add_status">
								<ul>
									<li>
										<label class="hos_add_label type2 doctor">구강과</label>
										<input type="text"  class="hos_stat_input " name="hstat1" value="${hos_stat.oralDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">치과</label>
										<input type="text"  class="hos_stat_input " name="hstat2" value="${hos_stat.dentalDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">가슴</label>
										<input type="text"  class="hos_stat_input " name="hstat3" value="${hos_stat.breastDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">교정</label>
										<input type="text"  class="hos_stat_input " name="hstat4" value="${hos_stat.orthodonticDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">이비인후과</label>
										<input type="text"  class="hos_stat_input " name="hstat5" value="${hos_stat.otolaryngologyDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">외과</label>
										<input type="text"  class="hos_stat_input " name="hstat6" value="${hos_stat.surgeryDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">성형외과</label>
										<input type="text"  class="hos_stat_input " name="hstat7" value="${hos_stat.plasticSurgeryDoctorCount }">명
									</li>								
									<li>
										<label class="hos_add_label type2 doctor">마취과</label>
										<input type="text"  class="hos_stat_input " name="hstat8" value="${hos_stat.anestheticDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">가정의과</label>
										<input type="text"  class="hos_stat_input " name="hstat9" value="${hos_stat.familyMedicineDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">일반</label>
										<input type="text"  class="hos_stat_input " name="hstat10" value="${hos_stat.generalDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">임상</label>
										<input type="text"  class="hos_stat_input " name="hstat11" value="${hos_stat.clinicalDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">비만</label>
										<input type="text"  class="hos_stat_input " name="hstat12" value="${hos_stat.obesityDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">피부과</label>
										<input type="text"  class="hos_stat_input " name="hstat13" value="${hos_stat.dermatologistDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">보철</label>
										<input type="text"  class="hos_stat_input " name="hstat14" value="${hos_stat.prostheticDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor" >임플란트</label>
										<input type="text"  class="hos_stat_input " name="hstat15" value="${hos_stat.implantsDoctorCount }">명
									</li>
									<li>
										<label class="hos_add_label type2 doctor">산부인과</label>
										<input type="text"  class="hos_stat_input " name="hstat16" value="${hos_stat.obstetricsDoctorCount }">명
									</li>
								</ul>							
							</div>
							<div class="clear"></div>					
						</td>
					</tr>				
					<tr>
						<td class="tit">가능수술</td>
						<td class="cont" colspan="3">
							<label class="hos_add_label">ex) 눈,코,양악,안면윤곽, 쁘띠, 가슴, 돌출입 등</label>
							<input type="text" class="hos_add_input" name="surg_list" value="${hospital.possibleSurgery }">						
						</td>
					</tr>
					<tr>
						<td class="tit">진료시간</td>
						<td class="cont" colspan="3">
							<label class="hos_add_label">ex) 평일 10:00-19:00, 점심 13:00~14:00, 토요일 10:00~17:00, 진료특이사항, 정보 없음</label>
							<input type="text" class="hos_add_input" name="open_time" value="${hospital.hours }">						
						</td>
					</tr>
					<tr>
						<td class="tit">병원소개글</td>
						<td class="cont" colspan="3">
							<textarea class="hos_intro_text_ta" name="intro">${hospital.introduction }</textarea>						
						</td>
					</tr>
					</tbody>
				</table>
			</div><!-- hos_add_form -->
			</form>
			
			<div class="pic_upload_cont">
				<div class="left pic_upload_cont_title mypage">
					사진등록
				</div>
				<div class="left pic_upload_cont_uploadform mypage">
					<div class="preview_img">
						<img alt="" src="${contextPath }/___/file/get/${hospital.fid}" class="prev_image big">
					</div>
					<form name="frm_pic0" id="frm_pic0" enctype="multipart/form-data">
						<input type="file" name="thumb_main" class="thumb_input ml0">						
						<p class="pt25">우리병원의 모든 썸네일 사진입니다. 권장사이즈 214x160 (jpg, gif, png)</p>				
					</form>						
					<div class="hos_pic_upload mypage">
					<ul>					
						<%		
							int exSize = thumb5.size();
						
							for(int a = 1 ; a <= 5 ; a++){
								
								if(exSize > (a-1)){
									HashMap<String, Object> data = thumb5.get(a-1);						
						%>		
						<li>
							<div class="preview_img">								
								<img alt="" src="${contextPath }/___/file/get/<%=data.get("id").toString() %>" class="prev_image origin_over">
							</div>
							<div class="left">
								<form name="frm_pic<%=a %>" id="frm_pic<%=a %>" enctype="multipart/form-data">
									<label>상세사진<%=a %> : </label>
									<input type="file" class="thumb_input mypage" name="thumb<%=a %>">
								</form>
							</div>							
						</li>
						<% }else{
						%>
						<li>
							<div class="preview_img">								
								<img alt="" src="${contextPath }/img/no_img.png" class="prev_image origin_over">
							</div>
							<div class="left">
								<form name="frm_pic<%=a %>" id="frm_pic<%=a %>" enctype="multipart/form-data">
									<label>상세사진<%=a %> : </label>
									<input type="file" class="thumb_input mypage" name="thumb<%=a%>">
								</form>
							</div>							
						</li>
						<%
							}
						} %>						
					</ul>
				</div>
					<div class="clear thumb_upload_text">병원정보 페이지에서 보여지는 상세사진입니다. 홈페이지캡쳐,이벤트 등. 권장사이즈: 460x320 (jpg,gif,png)</div>
				</div>
				<div class="clear"></div>
			</div>
			
	
			<div class="add_hos_btns pd60">
				<a href="javascript:send_info();" class="btn_myinfo_send on">확인</a>
				<a href="" class="btn_myinfo_send">취소</a>
			</div>
		</div><!-- right_content -->
	
	</div>
	
</div>
</div>
<div class="preview_image_content">
	<img alt="" src="" id="preview_img">
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>