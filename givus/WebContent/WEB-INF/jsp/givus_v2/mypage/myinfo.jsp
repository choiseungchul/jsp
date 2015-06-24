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
<title></title>
<script type="text/javascript">
var mZipcodes;
$(document).ready(function(){
	
	if(!Browser.ie7){
		$('input').corner('keep 5px');	
	}
	
	
	$('#srch_addr').keyup(function(e){
		if(e.which === 13){
			getZipcode();
		}
	});
	
	$('.m7').addClass('sub on');
});


function openZipcode(){
	$('.addr_layer').show();
}
function closeZipcode(){
	$('.addr_layer').hide();
}


function send_modify(){
	var data = $('#frm').serialize();
	
	var keywords = $('.keywords:checked');
	var uk = '';
	
	keywords.each(function(){
		uk += $(this).val() + ",";
	});
	
	uk = uk.substr(0, uk.length-1);
	
	data += "&uk=" + uk;
	
	console.log(data);
	
	$.ajax({
		url: '${contextPath}/___/renew/mypage/modifyproc',
		type : 'post',
		data : data,
		dataType : 'json',
		success:function(dt){
			if(dt.code != -1001){
				console.log(dt.code);			
			}else{
				alert(dt.msg);
			}			
		}
	});
	
}

function setAddress(idx){
	if(mZipcodes.length > 0){
		var obj = mZipcodes[idx];
		
		var post1 = obj.postalCode.substr(0, 3);
		var post2 = obj.postalCode.substr(3, 3);
		var addr = obj.fullAddress;
		
		$('#postNumber1').val(post1);
		$('#postNumber2').val(post2);
		$('#address1').val(addr);
		
		closeZipcode();
	}
}

function getZipcode(){
	var srch = $('#srch_addr').val();
	if(srch == '') {
		alert("<%=MessageHandler.getMessage("mypage.myinfo.addr.empty")%>");
	}
	
	$.ajax({
		url : '${contextPath}/___/renew/mypage/zipcode',
		type : 'post',
		dataType: 'json',
		data : { query : srch },
		success:function(data){
			mZipcodes = data.zipcode;
			var list = data.zipcode;
			
			var html = "";
			
			for(var i = 0 ; i < list.length ; i++){
				html += "<li><a href=\"javascript:setAddress("+i+");\">" + list[i].fullAddress + '</a></li>';
			}
			
			$('#zipcode').empty().append(html);
			
		}
	})
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
	
	HashMap<String, Object> user = (HashMap<String, Object>)request.getAttribute("user");
	
	List<HashMap<String, Object>> keywords = (List<HashMap<String, Object>>)request.getAttribute("keywords");
	List<HashMap<String, Object>> user_keyword = (List<HashMap<String, Object>>)request.getAttribute("user_keyword");
	
%>
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
		
		<form name="frm" id="frm">
		<div class="right_content">
			<h2>기본정보 변경</h2>
			<div class="myinfo_tb">
				<h3>이메일</h3>
				<div class="myinfo-disabled"><%=um.getEmail() %></div>
				<h3>별명</h3>
				<div class="myinfo-disabled"><%=um.getAccount() %></div>
				
				<div class="myinfo_line"></div>
				
				<h3>전화번호</h3>
				<%
					String tel1 = "";
					String tel2 = "";
					String tel3 = "";
				
					if(user.get("tel") != null){
						String[] tel = user.get("tel").toString().split("-");
						
						if(tel.length == 3){
							tel1 = tel[0];
							tel2 = tel[1];
							tel3 = tel[2];						
						}
					}
					
				%>
				<div class="myinfo_input">
					<input type="text" name="tel1" class="tel_input" maxlength="3" value="<%=tel1 %>">
					-
					<input type="text" name="tel2" class="tel_input" maxlength="4" value="<%=tel2 %>">
					-
					<input type="text" name="tel3" class="tel_input" maxlength="4" value="<%=tel3 %>">					
				</div>
				
				<h3>주소</h3>
				<div class="myinfo_addr">
					<%
						String postNum = user.get("postalCode") == null ? "" : user.get("postalCode").toString();
						
						String post1 = "";
						String post2 = "";
					
						if(!postNum.equals("")){
							post1 = postNum.substring(0, 3);
							post2 = postNum.substring(3, 6);
						}
						
						String address1 = user.get("address1") == null ? "" : user.get("address1").toString();
						String address2 = user.get("address2") == null ? "" : user.get("address2").toString();
					
					%>
					<a href="javascript:openZipcode()" class="btn_find_bg">찾기</a>
					<input type="text" name="post1" class="tel_input" maxlength="3" id="postNumber1" value="<%=post1%>">
					-
					<input type="text" name="post2" class="tel_input" maxlength="3" id="postNumber2" value="<%=post2%>">
				</div>
				<div class="myinfo_addr">
					<input type="text" name="addr1" class="addr_input" id="address1" value="<%=address1%>"> 
				</div>
				<div class="myinfo_addr pt13 pb10">
					<label>상세주소</label><input type="text" name="addr2" class="addr_detail_input" id="address2" value="<%=address2%>"> 
				</div>
				
				<div class="myinfo_keywords">
					<h3>관심키워드</h3>
					<%
						for(int i = 0 ; i < keywords.size(); i++ ){
							HashMap<String, Object> data = keywords.get(i);
							
							int id = (Integer)data.get("id");
							boolean isCheck = false;
							
							for(int k=0; k < user_keyword.size() ; k++){
								HashMap<String, Object> uk = user_keyword.get(k);
								int user_key_id = (Integer)uk.get("keywordId");
								
								if(user_key_id == id){
									isCheck = true;
								}
							}
							
					%>
					<label><input type="checkbox" value="<%=id %>" name="keywords<%=id %>" class="keywords" <%if(isCheck) out.print("checked=\"checked\""); %>><%=data.get("name").toString() %></label>					
					<% } %>					
				</div>
			</div><!-- myinfo_tb -->
			<div class="myinfo_btns">
				<a href="javascript:send_modify();" class="btn_myinfo_send on">변경</a>
				<a href="" class="btn_myinfo_send">취소</a>
			</div>
		</div><!-- right_content -->
		</form>
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>