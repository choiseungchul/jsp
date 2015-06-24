<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

var mZipcodes;

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
		
		$('#post1').val(post1);
		$('#post2').val(post2);
		$('#address1').val(addr);
		
		closeZipcode();
	}
}
// 병원이름 체크
function checkName(){
	if($('#hos_name').val() != ''){
		$.ajax({
			url:'${contextPath}/___/renew/hospital/check/hname',
			type : 'post',
			data: { hname : $('#hos_name').val() },
			dataType : 'json',
			success: function(data){
				console.log(data);
				if(data.exist == true){
					$('.hos_name_alert').empty().text('<%=MessageHandler.getMessage("join.hospital.add.name.exist")%>');
					hnameDuplicate = true;
				}else{
					$('.hos_name_alert').empty().text('<%=MessageHandler.getMessage("join.hospital.add.name.notexist")%>');
					hnameDuplicate = false;
				}
			}
		});
	}else{
		alert('<%=MessageHandler.getMessage("join.hospital.input.hname.empty")%>')
	}
}

function checkId(){
	if($('#account').val() != ''){
		$.ajax({
			url:'${contextPath}/___/renew/hospital/check/hid',
			type : 'post',
			data: { hid : $('#account').val() },
			dataType : 'json',
			success: function(data){
				if(data.exist == true){
					$('.id_alert').empty().text('<%=MessageHandler.getMessage("join.hospital.add.id.exist")%>');
					hidDuplicate = true;
				}else{
					$('.id_alert').empty().text('<%=MessageHandler.getMessage("join.hospital.add.id.notexist")%>');
					hidDuplicate = false;
				}
			}
		});
	}else{
		alert('<%=MessageHandler.getMessage("join.hospital.input.hid.empty")%>');
	}
}
function checkEmail(){
	if($('#email').val() != ''){
		$.ajax({
			url:'${contextPath}/___/renew/hospital/check/email',
			type : 'post',
			data: { hid : $('#email').val() },
			dataType : 'json',
			success: function(data){
				if(data.exist == true){
					$('.email_alert').empty().text('<%=MessageHandler.getMessage("join.hospital.add.email.exist")%>');
					emailDuplicate = true;
				}else{
					$('.email_alert').empty().text('<%=MessageHandler.getMessage("join.hospital.add.email.notexist")%>');
					emailDuplicate = false;
				}
			}
		});
	}else{
		alert('<%=MessageHandler.getMessage("join.hospital.input.hid.empty")%>');
	}
}
</script>