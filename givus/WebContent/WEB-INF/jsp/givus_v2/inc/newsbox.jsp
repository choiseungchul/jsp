<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	// 데이터 불러옴
	List<HashMap<String, Object>> newsList = (List<HashMap<String, Object>>)request.getAttribute("newsList");
%>
<script type="text/javascript">
var curr_page = 0;
$(document).ready(function(){
	
	$('.news_box_list:eq(4)').nextAll(5).hide();
	
	$('#pager_news_left').click(function(){
		if(curr_page == 0) return;
		
		$('.news_box_list:eq(5)').prevAll(5).show();
		$('.news_box_list:eq(4)').nextAll(5).hide();
		
		$('#page_news_count').text('1/2');		
		
		curr_page = 0;
	});
	
	$('#pager_news_right').click(function(){
		if(curr_page == 1) return;
		
		$('.news_box_list:eq(5)').prevAll(5).hide();
		$('.news_box_list:eq(4)').nextAll(5).show();
		
		$('#page_news_count').text('2/2');		
		
		curr_page = 1;
	});
	
});

</script>
<div class="rank_box">
	<div class="rb_title">인기 기사글</div>
	<div class="rb_cont">
		<div class="rb_ranklist news">		
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" >
				<colgroup>
					<col width="21">
					<col width="218">
				</colgroup>
				<tbody>
				
				<%				
					for(int i = 0 ; i < newsList.size() ; i++){
					
						HashMap<String, Object> data = newsList.get(i);
						
						String numCls = "";
						String numCls2 = "";
						
						if(i <= 2){
							numCls = "rank123";
							numCls2  = "rb_rnum123";
						}else{
							numCls = "";
							numCls2 = "rb_rnum";
						}
						
				%>
				
				<tr class="news_box_list">
					<td class="<%=numCls%>"><span class="<%=numCls2%>"><%=i+1 %></span></td>
					<td class="rb_rl_name "><a href="<%=data.get("referenceURL")%>" data-id="<%=data.get("id") %>"  target="_blank"><%=data.get("subject") %></a></td>					
				</tr>
				
				<%} %>
								
				</tbody>
			</table>			
		</div>
	</div>
	<div class="rb_ranklist_pager" id="page_news">
		<span id="page_news_count">1/2</span>
		<span>
			<img id="pager_news_left" alt="이전" src="${contextPath }/img/common/rank_box_pager_left.png">
			<img id="pager_news_right" alt="다음" src="${contextPath }/img/common/rank_box_pager_right.png">
		</span>
	</div>
</div>