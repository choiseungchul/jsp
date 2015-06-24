<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
		String sub = "hospital";
	%>
<%@include file="../inc/top.jsp" %>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/admin/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<link type="text/css" href="${contextPath}/script/jquery-ui-1.10.3/css/redmond/jquery-ui-1.10.3.custom.css" rel="stylesheet"/> 
<script type="text/javascript" src="${contextPath}/script/jquery-ui-1.10.3/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${contextPath}/script/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#publishDate').datepicker({		
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    showMonthAfterYear: true,
		    yearSuffix: '년'
		  	
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
});

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
	/*
	if($('input[name=foreign]').val() == ''){
		return '<%=MessageHandler.getMessage("join.hospital.require.foreign")%>';
	}
	*/
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

function modify(){
	var msg = validate();
	if(msg == 'OK'){
		$.ajax({
			url : '${contextPath}/___/admin/hospital/modproc',
			type : 'post',
			dataType : 'json',
			data: $('#frm').serialize(),
			success: function(d){
				if(d.code == '0'){
					alert('수정되었습니다.');
					location.reload();
				}else{
					alert(d.msg);
				}
			}
		});
	}else{
		alert(msg);
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
</head>
<body>
<%@include file="../inc/gnb.jsp" %>
<div class="container-fluid">
 <div class="row">
	 <div class="col-sm-3 col-md-2 sidebar">	 	
	   <%@include file="../inc/left.jsp" %>
	 </div>
	 
 	 <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
 	 <form id="frm" name="frm">
 	 	
 	 	<input type="hidden" name="hid" value="${hospital.id }">
 	 		<input type="hidden" name="pic0" value="">
			<input type="hidden" name="pic1" value="">
			<input type="hidden" name="pic2" value="">
			<input type="hidden" name="pic3" value="">
			<input type="hidden" name="pic4" value="">
			<input type="hidden" name="pic5" value="">
 	 
          <h1 class="page-header">병원정보</h1>

          <div class="row placeholders">
            
          </div>          
          
          <h2 class="sub-header">Section title</h2>
          <div class="table-responsive">
            <table class="table table-striped">              
              <%
              
              	String pnum = request.getAttribute("pnum").toString();
              
              	HashMap<String, Object> hospital = (HashMap<String, Object>)request.getAttribute("hospital");
                
              %>
              <tbody>
                <tr>
					<td class="tit">병원명</td>
					<td class="cont" colspan="2">
						<input type="text" class="hos_add_input" name="name" id="hos_name" value="${hospital.name}">						
					</td>
					<td class="cont">						
					</td>
				</tr>
				<tr>
					<td class="tit">사이트주소</td>
					<td class="cont" colspan="2">
						<input type="text" class="hos_add_input" name="homepage" id="homepage" value="${hospital.homepage}">						
					</td>
					<td class="cont"></td>
				</tr>
				<tr>
					<td class="tit">사업자등록번호</td>
					<td class="cont" colspan="2">
						<input type="text" class="hos_add_input" name="busy_id_num" id="busy_id_num" value="${hospital.business_id}">						
					</td>
					<td class="cont"></td>
				</tr>								
				<tr>
					<td class="tit">전화번호</td>
					<td class="cont" colspan="2">
					<%
						if(hospital.get("tel") != null){
						
							if(!hospital.get("tel").toString().equals("")){
							
						String[] tel = hospital.get("tel").toString().split("-");
						
						for(int k = 0 ; k < tel.length; k++){
							if(k+1 != tel.length){
					%>
						<input type="text" class="hos_num_input" name="tel<%=k+1 %>" maxlength="4" id="tel<%=k+1 %>" value="<%=tel[k]%>">
						-						
					<% }else{ 
					%>
						<input type="text" class="hos_num_input" name="tel<%=k+1 %>" maxlength="4" id="tel<%=k+1 %>" value="<%=tel[k]%>">
					<%
						} 
					} } }
					%>
					
					</td>
					<td class="cont"></td>
				</tr>
				<tr>
					<td class="tit">팩스번호</td>					
					<td class="cont" colspan="2">					
						<input type="text" class="hos_addr_input" name="fax"  id="fax" value="<%=hospital.get("fax")%>">											
					</td>
					<td class="cont"></td>
				</tr>
				<tr>
					<td class="tit">주소</td>
					<td class="cont" colspan="2">
					<%
						if( hospital.get("postalCode") != null){
							if(!hospital.get("postalCode").toString().equals("")){
						
						String[] post = hospital.get("postalCode").toString().split("-", 2);
					%>
						<a href="javascript:openZipcode()" class="btn_find_bg">찾기</a>
						<input type="text" class="hos_num_input" name="post1" maxlength="3" id="post1" value="<%=post[0]%>">
						-
						<input type="text" class="hos_num_input" name="post2" maxlength="3" id="post2" value="<%=post[1]%>">						
					<% } }%>
					<%
						if(hospital.get("address1") != null){
					%>
						<input type="text" class="hos_addr_input" name="addr1" id="address1" value="${hospital.address1}">
						<br/>
						<input type="text" class="hos_addr_input" name="addr2" id="address2" value="${hospital.address2}" style="margin-top: 8px;">
					<% }else{ %>
						<input type="text" class="hos_addr_input" name="addr1" id="address1" value="${hospital.address}">
						<br/>
						<input type="text" class="hos_addr_input" name="addr2" id="address2" value="" style="margin-top: 8px;">
					<% } %>					
					</td>					
					<td class="cont"></td>
				</tr>				
				<tr>
					<td class="tit" >지역</td>
					<td class="cont" colspan="3">						
						<select id="locations" name="location" class="hos_add_input">
							<option value="">--지역선택--</option>
							<%
								List<HashMap<String, Object>> location = (List<HashMap<String, Object>>)request.getAttribute("location");
								
								for(int i = 0 ; i < location.size(); i++){
									HashMap<String, Object> data = location.get(i);
									if(hospital.get("locationCode").toString().equals(data.get("code").toString())){
							%>
							<option value="<%=data.get("code").toString()%>"  selected="selected"><%=data.get("name").toString() %></option>
							<%
									}else{
							%>
							<option value="<%=data.get("code").toString()%>"><%=data.get("name").toString() %></option>
							<%			
									}
							%>								
							<% } %>
						</select>
					</td>
				</tr>        
				
				<tr>
					<td class="tit">주요수술 1</td>
					<td class="cont">						
						<input type="text" class="hos_add_input w298" name="mOper1"  value="${hospital.mostOperation1}">						
					</td>
					<td class="tit">주요수술 2</td>
					<td class="cont">						
						<input type="text" class="hos_add_input w298" name="mOper2" value="${hospital.mostOperation2}">
					</td>
				</tr>
				<tr>
					<td class="tit">진료의수</td>
					<td class="cont">						
						<input type="text" class="hos_add_input w258" name="sp_count" value="${hospital.specialistCount}"> 명						
					</td>
					<td class="tit">마취과수</td>
					<td class="cont">
					<%
						
						String anes_cnt = "";
						if(hospital.get("anestheticCount") == null){
							anes_cnt = "0";
						}else{
							anes_cnt = hospital.get("anestheticCount").toString();
						}
					%>
						<input type="text" class="hos_add_input w258" name="an_count" value="<%=anes_cnt%>"> 명
					</td>
				</tr>
				<tr>
					<td class="tit">온라인상담수</td>
					<td class="cont">					
						<input type="text" class="hos_add_input w258" name="cou_count" value="${hospital.counselCount}"> 건			
					</td>
					<td class="tit">전후사진수</td>
					<td class="cont">
						<input type="text" class="hos_add_input w258" name="pic_count" value="${hospital.reviewPicCount}"> 건
					</td>
				</tr>
				<tr>
					<td class="tit">외국인유치</td>
					<td class="cont">
						<input type="text" class="hos_add_input w258" name="foreign" value="${hospital.foreignerReg}">					
					</td>
					<td class="tit">통역여부</td>
					<td class="cont">
						<input type="text" class="hos_add_input w258" name="inter" value="${hospital.interpreter}">
					</td>
				</tr>
				<tr>
					<td class="tit">병원크기</td>
					<td class="cont">
						<input type="text" class="hos_add_input w258" name="scale" value="${hospital.scale}">						
					</td>
					<td class="tit">픽업서비스</td>
					<td class="cont">
						<input type="text" class="hos_add_input w258" name="pickup" value="${hospital.pickupService}">
					</td>
				</tr>
				<tr>
					<td class="tit">입원실</td>
					<td class="cont">				
						<input type="text" class="hos_add_input w258" name="proom" value="${hospital.patientRoom}">					
					</td>					
					<td class="tit">회복실</td>
					<td class="cont">						
						<input type="text" class="hos_add_input w258" name="rroom" value="${hospital.recoveryRoom}">
					</td>
				</tr>
				<tr>
					<td class="tit">과별전문의</td>
					<td class="cont" colspan="3">
						<div class="hos_add_status">
							<ul>
								<li>
									<label class="hos_add_label type2">구강과</label>
									<input type="text"  class="hos_add_input w130" name="hstat1" value="${hospital.oralDoctorCount }">명
								</li>
								<li>
									<label class="hos_add_label type2">치과</label>
									<input type="text"  class="hos_add_input w130" name="hstat2" value="${hospital.dentalDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">가슴</label>
									<input type="text"  class="hos_add_input w130" name="hstat3" value="${hospital.breastDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">교정</label>
									<input type="text"  class="hos_add_input w130" name="hstat4" value="${hospital.orthodonticDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">이비인후과</label>
									<input type="text"  class="hos_add_input w130" name="hstat5" value="${hospital.otolaryngologyDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">외과</label>
									<input type="text"  class="hos_add_input w130" name="hstat6" value="${hospital.surgeryDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">성형외과</label>
									<input type="text"  class="hos_add_input w130" name="hstat7" value="${hospital.plasticSurgeryDoctorCount}">명
								</li>								
								<li>
									<label class="hos_add_label type2">마취과</label>
									<input type="text"  class="hos_add_input w130" name="hstat8" value="${hospital.anestheticDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">가정의과</label>
									<input type="text"  class="hos_add_input w130" name="hstat9" value="${hospital.familyMedicineDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">일반</label>
									<input type="text"  class="hos_add_input w130" name="hstat10" value="${hospital.generalDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">임상</label>
									<input type="text"  class="hos_add_input w130" name="hstat11" value="${hospital.clinicalDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">비만</label>
									<input type="text"  class="hos_add_input w130" name="hstat12" value="${hospital.obesityDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">피부과</label>
									<input type="text"  class="hos_add_input w130" name="hstat13" value="${hospital.dermatologistDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">보철</label>
									<input type="text"  class="hos_add_input w130" name="hstat14" value="${hospital.prostheticDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">임플란트</label>
									<input type="text"  class="hos_add_input w130" name="hstat15" value="${hospital.implantsDoctorCount}">명
								</li>
								<li>
									<label class="hos_add_label type2">산부인과</label>
									<input type="text"  class="hos_add_input w130" name="hstat16" value="${hospital.obstetricsDoctorCount}">명
								</li>
							</ul>							
						</div>
						<div class="clear"></div>					
					</td>
				</tr>				
				<tr>
					<td class="tit">가능수술</td>
					<td class="cont" colspan="3">					
						<input type="text" class="hos_add_input w698" name="surg_list" value="${hospital.possibleSurgery}">						
					</td>
				</tr>
				<tr>
					<td class="tit">진료시간</td>
					<td class="cont" colspan="3">						
						<input type="text" class="hos_add_input w698" name="open_time" value="${hospital.hours}">						
					</td>
				</tr>
				<tr>
					<td class="tit">병원소개글</td>
					<td class="cont" colspan="3">
						<textarea class="hos_intro_text_ta" name="intro">${hospital.introduction}</textarea>						
					</td>
				</tr>
				
				<tr>
					<td colspan="4">
						<h3>병원점수</h3>
					</td>
				</tr>
				<tr>
					<td class="tit">전문성(20%)</td>
					<td class="cont" colspan="3">
						<input type="text" name="expertPoint" value="${hospital.expertPoint }">
					</td>
				</tr>	 
				<tr>
					<td class="tit">안전성(30%)</td>
					<td class="cont" colspan="3">
						<input type="text" name="safePoint" value="${hospital.safePoint }">
					</td>
				</tr>	 
				<tr>
					<td class="tit">만족성(30%)</td>
					<td class="cont" colspan="3">
						<input type="text" name="satisfyPoint" value="${hospital.satisfyPoint }">
					</td>
				</tr>	 
				
				<tr>
					<td class="tit">규모성(30%)</td>
					<td class="cont" colspan="3">
						<input type="text" name="sizePoint" value="${hospital.sizePoint }">
					</td>
				</tr>	 
				<tr>
					<td class="tit">편의성(30%)</td>
					<td class="cont" colspan="3">
						<input type="text" name="convenientPoint" value="${hospital.convenientPoint }">
					</td>
				</tr>	 
				
				<tr>
					<td class="tit">종합점수</td>
					<td class="cont" colspan="3">
						<input type="text" name="totalPoint" value="${hospital.totalPoint }">
					</td>
				</tr>	 
				<tr>
					<td class="tit">등급</td>
					<td class="cont" colspan="3">
						<input type="text" name="grade" value="${hospital.grade }">
					</td>
				</tr>	
				
				<tr>
					<td class="tit">공개날짜</td>
					<td class="cont" colspan="3">
					<%
						String p_date = DateUtil.formatDate((Date)hospital.get("publishDate"), DateUtil.YYYYMMDD);	
						if(p_date == null) p_date = "2024-01-01";
					%>
						<input type="text" name="publishDate" value="<%=p_date%>" id="publishDate">
					</td>
				</tr>	
				
				<tr>
					<td class="tit">승인여부</td>
					<td class="cont" colspan="3">
					<%
						String user_stat = hospital.get("stat") == null ? "" : hospital.get("stat").toString();	
					%>
						<select id="status" name="status">
							<option value="A" <%if(user_stat.equals("A")) out.print("selected='selected'"); %>>승인</option>
							<option value="W" <%if(user_stat.equals("W")) out.print("selected='selected'"); %>>대기</option>
							<option value="C" <%if(user_stat.equals("C")) out.print("selected='selected'"); %>>거부</option>						
						</select>
					</td>
				</tr>	
				<tr>
					<td class="tit">승인거부 이유</td>
					<td class="cont" colspan="3">
						<textarea rows="" cols="" name="h_cancel_reason">${hospital.hc_desc }</textarea>
					</td>
				</tr>
              </tbody>
            </table>          
        </div>
         	
   	</form>
        
        <div class="">        	
	        <div class="">
  				<div class="preview_img">
					<img alt="" src="${contextPath }/___/file/get/${hospital.fid}" class="prev_image big">
				</div>				
				<div class="left">
				<form name="frm_pic0" id="frm_pic0" enctype="multipart/form-data" method="post">
					<input type="file" name="thumb_main" class="thumb_input ml0">						
					<p class="pt25">우리병원의 모든 썸네일 사진입니다. 권장사이즈 214x160 (jpg, gif, png)</p>				
				</form>
				</div>	
	   		</div>
	   		<div class="h264">	
  				<%
					List<HashMap<String, Object>> thumbList = (List<HashMap<String, Object>>)request.getAttribute("thumb5");			
				%>
				<div class="hos_pic_upload">
					<ul>					
						<%		
							int exSize = thumbList.size();
						
							for(int a = 1 ; a <= 5 ; a++){
								
								if(exSize > (a-1)){
									HashMap<String, Object> data = thumbList.get(a-1);						
						%>		
						<li>
							<div class="preview_img">								
								<img alt="" src="${contextPath }/___/file/get/<%=data.get("id").toString() %>" class="prev_image origin_over">
							</div>
							<div class="left">
								<form name="frm_pic<%=a %>" id="frm_pic<%=a %>" enctype="multipart/form-data" method="post">
									<label>상세사진<%=a %> : </label>
									<input type="file" class="thumb_input" name="thumb<%=a %>">
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
								<form name="frm_pic<%=a %>" id="frm_pic<%=a %>" enctype="multipart/form-data" method="post">
									<label>상세사진<%=a %> : </label>
									<input type="file" class="thumb_input" name="thumb<%=a%>">
								</form>
							</div>							
						</li>
						<%
							}
						} %>						
					</ul>
				</div>
				<div style="clear: both;"></div>
			</div>				
	   	</div>
        
        <div class="admin_btns">
        	<button type="button" class="btn btn-default btn-lg" onclick="modify();">수정</button>
        	<button type="button" class="btn btn-default btn-lg" onclick="document.frm.reset();">되돌리기</button>        	
        	<a href="${contextPath }/___/admin/hospital/list?PN=<%=pnum%>"><button type="button" class="btn btn-default btn-lg">병원목록</button></a>
        </div>
        
   	</div>  
   	
   	
   </div>
 </div>
 
<%@include file="../inc/footer.jsp" %>
<div class="preview_image_content">
	<img alt="" src="" id="preview_img">
</div>
</body>
</html>