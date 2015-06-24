<%@page import="java.text.DecimalFormat" %>
<%@page import="kr.co.zadusoft.contents.util.RelativeDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>
<%-- 헤더 삽입 --%>
<%@include file="inc/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/main.css?noc=<%=System.currentTimeMillis() %>" />
<title></title>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#ranking_sort').change(function(){
		var val = $('#ranking_sort option:selected').val();
		if(val != ''){
			var type = val.split(":")[0];
			var code = val.split(":")[1];
			
			location.href="${contextPath}/___/renew/rank100?type=" + type + "&code=" + code;
		}else{
			location.href="${contextPath}/___/renew/rank100";
		}
	});
	
	$('.m1').addClass('sub on');
	
	var rank_type = $('#ranking_sort option:selected').text();
	
	$('#ranking_text').text(rank_type);
});
</script>
</head>
<body>
<div class="wrap">
<%@include file="inc/top.jsp"%>
<div class="wrapper clear">	
	<%
	
		String type = request.getAttribute("type") == null ? "" : request.getAttribute("type").toString();
		String code = request.getAttribute("code") == null ? "" : request.getAttribute("code").toString();
	%>
	<div class="content">
		<!-- ranking -->
		<div class="rank_top">
			<h2 id="ranking_text">Top 100</h2>
			<div class="rank_sort">
				<select  id="ranking_sort">
					<option value="" <%if(type.equals("")) out.print("selected=\"selected\""); %>>종합순위</option>
					<option value="LC:AA" <%if(type.equals("LC") && code.equals("AA")) out.print("selected=\"selected\""); %>>서울TOP</option>
					<option value="LC:A" <%if(type.equals("LC") && code.equals("A")) out.print("selected=\"selected\""); %>>경기TOP</option>
					<option value="LC:B" <%if(type.equals("LC") && code.equals("B")) out.print("selected=\"selected\""); %>>인천TOP</option>
					<option value="LC:G" <%if(type.equals("LC") && code.equals("G")) out.print("selected=\"selected\""); %>>부산TOP</option>
					<option value="LC:C" <%if(type.equals("LC") && code.equals("C")) out.print("selected=\"selected\""); %>>대구TOP</option>					
					<option value="LC:D" <%if(type.equals("LC") && code.equals("D")) out.print("selected=\"selected\""); %>>대전TOP</option>
					<option value="LC:E" <%if(type.equals("LC") && code.equals("E")) out.print("selected=\"selected\""); %>>광주TOP</option>
					<option value="LC:F" <%if(type.equals("LC") && code.equals("F")) out.print("selected=\"selected\""); %>>울산TOP</option>
					<option value="PT:eye" <%if(type.equals("PT") && code.equals("eye")) out.print("selected=\"selected\""); %>>눈TOP</option>
					<option value="PT:nose" <%if(type.equals("PT") && code.equals("nose")) out.print("selected=\"selected\""); %>>코TOP</option>
					<option value="PT:petit" <%if(type.equals("PT") && code.equals("petit")) out.print("selected=\"selected\""); %>>쁘띠TOP</option>
					<option value="PT:breast" <%if(type.equals("PT") && code.equals("breast")) out.print("selected=\"selected\""); %>>가슴TOP</option>
					<option value="PT:face" <%if(type.equals("PT") && code.equals("face")) out.print("selected=\"selected\""); %>>안면윤곽TOP</option>
					<option value="PT:body" <%if(type.equals("PT") && code.equals("body")) out.print("selected=\"selected\""); %>>체형TOP</option>					
				</select>
			</div>
			<div class="ranking_list clear">
				<table cellpadding="0" cellspacing="0" class="ranking_list_tb">
					<colgroup>
						<col width="64">
						<col width="134">
						<col width="108">
						<col width="107">
						<col width="91">
						<col width="91">
						<col width="91">
						<col width="91">					
						<col width="91">
						<col width="92">
					</colgroup>
					<thead>
					<tr>
						<th class="first_bg">순위</th>
						<th>병원</th>
						<th>등급</th>
						<th>평균</th>
						<th>전문성<br/>(20%)</th>
						<th>안전성<br/>(30%)</th>
						<th>만족성<br/>(30%)</th>
						<th>규모성<br/>(10%)</th>
						<th>편의성<br/>(10%)</th>
						<th class="last_bg">지역랭킹</th>
					</tr>
					</thead>
					<tbody>
					<%
						List<HashMap<String, Object>> data = (List<HashMap<String, Object>>)request.getAttribute("top50list");
					
						for ( int i = 0 ; i < data.size() ; i++){
							HashMap<String, Object> item = data.get(i);
							if(i %10 == 0 && i != 0){
								// 10개째마다 추가한다
					%>
					<tr>
						<td colspan="10"></td>
					</tr>					
					
					<% } 
							String tdclass = "";
							String overClass = "";
							if(i < 3){
								tdclass = "top123";
							}
							if(i %2 == 1){
								overClass = "back2";
							}
					%>
					<tr>
						<td class="<%=overClass %> <%=tdclass%>"><%=i+1 %></td>
						<td class="<%=overClass %> <%=tdclass%> blue"><a class="blue" href="${contextPath }/___/renew/hospital/info/<%=item.get("id")%>"><%=item.get("hospitalname") == null ? item.get("name") : item.get("hospitalname") %></a></td>
						<td class="<%=overClass %> red"><%=item.get("grade") %></td>
						<td class="<%=overClass %> skyblue"><%=String.format("%.2f",item.get("totalPoint")) %></td>
						<td class="<%=overClass %>"><%=String.format("%.2f",item.get("safePoint")) %></td>
						<td class="<%=overClass %>"><%=String.format("%.2f",item.get("expertPoint")) %></td>
						<td class="<%=overClass %>"><%=String.format("%.2f",item.get("satisfyPoint")) %></td>					
						<td class="<%=overClass %>"><%=String.format("%.2f",item.get("sizePoint")) %></td>
						<td class="<%=overClass %>"><%=String.format("%.2f",item.get("convenientPoint")) %></td>						
						<td class="<%=overClass %>"> - </td>
					</tr>
					<%} %>
					</tbody>
				</table>
			</div><!-- ranking_list -->
			
			<div class="all_ranking">
				<a href="#" class="rank_all_link">모든 순위보기 &nbsp;&nbsp;  ▶</a>
			</div>
			
		</div><!-- rank_top -->
		
		<div class="rank_alert_text">
			※ GIVUS 순위는 병원사이트, 전화, 정부자료 등의 조사로 결정되었습니다. 하지만 이 순위는 GIVUS만의 기준이므로 정보 이용 시 참고로만 사용하시길 바랍니다.
		</div>
	
	</div><!-- content -->
	
</div><!-- wrapper -->
</div><!-- wrap -->
<%@include file="inc/footer.jsp"%>
</body>
</html>