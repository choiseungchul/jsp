<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.text.DecimalFormat" %>
<%
	HashMap<String, Object> data = (HashMap<String, Object>)request.getAttribute("hos");
%>
<%-- 헤더 삽입 --%>
<%@include file="../inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	
	$('.ranklist').load('${contextPath}/___/renew/tile/rankbox');
	$('.most_view_hos').load('${contextPath}/___/renew/hospital/mostview/<%=data.get("id")%>');
});
</script>
</head>
<body>
<div class="wrap">
<%@include file="../inc/top.jsp"%>
<script type="text/javascript" src="${contextPath }/script/jqueryui/plugin/jquery.BxSlider.min.js"></script>
<script type="text/javascript" src="${contextPath }/script/jqueryui/plugin/jquery.corner.js"></script>
<script type="text/javascript">

var isSession = '';

$(document).ready(function(){
	var slider = $('.top_slide_ul').bxSlider({
		auto: false,
		speed : 400,
		pause : 10000,
		controls :false,
		pager:false,
		infiniteLoop : false
	});	
	
	$('.menu ul li').mouseenter(function(){
		var idx = $('.menu ul li').index(this);
		
		slider.goToSlide(idx);
	});
	
});
</script>
<div class="wrapper clear">
	<!-- 서브 타이틀 -->
	<%@include file="../inc/top_slide.jsp" %>
	<div class="sub_title hosinfo_top">		
		<h1>Top 100 병원정보</h1>	
		<div class="sub_page_navi hosinfo_top">
			<ul>
				<li><a href="#">Top 100</a></li>
				<li>&gt;</li>
				<li><a href="#">Top 100 병원리스트</a></li>
				<li>&gt;</li>
				<li><a href="#"><%=data.get("name") %>성형외과</a></li>		
			</ul>
		</div>
	</div>
	
	<div class="content">
		<div class="hospital_cont left">
			
			<div class="hospital_infomation clear">
				<div class="h_name"><%=data.get("name") %>성형외과</div>
				<div class="h_info">
					<div class="left hbox">
						<div class="h_infobox">
							<div class="h_thumb left">
								<% 
									if(data.get("fid") != null){
								%>
								<img alt="" src="/___/file/get/<%=data.get("fid")%>">
								<% }else { %>
								<img alt="" src="${contextPath }/img/no_img.png">
								<% } %>
							</div>
							<div class="h_contact left">
								<ul>
									<li>
										<img src="${contextPath }/img/hospital/hos_info_list_img.png">
										<div class="right hospital_homepage">
											<h3>URL</h3>
											<a href="<%=data.get("homepage") %>" target="_blank"><%=data.get("homepage") %></a>
										</div>
									</li>
									<li class="f13">
										<img src="${contextPath }/img/hospital/hos_info_list_img.png">
										<div class="right hospital_homepage">
											<h3>주소</h3>
											<p><%=data.get("address") %></p>	
										</div>
									</li>
									<li>
										<img src="${contextPath }/img/hospital/hos_info_list_img.png">
										<div class="right hospital_homepage">
											<h3>대표전화 / FAX</h3>
											<p><%=data.get("tel") %></p>
											<p><%=data.get("fax") %></p>	
										</div>
									</li>
								</ul>								
								<!-- <a href="" class="mod_hospital">정보수정하기</a> -->
							</div>
						</div>
						<div class="h_t_slide clear">
							<ul class="h_t_slide_ul">							
							<%
								List<HashMap<String, Object>> thumbList = (List<HashMap<String, Object>>)request.getAttribute("thumb5");
							
								for(int k = 0 ; k < thumbList.size(); k++){
									HashMap<String, Object> thumb = thumbList.get(k);
							%>							
								<li><img src="${thumb.path }"></li>
							<% } %>
							</ul>
						</div>
						<div class="clear"></div>
					</div><!-- hbox -->
					<div class="left h_ranking">
						<div class="rank_info">
							<span class="r_info_locRank">전국 <%=data.get("ranking") %>위 / </span>
							<span class="r_info_grade"><%=data.get("grade") %></span>
						</div>
					</div>
				</div>
			</div><!-- hospital_infomation -->
			<div class="h_sns_btn clear">
				<!-- 페이스북 좋아요, 공유하기 버튼 -->
				<div id="fb-root"></div>
				<script>(function(d, s, id) {
				  var js, fjs = d.getElementsByTagName(s)[0];
				  if (d.getElementById(id)) return;
				  js = d.createElement(s); js.id = id;
				  js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&appId=1427018384229922&version=v2.0";
				  fjs.parentNode.insertBefore(js, fjs);
				}(document, 'script', 'facebook-jssdk'));</script>
				<div class="fb-like" data-href="http://givus.co.kr/___/renew/hospital/<%=data.get("id") %>" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
				<div class="fb-share-button" data-href="http://givus.co.kr/___/renew/hospital/<%=data.get("id") %>" data-type="button"></div>
			</div>
			
			<div class="hospital_tab">
				<ul>
					<li><a href="${contextPath}/___/renew/hospital/info/<%=data.get("id")%>">병원정보</a></li>
					<li class="on"><a href="${contextPath}/___/renew/hospital/epilogue/<%=data.get("id")%>">수술후기</a></li>
					<li><a href="${contextPath}/___/renew/hospital/review/<%=data.get("id")%>">병원리뷰</a></li>
				</ul>
			</div><!-- hospital_tab -->
			
			<%-- 게시판 로딩 --%>
			<div class="review_board">				
			</div>
						
			<script type="text/javascript">
				$(document).ready(function(){
					$('.review_board').load('${contextPath}/___/renew/hospital/board_epil/<%=data.get("id")%>/0/1/25');
					
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
					
				});
				function loadPage(url){
					$('.review_board').load(url);
				}
				
				<%
				
				if(um != null){
					if(um.getEmail() != null){
				%>
				isSession = true;
				<%
					}
				}
				
				%>
				
				// 댓글달기
				function send_reply(type, viewId, container, parentId, _this){
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
									re_re +='				<col width="402">';												
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
									$('.reply_re').corner('keep 5px');	
								}
								
							}else{
								$('.more_btn').hide();
							}
						}
					});
				}
			</script>
			
		</div><!-- hospital_cont -->
		
		<div class="hospital_aside left">
			<div class="most_view_hos"></div>
			<div class="ranklist"></div>
		</div><!-- hospital_aside -->
	</div><!-- content -->
	
</div>
</div><!-- wrap -->
<%@include file="../inc/footer.jsp"%>
</body>
</html>