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
});


function openZipcode(){
	$('.addr_layer').show();
}
function closeZipcode(){
	$('.addr_layer').hide();
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

function send_modify(){
	if(confirm('<%=MessageHandler.getMessage("myhospital.modify.alert")%>')){
		document.frm.submit();	
	}	
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
	
	HashMap<String, Object> user = (HashMap<String, Object>)request.getAttribute("uh");
	
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
		
		<form name="frm" id="frm" action="${contextPath }/___/renew/mypage/myhmod" method="post">
			<input type="hidden" name="hid" value="<%=user.get("id")%>">
		<div class="right_content">
			
			<h2>병원정보 변경</h2>
			<div class="myhinfo">
				<table cellpadding="0" cellspacing="0" class="myhinfo_tb">
					<colgroup>
						<col width="179">
						<col width="541">
					</colgroup>
					<tbody>
					<tr>
						<td class="tit">사이트주소</td>
						<td class="cont">
							<input type="text" name="homepage" class="addr_input"  value="<%=user.get("homepage")%>">
						</td>
					</tr>
					<tr>
						<td class="tit">사업자등록번호</td>
						<td class="cont">
							<input type="text" name="business_id" class="addr_input"  value="<%=user.get("business_id")%>">
						</td>
					</tr>
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
					<tr>
						<td class="tit">전화번호</td>
						<td class="cont">
							<input type="text" name="tel1" class="tel_input" maxlength="3" value="<%=tel1 %>">
							-
							<input type="text" name="tel2" class="tel_input" maxlength="4" value="<%=tel2 %>">
							-
							<input type="text" name="tel3" class="tel_input" maxlength="4" value="<%=tel3 %>">
						</td>
					</tr>
					<%
						String fax = "";
					
						if(user.get("fax") != null){
							fax = user.get("fax").toString();
						}
						
					%>
					<tr>
						<td class="tit">팩스번호</td>
						<td class="cont">
							<input type="text" name="fax" class="addr_input"  value="<%=fax %>">							
						</td>
					</tr>
					<%
						String postNum = user.get("postalCode") == null ? "" : user.get("postalCode").toString();
						
						String post1 = "";
						String post2 = "";
					
						if(!postNum.equals("")){
							String[] post = postNum.split("-");
							
							for(int i = 0 ; i < post.length; i++){
								if(i == 0){
									post1 = post[0];
								}else if(i==1){
									post2 = post[1];
								}
							}
						}
						
						String address1 = user.get("address1") == null ? "" : user.get("address1").toString();
						String address2 = user.get("address2") == null ? "" : user.get("address2").toString();
					
					%>
					<tr>
						<td class="tit bd_n">주소</td>
						<td class="cont bd_n">
							<div class="myinfo_addr pt6">					
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
						</td>
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
											if(user.get("locationCode").toString().equals(data.get("code").toString())){
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
					
					</tbody>
				</table>
				
			</div><!-- myhinfo -->
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