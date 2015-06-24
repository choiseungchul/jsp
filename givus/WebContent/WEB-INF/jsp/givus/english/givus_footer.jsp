<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style type="text/css">
.bottom_bodytable{
	text-align:center;
	background-color:#424542;
	width:100%; 
	bottom:0px;
}
.bottom_menulist{
	color: #BDB9B9;
	font-size: 11px;
	font-family: "나눔고딕", "돋움", Arial Unicode MS, sans-serif;
	padding-left: 0px;
	padding-top: 4px;
	padding-bottom: 3px;
	text-align:left;
}
.bottom_menulist a {
	color: #BDB9B9;
	font-size: 11px;
	font-family: "나눔고딕", "돋움", Arial Unicode MS, sans-serif;
}
.bottom_menulist_title {
	color: #EFEFEF;
	font-size: 12px;
	font-family: "나눔고딕", "돋움", Arial Unicode MS, sans-serif;
	text-shadow: 1px 1px 1px #000D15;
	padding-left: 10px;
	padding-top: 20px;
	padding-bottom: 4px;
	text-align:left;
}
.bottom_menulist_title a {
	color: #EFEFEF;
	font-size: 12px;
	font-family: "나눔고딕", "돋움", Arial Unicode MS, sans-serif;
	text-shadow: 1px 1px 1px #000D15;
}
.bottom_outer_table {
	border:0px;
	padding: 0px;
	width:980px;
}
.bottom_inner_table {
	border:0px;
}
.bottom_inner_table td{
	line-height:150%;
	padding-left: 15px;
}
.feedback_bodytable{
	text-align:center;
	width:100%; 
	bottom:0px;
}
.feedback_edit{
	display:none;
	height:370px; width:680px;
	border-radius: 9px;
}
.msg_create{
	display:none;
	height:463px; width:505px;
	border-radius: 9px;
}

</style>
<script type="text/javascript">

$(function(){
	$('.write_feedback').click(function(){
		$.blockUI({ 
			message: $('.feedback_edit'), 
			css: { width: '680px', height : '370px', border:'none', backgroundColor: '', '-webkit-border-radius': '5px', '-moz-border-radius': '5px'},
			overlayCSS:{ backgroundColor: '#000000'},
			onOverlayClick: $.unblockUI
		});
	}).css('cursor', 'pointer');
});
</script>
<%-- contextmenu --%>
<script>
$(function(){
    $.contextMenu({
        selector: '.context-menu-one', 
        trigger: 'left',
        callback: function(key, options) {
            var m = "clicked: " + key + "," + $(this).data('account');
            if ( key == "message"){
            	var userType = "${userType}";
            	if ( userType == ""){
            		alert( "쪽지는 로그인 후에 사용이 가능합니다.");
            		
            	}else if(  userType != ""){
            		var xpath = "${xpath}";
            		xpath = xpath.replace(/%2F/g, "+");
            		if ( userType == "G" || userType == "M"){
            			var url = "${contextPath}/___/msg/create/m/" + $(this).data('account') + "/" + xpath;
	            		
	               	}else if ( userType == "H"){
	               		var url = "${contextPath}/___/msg/create/h" + $(this).data('account') + "/" + xpath;
	               	}
               		
               		$.blockUI({
        				message: 
        					$('.msg_create').load( url, function(){
        						
        					}),
       					css: { width: '505px', height: '463px', border:'none', '-webkit-border-radius': '9px', '-moz-border-radius': '9px', top:'50px', left:'50px'},
       					overayCSS:{backgroundColor: '#000000'},
       					onOverlayClick: $.unblockUI
        			});
            	}

            }
            
        },
        items: {
           "message": {name: "쪽지보내기", icon: "message"},
            "sep1": "---------",
            "quit": {name: "닫기", icon: "quit"}
        }
    });
});
</script>

<div style="height:20px"></div>
<div class="msg_create" id="msg_create">
	<%-- <jsp:include page="givus_msg_popup.jsp" flush="false"/> --%>
</div>
<div class="feedback_edit">
<jsp:include page="givus_feedback_popup.jsp" flush="false"/>
</div>
<table class="feedback_bodytable">
	<tr align="center" valign="bottom">
		<td></td>
		<td align="center" valign="bottom">
			<table class="bottom_outer_table">
				<tr><td align="left"><div class="write_feedback"><img src="${imageHandler.g_feedback_feedback}" alt="feedback"></div></td></tr>
			</table>
		</td>
		<td></td>
	</tr>
</table>
<table class="bottom_bodytable">
<tr align="center" valign="bottom">
	<td></td>
	<td align="center" valign="bottom">
	<!-- bottom start -->
		<table class="bottom_outer_table">
		<tr>
			<td width="246" rowspan="2"><img src="${imageHandler.g_bottom_logo}" alt="" width="241" height="210" style="padding-right:5px;"></td>
			<td width="157" rowspan="2" valign="top">
				<table class="bottom_inner_table">
				<tr>
					<td class="bottom_menulist_title"><a href="${contextPath}/___/p/ranking/A?fid=HE">순위 리스트</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/ranking/A?fid=HE">전체 Top 100</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/ranking/B">수도권 Top 50</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/ranking/C">광역시 Top 10</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/ranking/D">부위별 Top 10</a></td>
				</tr>
				<tr>
					<td height="5px"></td>
				</tr>
				<tr>
					<td class="bottom_menulist_title"><a href="${contextPath}/___/p/surgeryinfo">정보</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/surgeryinfo/19/68">성형뉴스</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/surgeryinfo/19/69">성형정보</a></td>
				</tr>
				
				</table>
			</td>
			<td width="6" rowspan="2"><img src="${imageHandler.g_bottom_line}" alt="" width="5" height="255"></td>
			<td width="157" rowspan="2" valign="top">
				<table class="bottom_inner_table">
				<tr>
					<td class="bottom_menulist_title"><a href="${contextPath}/___/p/event">병원이벤트</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/event">이벤트 시술가격</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist_title"><a href="${contextPath}/___/p/hospitalpr">우리병원PR</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/hospitalpr">병원 인터뷰</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist_title"><a href="${contextPath}/___/p/board/1">게시판</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist_title">
						<c:if test="${userType !=null && ( userType == 'H' || userType == 'M')}">
						<a href="${contextPath}/___/p/hboard">병원관계자공간</a>
						</c:if>
					</td>
				</tr>
				
				</table>
			</td>
			<td width="6" rowspan="2"><img src="${imageHandler.g_bottom_line}" alt="" width="5" height="255"></td>
			<td width="157" rowspan="2" valign="top">
				<table class="bottom_inner_table">
				<tr>
					<td class="bottom_menulist_title">기타</td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/introduction">About us</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/notice">Contact us</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist"><a href="${contextPath}/___/p/howToUseGivus">GIVUS 활용하기</a></td>
				</tr>
				<tr>
					<td class="bottom_menulist_title">H & L</td>
				</tr>
				<tr>
					<td class="bottom_menulist">사업자등록증</td>
				</tr>
				<tr>
					<td class="bottom_menulist">이용약관</td>
				</tr>
				<tr>
					<td class="bottom_menulist">개인정보취급방침</td>
				</tr>
				</table>
			</td>
			
			<td width="251" height="195" valign="bottom">
				<table class="bottom_inner_table">
				<tr>
					<td style="padding-bottom:30px;"><img src="${imageHandler.g_bottom_copy}" alt="" width="251" height="30" align="bottom"></td>
				</tr>
				</table>
			</td>
		</tr>
		
		</table>
	<!-- bottom end -->
	</td>
	<td></td>
</tr>
</table>