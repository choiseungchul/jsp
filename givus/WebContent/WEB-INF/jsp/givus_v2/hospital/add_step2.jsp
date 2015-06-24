<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	HashMap<String, String> step1_param = (HashMap<String, String>)request.getAttribute("step1_param");
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript" src="${contextPath}/script/jquery.filestyle.js"></script>
<script type="text/javascript" src="${contextPath}/script/jquery.form.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	if(!Browser.ie7){
		$('input').corner('keep 5px');	
	}
	
	
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
	
	$("input[type=file]").filestyle({ 
	     image: "${contextPath}/img/common/input_file_image.png",
	     imageheight : 33,
	     imagewidth : 60,
	     width : 101
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
	
	// 숫자체크
	$("input[name=sp_count], input[name=an_count]").keypress(function (e) {		
	    return numberCheck(e);
	});
	$("input[name=sp_count], input[name=an_count]").keyup(function(e){
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
        }
	});
	$("input[name=cou_count], input[name=pic_count]").keypress(function (e) {
	    return numberCheck(e);
	});
	$("input[name=cou_count], input[name=pic_count]").keyup(function(e){
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
        }
	});
	
	$("input[name=proom], input[name=rroom]").keypress(function (e) {
	    return numberCheck(e);
	});
	$("input[name=proom], input[name=rroom]").keyup(function(e){
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
        }
	});
	$(".hos_add_status ul li input").keypress(function (e) {		 
	    return numberCheck(e);
	});
	$(".hos_add_status ul li input").keyup(function(e){
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
        }
	});
});

function numberCheck(e){
	
	if(e.which){
		if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	     	return false;  
	    }
	}else{
		return false;
	}	
	return true;
}

function send_info(){
	var msg = validate();
	if(validate() == 'OK'){
		$.ajax({
			url : '${contextPath}/___/renew/hospital/addnew',
			type :'post',
			data: $("#frm").serialize(),
			dataType : 'json',
			success: function(data){
				//console.log(data);
				if(data.code == 0){
					location.href='${contextPath}/___/renew/hospital/add3';
				}else{
					alert(data.msg);
				}
			}
		});
	}else{
		alert(msg);
	}
}

