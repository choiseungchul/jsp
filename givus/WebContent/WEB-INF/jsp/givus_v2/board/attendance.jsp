<%@page import="dynamic.web.util.MessageHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	int attendanceId = -99999;
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/board.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">

var isSession = false;

<%
if(um != null){
	if(um.getEmail() != null){
%>
isSession = true;
<%
	}
}
%>


//댓글달기
function send_reply(type, viewId, container, parentId, _this){
	if(isSession==false){
		alert('<%=MessageHandler.getMessage("posting.msg.recommend_needlogin")%>');
		return;
	}
	
	var comment = '';
	var ta;
	
	if(type == 1) {
		comment = $('.input_area_ta').val();
		ta = $('.input_area_ta');
	}else if(type == 2) {
		var idx = $('.send_to_reply_btn').index(_this);
		comment = $('.reply_write_ta').eq(idx).val();
		ta = $('.reply_write_ta').eq(idx);
	}
	
	if(comment == ''){
		alert('댓글을 입력하세요.');
		return;
	}
	$.ajax({
		url : '${contextPath}/___/renew/comment/add',
		type : 'POST',
		data: { postingId : viewId, comment : comment, parentId : parentId },
		success: function(rs){
			var obj = $.parseJSON(rs);
			if(obj.code == '-1000'){
				alert('로그인 후 이용가능합니다.');
				return;
			}
			if(obj.code == '0'){
				$('#' + container).empty();
				ta.val('');
				loadMore(viewId, 0, container);
			}
		}
	});
}

// 댓글 로딩	
function loadMore(viewId, start, container){
	$.ajax({
		url : '${contextPath}/___/renew/comment/' + viewId +"?start=" + start,			
		type : 'get',
		success: function(data){
			
			var list = $.parseJSON(data);
			
			var comm_arr = list.comments;
			var re_arr = list.comments_re;
			var total = list.total;
			
			$('#comm_count').text(total);
			
			var next = list.next;
			var pId = -1;
			var html = '';
			if(comm_arr.length > 0){	
				pId = comm_arr[0].postingId;
				var cnt = 0;
				for ( var i = 0 ; i < comm_arr.length ; i++){
					var obj = comm_arr[i];
					
					html += '<tr class="bd">';
					html += '		<td class="author">'+obj.creator+'</td>';
					html += '		<td class="datetime"><img src="${contextPath }/img/common/clock_icon.png">'+obj.createDate+'</td>';
					html += '		<td class="comm_text">';
					html +=	'		<pre>'+obj.contents+'</pre>';
					html += '		</td>';
					if(isSession){
						html += '		<td class="reply_btn"><span>[답글]</span></td>';
					}else{
						html += '		<td></td>';
					}					
					html += '</tr>';		
					
					html += '<tr class="bd" id="comm_'+obj.id+'" style="display:none;">';
					html += '<td colspan="4" class="reply_content">';
					html += '<div class="reply_write">';
					html += '		<div class="left">';
					html += '			<textarea rows="" cols="" class="reply_write_ta"></textarea>';
					html += '		</div>';
					html += '		<div class="left send_reply send_to_reply">'
					html += '			<img src="${contextPath }/img/common/reply_btn.png" class="send_to_reply_btn" onclick="javascript:send_reply(2,'+obj.postingId+',\''+container+'\', '+obj.id+', this)">';
					html +='		</div>';
					html +='	</div>';
					html +='	</td>';
					html +='</tr>';
					
					cnt++;
					
				}//for
				
				$('#'+container).append(html);
				
				for(var j = 0 ; j < re_arr.length; j++){
					var obj = re_arr[j];
					
					var re_re = '';
					re_re += '<tr class="no_bd" id="rere_'+obj.id+'">';
					re_re += '<td colspan="4" class="reply_text">';
					re_re +='		<div class="reply_re clear">';
					re_re +='		<table cellpadding="0" cellspacing="0" class="reply_content_tb">';
					re_re +='			<colgroup>';
					re_re +='				<col width="90">';
					re_re +='				<col width="99">';
					re_re +='				<col width="702">';												
					re_re +='			</colgroup>';
					re_re +='			<tbody>';
					re_re +='			<tr>';
					re_re +='				<td class="author">'+obj.creator+'</td>';
					re_re +='				<td class="datetime"><img src="${contextPath }/img/common/clock_icon.png">'+obj.createDate+'</td>';
					re_re +='				<td class="comm_text">';
					re_re +='					<pre>'+obj.contents+'</pre>';
					re_re +='				</td>';
					re_re +='			</tr>';
					re_re +='			</tbody>';
					re_re +='		</table>';							
					re_re +='		</div><!--reply_re-->';
					re_re +='	</td>';
					re_re +='</tr>';
					
					var t = $('#comm_'+obj.parentId);
					t.prev('tr').removeClass('bd').addClass('no_bd');
					t.after(re_re);
				} // for
				
				if(comm_arr.length < 15){
					$('.more_btn').hide();
				}else{
					$('.more_btn').show();
					
					$('.more_btn > a').prop('href',"javascript:loadMore("+pId+", "+next+", 'commlist')");
				}
				
				if(!Browser.ie7){
					$('.reply_re, .reply_write').corner('keep 5px');	
				}
				
			}else{
				$('.more_btn').hide();
			}
		}
	});
}

$(document).ready(function(){
	loadMore(<%=attendanceId%>, 0, 'commlist');
	
	$('.reply_btn').live('click',function(){
		$('.reply_btn').removeClass('on');
		var idx = $('.reply_btn').index(this);
		$('.reply_btn').eq(idx).addClass('on');
		$(this).parent('tr').removeClass('bd').addClass('no_bd');
		$(this).parent('tr').next().show();
	});
	
	$('.reply_btn.on').live('click',function(){
		$('.reply_btn').removeClass('on');
		$(this).parent('tr').removeClass('no_bd').addClass('bd');
		$(this).parent('tr').next().hide();
	});
	
	$('.m4').addClass('sub on');
});

</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<div class="wrapper clear">
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title pt25">
		<h1>게시판</h1>
	</div>
	<div class="content">
		<div class="hospital_tab">
			<ul>
				<li class="on"><a href="${contextPath}/___/renew/board/attendance">출석게시판</a></li>
				<li class="divide"><a href="${contextPath}/___/renew/board/list/30">성형전게시판</a></li>
				<li><a href="${contextPath}/___/renew/board/list/31">성형후게시판</a></li>
			</ul>
		</div><!-- hospital_tab -->
		
		<div class="board_comment">
			<div class="comments">
				<h4 class="comm_cnt">출석글 [총 <span id="comm_count"></span>개]</h4>
				
				<div class="input_area">				
					<div class="">
						<div class="left">
							<textarea class="input_area_ta"></textarea>
						</div>
						<div class="left ml9" >
							<a class="btn_bg4" href="javascript:send_reply(1,<%=attendanceId %>, 'commlist')">답글쓰기</a>
						</div>
					</div>
				</div><!-- "input_area" -->
				
				<div class="list_area clear">
					<div class="commlist">
						<table cellpadding="0" cellspacing="0" class="commlist_tb">
							<colgroup>
								<col width="90">
								<col width="99">
								<col width="716">
								<col width="52">
							</colgroup>
							<tbody id="commlist">
							</tbody>
						</table>					
					</div>
				</div>		<!-- list_area -->	
				<div class="more_btn">
					<a href="javascript:loadMore(<%=attendanceId%>, 0, 'commlist')" class="btn_bg5">글 더보기</a>
				</div>				
			</div>
		</div>
	</div>
	
</div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>
</html>