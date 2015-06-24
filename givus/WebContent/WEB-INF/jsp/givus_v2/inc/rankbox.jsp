<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%
	// 데이터 불러옴
	List<HashMap<String, Object>> top100 = (List<HashMap<String, Object>>)request.getAttribute("top100");
	List<HashMap<String, Object>> s_top50 = (List<HashMap<String, Object>>)request.getAttribute("s_top50");
	List<HashMap<String, Object>> B_top50 = (List<HashMap<String, Object>>)request.getAttribute("B_top50");
	List<HashMap<String, Object>> C_top50 = (List<HashMap<String, Object>>)request.getAttribute("C_top50");
	List<HashMap<String, Object>> D_top50 = (List<HashMap<String, Object>>)request.getAttribute("D_top50");
	List<HashMap<String, Object>> E_top50 = (List<HashMap<String, Object>>)request.getAttribute("E_top50");
	List<HashMap<String, Object>> F_top50 = (List<HashMap<String, Object>>)request.getAttribute("F_top50");
	List<HashMap<String, Object>> G_top50 = (List<HashMap<String, Object>>)request.getAttribute("G_top50");
	
	List<HashMap<String, Object>> eyeTop = (List<HashMap<String, Object>>)request.getAttribute("surg1");
	List<HashMap<String, Object>> noseTop = (List<HashMap<String, Object>>)request.getAttribute("surg2");
	List<HashMap<String, Object>> faceTop = (List<HashMap<String, Object>>)request.getAttribute("surg3");			
	List<HashMap<String, Object>> breastTop = (List<HashMap<String, Object>>)request.getAttribute("surg4");
	List<HashMap<String, Object>> bodyTop = (List<HashMap<String, Object>>)request.getAttribute("surg5");
	List<HashMap<String, Object>> petitTop = (List<HashMap<String, Object>>)request.getAttribute("surg6");
	
	String ymw = request.getAttribute("ymw").toString();
	
	String year = ymw.split("/")[0];
	String month = ymw.split("/")[1];
	String week = ymw.split("/")[2];
	
%>
<script type="text/javascript">
var list_type = 0;
var curr_idx = 0;

var top100_cnt = <%=top100.size()%>;
var s_top50_cnt = <%=s_top50.size()%>;
var loc_B_top50_cnt = <%=B_top50.size()%>;
var loc_C_top50_cnt = <%=C_top50.size()%>;
var loc_D_top50_cnt = <%=D_top50.size()%>;
var loc_E_top50_cnt = <%=E_top50.size()%>;
var loc_F_top50_cnt = <%=F_top50.size()%>;
var loc_G_top50_cnt = <%=G_top50.size()%>;

var part_1_cnt = <%=eyeTop.size()%>;
var part_2_cnt = <%=noseTop.size()%>;
var part_3_cnt = <%=faceTop.size()%>;
var part_4_cnt = <%=breastTop.size()%>;
var part_5_cnt = <%=bodyTop.size()%>;
var part_6_cnt = <%=petitTop.size()%>;

var curr_limit = 0;
var loc_type = 'B';
var part_type = 'eye';

