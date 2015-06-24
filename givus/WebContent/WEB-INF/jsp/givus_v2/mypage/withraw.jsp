<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@page import="kr.co.zadusoft.givus.util.GivusUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%-- 헤더 삽입 --%>

<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/mypage.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
<%

%>
$(document).ready(function(){
	$('.m7').addClass('sub on');
});

function send_withraw(){
	var isCheck = $('#withraw_agr').is(":checked");
	if(isCheck){
		if(confirm("<%=MessageHandler.getMessage("mypage.withraw.alert")%>")){
			var formdata = $('#frm').serialize();
			$.ajax({
				url : '${contextPath}/___/renew/mypage/withraw/send',
				type: 'post',
				dataType : 'json',
				data: formdata,
				success: function(dt){
					if(dt.code == 0){
						alert(dt.msg);
						location.href='${contextPath}/___/renew/main';
					}else{
						alert(dt.msg);
					}
				}
			});
		}
	}else{
		alert('<%=MessageHandler.getMessage("mypage.withraw.agreement")%>');
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
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	
	<div class="content">
		<div class="left_menu">
			<%@include file="inc/left.jsp" %>		
		</div>
		<div class="right_content">
			<h2>회원탈퇴</h2>
			<div class="myinfo_tb withraw">
				<div class="left withraw_alert_title">
					<h4 class="withraw_title_red">유의사항</h4>
				</div>
				<div class="left withraw_alert_cont">
					<div class="alert_list">
						<div class="left list_img">
							<img alt="" src="${contextPath }/img/mypage/v_icon.png">
						</div>
						<div class="left list_cont">
							<strong>사용하고 계신 아이디(<span class="blue"><%=um.getAccount() %></span>)는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</strong>
						</div>
						<div class="clear"></div>
					</div>
					<div class="alert_list">
						<div class="left list_img">
							<img alt="" src="${contextPath }/img/mypage/v_icon.png">
						</div>
						<div class="left list_cont">
							<strong>탈퇴 후 개인정보 및 서비스 이용기록은 모두 삭제됩니다.</strong>
							<div class="list_cont_alert">- 회원정보 등 서비스 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.</div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="alert_list">
						<div class="left list_img">
							<img alt="" src="${contextPath }/img/mypage/v_icon.png">
						</div>
						<div class="left list_cont">
							<strong>탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.</strong>							
						</div>
						<div class="clear"></div>
					</div>
					<div class="alert_list">
						<div class="left list_img">
							<img alt="" src="${contextPath }/img/mypage/v_icon.png">
						</div>
						<div class="left list_cont">
							<strong>게시글은 탈퇴 시 자동 삭제되지 않고 그대로 남아 있습니다. </strong>
							<div class="list_cont_alert">- 삭제를 원하는 게시글이 있다면 반드시 탈퇴 전 삭제하시기 바랍니다. </div>
							<div class="list_cont_alert">탈퇴 후에는 회원정보가 삭제되며 게시글을 임의로 삭제해드릴 수 없습니다.</div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="alert_list mb0">
						<div class="left list_img">
							<img alt="" src="${contextPath }/img/mypage/v_icon.png">
						</div>
						<div class="left list_cont">
							<strong>탈퇴신청 후, 관리자의 승인을 기다려주세요.</strong>
							<div class="list_cont_alert">- 탈퇴신청은 관리자에게 메일로 전송되며, 가입시 등록된 메일로 탈퇴승인을 알려드립니다.</div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>
			</div><!-- myinfo_tb -->
			
			<h2 class="clear pt30">탈퇴사유</h2>
			<form name="frm" id="frm">
			<div class="myinfo_tb withraw">
				<div class="withraw_reason">
					<div class="left reason_title">
						<h4>개인정보 관련</h4>
					</div>
					<div class="left reason_cont">
						<ul>
							<li>
								<input type="radio" id="reason_1_1" class="wr_radio" name="reason_1" value="1" checked="checked">
								<label for="reason_1_1">아이디 변경을 위해 탈퇴 후 재가입</label>
							</li>
							<li>
								<input type="radio" id="reason_1_2" class="wr_radio" name="reason_1" value="2">
								<label for="reason_1_2">장기간 부재</label>
							</li>
							<li>
								<input type="radio" id="reason_1_3" class="wr_radio" name="reason_1" value="3">
								<label for="reason_1_3">개인정보 누출 우려</label>
							</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<div class="withraw_reason">
					<div class="left reason_title">
						<h4>사이트이용 관련</h4>
					</div>
					<div class="left reason_cont">
						<ul>
							<li>
								<input type="radio" id="reason_2_1" class="wr_radio" name="reason_2" value="1" checked="checked">
								<label for="reason_2_1">컨텐츠 등의 이용할 만한 서비스 부족</label>
							</li>
							<li>
								<input type="radio" id="reason_2_2" class="wr_radio" name="reason_2" value="2">
								<label for="reason_2_2">사이트 이용 불편</label>
							</li>
							<li>
								<input type="radio" id="reason_2_3" class="wr_radio" name="reason_2" value="3">
								<label for="reason_2_3">이용빈도 낮음</label>
							</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<div class="withraw_reason bd_n mb0">
					<div class="left reason_title">
						<h4>기타사유<br/>또는<br/>개선사항</h4>
					</div>
					<div class="left reason_cont">
						<textarea class="reason_text" name="reasonText"></textarea>
					</div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div><!-- myinfo_tb -->
			
			<div class="withraw_agree clear">
				<input type="checkbox" name="user_agree" class="withraw_check" id="withraw_agr" value="Y">
				<label for="withraw_agr">유의사항을 확인했으며, 이에 동의 합니다.</label>
			</div>
			</form>
			
			<div class="myinfo_btns withraw">
				<a href="javascript:send_withraw();" class="btn_myinfo_send on">탈퇴신청</a>				
			</div>
		</div><!-- right_content -->
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>