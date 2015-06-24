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
		
		<%
		
			int hid = (Integer)request.getAttribute("hid");
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)request.getAttribute("list");
			
		%>
		
		<form name="frm" id="frm" action="${contextPath }/___/renew/mypage/modhprice" method="post">
			<input type="hidden" name="hid" value="<%=hid%>">
		<div class="right_content">
			
			<h2>가격정보 변경</h2>
			<div class="myhinfo">
				<table cellpadding="0" cellspacing="0" class="myhinfo_tb price_tb">
					<colgroup>
						<col width="50">
						<col width="130">
						<col width="330">
						<col width="210">
					</colgroup>
					<thead>
						<tr>
						  <th>번호</th>
		                  <th>카테고리</th>
		                  <th>수술명</th>
		                  <th>가격</th>   
						</tr>
					</thead>
					<tbody>
					<%
              		for(int i = 0 ; i < list.size(); i++){
              			HashMap<String, Object> data = list.get(i);              			
	              	%>
	                <tr>
	                  <td><%=i+1%></td>
	                  <td><%=data.get("keyname") %></td>
	                  <td><%=data.get("name") %></td>
	                  <td>                  	
	                  	<input type="text" name="price" value="<%=data.get("price") == null ? "" : data.get("price").toString() %>"> 원
	                  	<input type="hidden" name="operId" value="<%=data.get("id")%>">
	                  	<input type="hidden" name="oname" value="<%=data.get("name")%>">                  	
	                  </td>
	                </tr>       
	                <% }//for %>  					
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