$(document).ready(function(){
	
	if(top100_cnt%10 == 0){
		curr_limit = parseInt(top100_cnt /10);
	}else {
		curr_limit = parseInt(top100_cnt /10) + 1;
	}		
	$('#page_count').text('1/' + curr_limit);
	
	$('#top100').click(function(){
		$('.rb_ranklist:not(".news") table').hide();
		$('#top100_0').show();
		list_type = 0;
		curr_idx = 0;
		$('.rb_menus ul li').removeClass('on');
		$('.rb_menus ul li').eq(0).addClass('on');
		if(top100_cnt%10 == 0){
			curr_limit = parseInt(top100_cnt /10);
		}else {
			curr_limit = parseInt(top100_cnt /10) + 1;
		}		
		$('#page_count').text('1/' + curr_limit);
	});
	$('#s_top50').click(function(){
		$('.rb_ranklist:not(".news") table').hide();
		$('#s_top50_0').show();
		list_type = 1;
		curr_idx = 0;
		$('.rb_menus ul li').removeClass('on');
		$('.rb_menus ul li').eq(1).addClass('on');
		
		if(s_top50_cnt%10 == 0){
			curr_limit = parseInt(s_top50_cnt /10);
		}else {
			curr_limit = parseInt(s_top50_cnt /10) + 1;
		}		
		$('#page_count').text('1/' + curr_limit);
	});
	$('#l_top50').click(function(){
		$('.rb_ranklist:not(".news") table').hide();
		list_type = 2;
		curr_idx = 0;
		
		$('#B_top50_0').show();
		$('.rb_menus ul li').removeClass('on');	
		$('#loc span').removeClass('on');
		$('#part span').removeClass('on');
		
		$('#loc span').eq(0).addClass('on');
		$('.rb_menus ul li').eq(2).addClass('on');
		
		if(loc_B_top50_cnt%10 == 0){
			curr_limit = parseInt(loc_B_top50_cnt /10);
		}else {
			curr_limit = parseInt(loc_B_top50_cnt /10) + 1;
		}		
		$('#page_count').text('1/' + curr_limit);
	});
	$('#p_top50').click(function(){
		$('.rb_ranklist:not(".news") table').hide();
		list_type = 3;
		curr_idx = 0;
		
		$('#eye_top10_0').show();
		$('.rb_menus ul li').removeClass('on');		
		$('#loc span').removeClass('on');
		$('#part span').removeClass('on');
		
		$('#part span').eq(0).addClass('on');
		$('.rb_menus ul li').eq(3).addClass('on');
		
		if(part_1_cnt%10 == 0){
			curr_limit = parseInt(part_1_cnt /10);
		}else {
			curr_limit = parseInt(part_1_cnt /10) + 1;
		}		
		$('#page_count').text('1/' + curr_limit);
	});
	
	$('#loc span').click(function(){
		$('.rb_ranklist:not(".news") table').hide();		
		list_type = 2;
		curr_idx = 0;
		
		var idx = $('#loc span').index(this);
		$('#loc span').removeClass('on');
		$('#part span').removeClass('on');
		
		$('#loc span').eq(idx).addClass('on');
		
		var loc_arr = [ loc_B_top50_cnt, loc_C_top50_cnt, loc_D_top50_cnt, loc_E_top50_cnt, loc_F_top50_cnt, loc_G_top50_cnt ];
		var loc_type_arr = ['B','C','D','E','F','G'];
		
		if(loc_arr[idx]%10 == 0){
			curr_limit = parseInt(loc_arr[idx] /10);
		}else {
			curr_limit = parseInt(loc_arr[idx] /10) + 1;
		}		
		$('#page_count').text('1/' + curr_limit);
		
		loc_type = loc_type_arr[idx];
		$('#'+loc_type+'_top50_0').show();
				
	});
	
	$('#part span').click(function(){
		$('.rb_ranklist:not(".news") table').hide();		
		list_type = 3;
		curr_idx = 0;
		
		var idx = $('#part span').index(this);
		$('#loc span').removeClass('on');
		$('#part span').removeClass('on');
		
		$('#part span').eq(idx).addClass('on');
		
		var part_arr = [ part_1_cnt, part_2_cnt, part_3_cnt, part_4_cnt, part_5_cnt, part_6_cnt ];
		var part_names = ['eye','nose','face','breast','body','petit'];
		
		if(part_arr[idx]%10 == 0){
			curr_limit = parseInt(part_arr[idx] /10);
		}else {
			curr_limit = parseInt(part_arr[idx] /10) + 1;
		}		
		$('#page_count').text('1/' + curr_limit);
		
		part_type = part_names[idx];
		$('#'+part_type+'_top10_0').show();
		
	});
	
	$('#pager_left').click(function(){	
		if(curr_idx > 0){
			$('.rb_ranklist:not(".news") table').hide();
			curr_idx--;
			
			if(list_type == 0){
				$('#top100_' + curr_idx).show();
			}else if(list_type == 1){
				$('#s_top50_' + curr_idx).show();
			}else if(list_type == 2){
				$('#'+ loc_type +'_top50_' + curr_idx).show();	
			}else if(list_type == 3){
				$('#'+ part_type +'_top10_' + curr_idx).show();		
			}
			
			$('#page_count').text((curr_idx+1) + "/" + curr_limit);
		}		
	});
	
	$('#pager_right').click(function(){	
		if(curr_limit > 0 && curr_idx+1 < curr_limit){
			$('.rb_ranklist:not(".news") table').hide();
			curr_idx++;
			
			if(list_type == 0){	
				$('#top100_' + curr_idx).show();
			}else if(list_type == 1){
				$('#s_top50_' + curr_idx).show();		
			}else if(list_type == 2){
				$('#'+ loc_type +'_top50_' + curr_idx).show();	
			}else if(list_type == 3){
				$('#'+ part_type +'_top10_' + curr_idx).show();	
			}
			
			$('#page_count').text((curr_idx+1) + "/" + curr_limit);
		}		
	});
});
</script>
<div class="rank_box">
	<div class="rb_title">금주의 순위 [<%=year %>.<%=month %>월 <%=week %>주]</div>
	<div class="rb_cont">
		<div class="left rb_menus">
			<ul>
				<li class="on"><div id="top100">Top 100</div></li>
				<li><div id="s_top50">서울 Top50</div></li>
				<li>
					<div id="l_top50">광역 Top50</div>
					<div class="rb_m_list" id="loc">
						<span>인천</span>
						<span>대구</span>
						<span>대전</span>
						<span>광주</span>
						<span>울산</span>
						<span>부산</span>
					</div>
				</li>
				<li class="last">
					<div id="p_top50">부위 Top10</div>
					<div class="rb_m_list" id="part">
						<span>눈</span>
						<span>코</span>
						<span>쁘띠</span>
						<span>가슴</span>
						<span class="col2">안면윤곽</span>						
					</div>
				</li>
			</ul>
		</div>
		<div class="left rb_ranklist">		
			<%			
				int count = top100.size()/10 + 1;
			
				int idx = 0;
				
				for(int a = 0 ; a < count ; a++){
					if(top100.size() == 0){
						break;
					}
					String display = "";
					if( a!=0){
						display = "display:none;";
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="top100_<%=a%>" style="<%=display%>">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){						
						if(top100.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = top100.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("hospitalId")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") %></span></td>
				</tr>				
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 서울 top50 --%>
			<%
				int count2 = s_top50.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < count2 ; a++){		
					if(s_top50.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="s_top50_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(s_top50.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = s_top50.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("hospitalId")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") %></span></td>
				</tr>				
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 인천 top50 --%>
			<%			
				int count_top_B = B_top50.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < count_top_B ; a++){	
					if(B_top50.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="B_top50_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(B_top50.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = B_top50.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("hospitalId")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") %></span></td>
				</tr>				
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 대구 top50 --%>
			<%						
				int count_top_C = C_top50.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < count_top_C ; a++){
					if(C_top50.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="C_top50_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(C_top50.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = C_top50.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("hospitalId")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") %></span></td>
				</tr>				
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 대전 top50 --%>
			<%							
				int count_top_D = D_top50.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < count_top_D ; a++){	
					if(D_top50.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="D_top50_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(D_top50.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = D_top50.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("hospitalId")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") %></span></td>
				</tr>				
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 광주 top50 --%>
			<%			
				int count_top_E = E_top50.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < count_top_E ; a++){	
					if(E_top50.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="E_top50_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(E_top50.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = E_top50.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("hospitalId")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") %></span></td>
				</tr>				
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 울산 top50 --%>
			<%						
				int count_top_F = F_top50.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < count_top_F ; a++){		
					if(F_top50.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="F_top50_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(F_top50.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = F_top50.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("hospitalId")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") %></span></td>
				</tr>				
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 부산 top50 --%>
			<%							
				int count_top_G = G_top50.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < count_top_G ; a++){			
					if(G_top50.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="G_top50_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(G_top50.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = G_top50.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("hospitalId")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") %></span></td>
				</tr>
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 눈 top10 --%>
			<%						
				int eyeTopCnt = eyeTop.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < eyeTopCnt ; a++){	
					if(eyeTop.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="eye_top10_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(eyeTop.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = eyeTop.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("id")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") == null ? "0" : data.get("rankingChange") %></span></td>
				</tr>
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 코 top10 --%>
			<%						
				int noseTopCnt = noseTop.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < noseTopCnt ; a++){		
					if(noseTop.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="nose_top10_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(noseTop.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = noseTop.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("id")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") == null ? "0" : data.get("rankingChange") %></span></td>
				</tr>
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 윤곽 top10 --%>
			<%			
				
				int faceTopCnt = faceTop.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < faceTopCnt ; a++){		
					if(faceTop.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="face_top10_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(faceTop.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = faceTop.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("id")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") == null ? "0" : data.get("rankingChange") %></span></td>
				</tr>
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 가슴 top10 --%>
			<%			
				
				int breastTopCnt = breastTop.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < breastTopCnt ; a++){	
					if(breastTop.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="breast_top10_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(breastTop.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = breastTop.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("id")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") == null ? "0" : data.get("rankingChange") %></span></td>
				</tr>
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 체형 top10 --%>
			<%			
				
				int bodyTopCnt = bodyTop.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < bodyTopCnt ; a++){	
					if(bodyTop.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="body_top10_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(bodyTop.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = bodyTop.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
						
						// last입력						
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("id")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") == null ? "0" : data.get("rankingChange") %></span></td>
				</tr>
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>
			
			<%-- 쁘띠 top10 --%>
			<%			
				
				int petitTopCnt = petitTop.size()/10 + 1;
			
				idx = 0;
				
				for(int a = 0 ; a < petitTopCnt ; a++){		
					if(petitTop.size() == 0){
						break;
					}
			%>						
			<table cellpadding="0" cellspacing="0" class="rb_ranklist_tb" id="petit_top10_<%=a%>" style="display:none;">
				<colgroup>
					<col width="17">
					<col width="91">
					<col width="27">
				</colgroup>
				<tbody>
				<%				
					for( int i = 0 ; i < 10; i++){
						if(petitTop.size() == 0){
							break;
						}
						
						HashMap<String, Object> data = petitTop.remove(0);
						
						String icon = "";
						
						if(data.get("rankingChange") != null){
							int rank = Integer.parseInt(data.get("rankingChange").toString());
							if(rank > 0){
								icon = "high";								
							}else if(rank == 0){
								icon = "avg";
							}else if(rank < 0){
								icon = "low";
							}
						}else{
							icon = "avg";
						}
						
						idx++;
						String rb_rnum = "";
						if(idx < 4){
							rb_rnum = "rb_rnum123";
						}else{
							rb_rnum = "rb_rnum";
						}
						if(idx >= 100){
							rb_rnum = "rb_rnum100";
						}
				%>		
				<tr>
					<td class="<%if(i == 9) out.print("last");%>"><span class="<%=rb_rnum %>"><%=idx %></span></td>
					<td class="rb_rl_name <%if(i == 9) out.print("last");%>"><a href="${contextPath }/___/renew/hospital/info/<%=data.get("id")%>"><%=data.get("name") %></a></td>
					<td class="<%if(i == 9) out.print("last");%>"><span class="rb_rl_icons <%=icon%>"><%=data.get("rankingChange") == null ? "0" : data.get("rankingChange") %></span></td>
				</tr>
			    <%
					} %>
				</tbody>
			</table>			
			<% } %>			
		</div>
	</div>
	<div class="clear"></div>
	<div class="rb_ranklist_pager" id="pager">
		<span id="page_count">1/10</span>
		<span>
			<img id="pager_left" alt="이전" src="${contextPath }/img/common/rank_box_pager_left.png">
			<img id="pager_right" alt="다음" src="${contextPath }/img/common/rank_box_pager_right.png">
		</span>
	</div>
</div>