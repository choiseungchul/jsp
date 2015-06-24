<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dynamic.web.util.MessageHandler"%>
<style>
.reply_btn{
	width: 100px;
}
.reply_content{
	padding-left: 40px;
}
.send_reply{
	margin-left: 10px;
}
.reply_write_ta{
	height: 35px;
}
.reply_write{
	height: 56px;
}
.input_area_ta{
	width: 709px;
	margin-bottom: 10px;
	margin-right: 10px;
}
</style>
<script type="text/javascript">
//댓글달기

isSession = true;

function send_reply(type, viewId, container, parentId, _this){
	if(isSession==false){
		alert('<%=MessageHandler.getMessage("posting.msg.recommend_needlogin")%>');
		return;
	}
	
	var comment = '';
	var ta;
	var username;
	
	if(type == 1) {
		comment = $('.input_area_ta').val();
		ta = $('.input_area_ta');
		username = $('#um > option:selected').text();
	}else if(type == 2) {
		var idx = $('.send_to_reply_btn').index(_this);
		comment = $('.reply_write_ta').eq(idx).val();
		ta = $('.reply_write_ta').eq(idx);
		username = $('.um_reply:eq('+idx+') > option:selected').text();
	}
	
	if(comment == ''){
		alert('댓글을 입력하세요.');
		return;
	}

	if(username == '--사용자 선택--' || username == ''){
		alert('사용자를 선택하세요.');
		return;
	}
	
	$.ajax({
		url : '${contextPath}/___/admin/comment/add',
		type : 'POST',
		data: { postingId : viewId, comment : comment, parentId : parentId, username : username },
		success: function(rs){
			var obj = $.parseJSON(rs);			
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
			
			console.log(list);
			
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
						html += '		<td class="reply_btn"><span>[답글]&nbsp;<a href="javascript:send_del('+obj.id+');">[삭제]</a></span></td>';
					}else{
						html += '		<td></td>';
					}					
					html += '</tr>';		
					
					html += '<tr class="bd" id="comm_'+obj.id+'" style="display:none;">';
					html += '<td colspan="4" class="reply_content">';
					html += '<div class="reply_write">';
					html += '		<div class="left">';
					html += '			<select name="um_reply" class="um_reply">';
					html += '				<option>--사용자 선택--</option>';
					html += '			</select>';	
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
				
				/*
				if(!Browser.ie7){
					$('.reply_re, .reply_write').corner('keep 5px');
				}	
				*/
				getUsers();
				
			}else{
				$('.more_btn').hide();
			}
		}
	});
}

$(document).ready(function(){
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
	
	getUsers();
});

function getUsers(){
	$.ajax({
		url : '${contextPath}/___/admin/board/getusers',
		success: function(dt){
			//console.log(dt);
			var obj = $.parseJSON(dt);
			
			var list = obj.list;
			
			$('#um').empty();
			$('.um_reply').empty();
			
			for(var i = 0 ; i < list.length; i++){
				var data = list[i];
				
				$('#um').append('<option value="'+data.id+'">'+data.name+'</option>');
				$('.um_reply').append('<option value="'+data.id+'">'+data.name+'</option>');
			}
			
		}
	})
}

</script>

<div class="board_comment">
	<div class="comments">
		<h4 class="comm_cnt">댓글 [총 <span id="comm_count"></span>개]</h4>
		
		<div class="input_area">				
			<div class="">
				<div class="left">
					<select id="um" name="um" >					
						<option>--사용자 선택--</option>
					</select>
					<textarea class="input_area_ta"></textarea>
				</div>
				<div class="left ml9" >
					<a class="btn btn-default btn-lg" href="javascript:send_reply(1,<%=bid %>, 'commlist')">답글쓰기</a>
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
			<a href="javascript:loadMore(<%=bid%>, 0, 'commlist')" class="btn_bg5">글 더보기</a>
		</div>				
	</div>
</div>