function validate(){
	if($('input[name=mOper1]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.moper1")%>';
	}
	if($('input[name=mOper2]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.moper2")%>';
	}
	if($('input[name=sp_count]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.sp_count")%>';
	}
	if($('input[name=an_count]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.an_count")%>';
	}
	if($('input[name=foreign]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.foreign")%>';
	}
	if($('input[name=inter]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.inter")%>';
	}
	if($('input[name=surg_list]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.surg_list")%>';
	}
	if($('input[name=open_time]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.open_time")%>';
	}
	if($('input[name=intro]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.intro")%>';
	}
	if($('input[name=proom]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.proom")%>';
	}
	if($('input[name=rroom]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.rroom")%>';
	}
	
	var doc_count = 0;
	
	for(var i = 1 ; i <= 16 ; i++){
		var c = $('input[name=hstat'+i+']').val();
		if(c != ''){
			doc_count += parseInt(c);
		}
	}
	
	var curr_doc_count = $('input[name=spcount]').val();
	
	
	return 'OK';
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
	
		<div class="hospital_tab add_form">
			<ul>
				<li class="divide"><span>STEP 01.</span><strong>기본정보등록</strong></li>
				<li class="on white"><span>STEP 02.</span><strong>병원소개등록</strong></li>
				<li><span>STEP 03.</span><strong>등록완료</strong></li>
			</ul>
		</div>
		<form id="frm" name="frm">
			<input type="hidden" name="pic0" value="">
			<input type="hidden" name="pic1" value="">
			<input type="hidden" name="pic2" value="">
			<input type="hidden" name="pic3" value="">
			<input type="hidden" name="pic4" value="">
			<input type="hidden" name="pic5" value="">			
			<%
				//파라미터 쓰기
				for(Map.Entry<String, String> param : step1_param.entrySet()){
					out.println("<input type=\"hidden\" name=\""+param.getKey()+"\" value=\""+param.getValue()+"\">");
				}
			%>			
		<div class="hos_add_form">
			<table cellpadding="0" cellspacing="0" class="hos_add_form_tb">
				<colgroup>
					<col width="148">
					<col width="332">
					<col width="149">
					<col width="331">
				</colgroup>
				<tbody>
				<tr>
					<td class="tit">주요수술 1</td>
					<td class="cont">
						<label class="hos_add_label">ex)눈,코,양악,안면윤곽,쁘띠,가슴,돌출입 등</label>
						<input type="text" class="hos_add_input w298" name="mOper1">						
					</td>
					<td class="tit">주요수술 2</td>
					<td class="cont">
						<label class="hos_add_label">ex)눈,코,양악,안면윤곽,쁘띠,가슴,돌출입 등</label>
						<input type="text" class="hos_add_input w298" name="mOper2">
					</td>
				</tr>
				<tr>
					<td class="tit">진료의수</td>
					<td class="cont">
						<label class="hos_add_label type2">0 ~ 100</label>
						<input type="text" class="hos_add_input w258" name="sp_count"> 명						
					</td>
					<td class="tit">마취과수</td>
					<td class="cont">
						<label class="hos_add_label type2">0 ~ 5</label>
						<input type="text" class="hos_add_input w258" name="an_count"> 명
					</td>
				</tr>
				<tr>
					<td class="tit">온라인상담수</td>
					<td class="cont">
						<label class="hos_add_label type2">1천건 ~ 10만건(1천단위)</label>
						<input type="text" class="hos_add_input w258" name="cou_count"> 건					
					</td>
					<td class="tit">전후사진수</td>
					<td class="cont">
						<label class="hos_add_label type2">0건 ~ 1만건(1백단위)</label>
						<input type="text" class="hos_add_input w258" name="pic_count"> 건
					</td>
				</tr>
				<tr>
					<td class="tit">외국인유치</td>
					<td class="cont">
						<label class="hos_add_label">등록 / 미등록</label>
						<input type="text" class="hos_add_input w258" name="foreign">					
					</td>
					<td class="tit">통역여부</td>
					<td class="cont">
						<label class="hos_add_label">영어,중국어,러시아어,일본어,몽골어...</label>
						<input type="text" class="hos_add_input w258" name="inter">
					</td>
				</tr>
				<tr>
					<td class="tit">병원크기</td>
					<td class="cont">
						<label class="hos_add_label">1개층 ~ 5개층</label>
						<input type="text" class="hos_add_input w258" name="scale">						
					</td>
					<td class="tit">픽업서비스</td>
					<td class="cont">
						<label class="hos_add_label">있음 / 조건부 / 없음</label>
						<input type="text" class="hos_add_input w258" name="pickup">
					</td>
				</tr>
				<tr>
					<td class="tit">입원실</td>
					<td class="cont">
						<label class="hos_add_label type2">있음/없음</label>						
						<input type="text" class="hos_add_input w258" name="proom">					
					</td>
					
					<td class="tit">회복실</td>
					<td class="cont">
						<label class="hos_add_label type2">있음/없음</label>
						<input type="text" class="hos_add_input w258" name="rroom">
					</td>
				</tr>
				<tr>
					<td class="tit">과별전문의</td>
					<td class="cont" colspan="3">
						<div class="hos_add_status">
							<ul>
								<li>
									<label class="hos_add_label type2">구강과</label>
									<input type="text"  class="hos_add_input w130" name="hstat1" >명
								</li>
								<li>
									<label class="hos_add_label type2">치과</label>
									<input type="text"  class="hos_add_input w130" name="hstat2" >명
								</li>
								<li>
									<label class="hos_add_label type2">가슴</label>
									<input type="text"  class="hos_add_input w130" name="hstat3" >명
								</li>
								<li>
									<label class="hos_add_label type2">교정</label>
									<input type="text"  class="hos_add_input w130" name="hstat4" >명
								</li>
								<li>
									<label class="hos_add_label type2">이비인후과</label>
									<input type="text"  class="hos_add_input w130" name="hstat5" >명
								</li>
								<li>
									<label class="hos_add_label type2">외과</label>
									<input type="text"  class="hos_add_input w130" name="hstat6" >명
								</li>
								<li>
									<label class="hos_add_label type2">성형외과</label>
									<input type="text"  class="hos_add_input w130" name="hstat7" >명
								</li>								
								<li>
									<label class="hos_add_label type2">마취과</label>
									<input type="text"  class="hos_add_input w130" name="hstat8" >명
								</li>
								<li>
									<label class="hos_add_label type2">가정의과</label>
									<input type="text"  class="hos_add_input w130" name="hstat9" >명
								</li>
								<li>
									<label class="hos_add_label type2">일반</label>
									<input type="text"  class="hos_add_input w130" name="hstat10" >명
								</li>
								<li>
									<label class="hos_add_label type2">임상</label>
									<input type="text"  class="hos_add_input w130" name="hstat11" >명
								</li>
								<li>
									<label class="hos_add_label type2">비만</label>
									<input type="text"  class="hos_add_input w130" name="hstat12" >명
								</li>
								<li>
									<label class="hos_add_label type2">피부과</label>
									<input type="text"  class="hos_add_input w130" name="hstat13" >명
								</li>
								<li>
									<label class="hos_add_label type2">보철</label>
									<input type="text"  class="hos_add_input w130" name="hstat14" >명
								</li>
								<li>
									<label class="hos_add_label type2">임플란트</label>
									<input type="text"  class="hos_add_input w130" name="hstat15" >명
								</li>
								<li>
									<label class="hos_add_label type2">산부인과</label>
									<input type="text"  class="hos_add_input w130" name="hstat16" >명
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
						<input type="text" class="hos_add_input w698" name="surg_list">						
					</td>
				</tr>
				<tr>
					<td class="tit">진료시간</td>
					<td class="cont" colspan="3">
						<label class="hos_add_label">ex) 평일 10:00-19:00, 점심 13:00~14:00, 토요일 10:00~17:00, 진료특이사항, 정보 없음</label>
						<input type="text" class="hos_add_input w698" name="open_time">						
					</td>
				</tr>
				<tr>
					<td class="tit">병원소개글</td>
					<td class="cont" colspan="3">
						<textarea class="hos_intro_text_ta" name="intro"></textarea>						
					</td>
				</tr>					
				</tbody>
			</table>
		</div><!-- hos_add_form -->
		</form>
		
		<div class="pic_upload_cont">
			<div class="left pic_upload_cont_title">
				사진등록
			</div>
			<div class="left pic_upload_cont_uploadform">
				<div class="preview_img">
					<img alt="" src="" class="prev_image big">
				</div>
				<form name="frm_pic0" id="frm_pic0" enctype="multipart/form-data">
					<input type="file" name="thumb_main" class="thumb_input ml0">						
					<p class="pt25">우리병원의 모든 썸네일 사진입니다. 권장사이즈 214x160 (jpg, gif, png)</p>				
				</form>						
				<div class="hos_pic_upload">
					<ul>										
						<li>
							<div class="preview_img">								
								<img alt="" src="" class="prev_image origin_over">
							</div>
							<form name="frm_pic1" id="frm_pic1" enctype="multipart/form-data">
								<label>상세사진1 : </label>
								<input type="file" class="thumb_input" name="thumb1">
							</form>
						</li>
						<li>
							<div class="preview_img">
								<img alt="" src="" class="prev_image origin_over">
							</div>
							<form name="frm_pic2" id="frm_pic2" enctype="multipart/form-data">
								<label>상세사진2 : </label>
								<input type="file" class="thumb_input" name="thumb2">
							</form>
						</li>
						<li>
							<div class="preview_img">
								<img alt="" src="" class="prev_image origin_over">
							</div>
							<form name="frm_pic3" id="frm_pic3" enctype="multipart/form-data">
								<label>상세사진3 : </label>
								<input type="file" class="thumb_input" name="thumb3">
							</form>
						</li>
						<li>
							<div class="preview_img">
								<img alt="" src="" class="prev_image origin_over">
							</div>
							<form name="frm_pic4" id="frm_pic4" enctype="multipart/form-data">
								<label>상세사진4 : </label>
								<input type="file" class="thumb_input" name="thumb4">
							</form>
						</li>
						<li>
							<div class="preview_img">
								<img alt="" src="" class="prev_image origin_over">
							</div>
							<form name="frm_pic5" id="frm_pic5" enctype="multipart/form-data">
								<label>상세사진5 : </label>
								<input type="file" class="thumb_input" name="thumb5">
							</form>
						</li>								
					</ul>
				</div>
				<div class="clear thumb_upload_text">병원정보 페이지에서 보여지는 상세사진입니다. 홈페이지캡쳐,이벤트 등. 권장사이즈: 460x320 (jpg,gif,png)</div>
			</div>
			<div class="clear"></div>
		</div>
		

		
		<div class="add_hos_btns">
			<a href="javascript:send_info();" class="btn_myinfo_send on">확인</a>
			<a href="" class="btn_myinfo_send">취소</a>
		</div>
	</div>
	
</div>
</div>
<div class="preview_image_content">
	<img alt="" src="" id="preview_img">
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>