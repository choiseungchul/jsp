<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sub = "user";
%>
<%@include file="../inc/top.jsp" %>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/admin/hospital.css?noc=<%=System.currentTimeMillis() %>" />
<link type="text/css" href="${contextPath}/script/jquery-ui-1.10.3/css/redmond/jquery-ui-1.10.3.custom.css" rel="stylesheet"/> 
<script type="text/javascript" src="${contextPath}/script/jquery-ui-1.10.3/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${contextPath}/script/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#publishDate').datepicker({		
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    showMonthAfterYear: true,
		    yearSuffix: '년'
		  	
	});
	
});

</script>
</head>
<body>
<%@include file="../inc/gnb.jsp" %>
<div class="container-fluid">
 <div class="row">
	 <div class="col-sm-3 col-md-2 sidebar">	 	
	   <%@include file="../inc/left.jsp" %>
	 </div>
	 
	 <%
              
         	String pnum = request.getAttribute("pnum").toString();
          
          	HashMap<String, Object> user_info = (HashMap<String, Object>)request.getAttribute("user_info");
              
     %>
	 
 	 <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
 	 <form id="frm" name="frm"  action="${contextPath }/___/admin/user/modproc" method="post">
 	 	 <input type="hidden" name="uid" value="<%=user_info.get("id")%>">
 	 
          <h1 class="page-header">사용자 정보</h1>
          <div class="row placeholders">            
          </div>          
          
          <h2 class="sub-header">Section title</h2>
          <div class="table-responsive">
            <table class="table table-striped">                            
              <tbody>
                <tr>
					<td class="tit">닉네임</td>
					<td class="cont">
						<input type="text" class="hos_add_input" name="name" id="name" value="<%=user_info.get("name")%>">						
					</td>
					<td class="tit">이메일</td>
					<td class="cont">						
						<input type="text" class="hos_add_input" name="email" id="email" value="<%=user_info.get("email")%>">
					</td>
				</tr>
				
				<tr>
					<td class="tit">성별</td>
					<td class="cont">	
						<select name="gender">
							<option value="F" <%if(user_info.get("gender").equals("F")) out.print("selected='selected'"); %>>여자</option>
							<option value="M" <%if(user_info.get("gender").equals("M")) out.print("selected='selected'"); %>>남자</option>
						</select>
					</td>
					<td class="tit">생년월일</td>
					<td class="cont">	
						<input type="text" class="hos_add_input" name="birthday" id="birthday" value="<%=user_info.get("birthday")%>">
					</td>
				</tr>
				
				<tr>
					<td class="tit">가입일</td>
					<td class="cont">	<%=user_info.get("createDate") %></td>
					<td class="tit">최근 로그인 날짜</td>
					<td class="cont"><%=user_info.get("lastLoginDate")%>	</td>
				</tr>
				
				<tr>
					<td class="tit">사용자 상태</td>
					<td class="cont">
						<select name="userStatus">
							<option value="A" <%if(user_info.get("userStatus").equals("A")) out.print("selected='selected'"); %>>사용가능</option>
							<option value="L" <%if(user_info.get("userStatus").equals("L")) out.print("selected='selected'"); %>>차단됨</option>
							<option value="W" <%if(user_info.get("userStatus").equals("W")) out.print("selected='selected'"); %>>탈퇴대기</option>
							<option value="D" <%if(user_info.get("userStatus").equals("D")) out.print("selected='selected'"); %>>탈퇴완료</option>
						</select>						
					</td>
					<td class="tit">사용자 타입</td>
					<td class="cont">
						<select name="userType">
							<option value="G" <%if(user_info.get("userType").equals("A")) out.print("selected='selected'"); %>>일반</option>
							<option value="H" <%if(user_info.get("userType").equals("H")) out.print("selected='selected'"); %>>병원</option>
							<option value="M" <%if(user_info.get("userType").equals("M")) out.print("selected='selected'"); %>>관리자</option>
						</select>						
					</td>					
				</tr>
				
				<tr>
					<td class="tit">탈퇴이유</td>
					<td class="cont" colspan="3">
						<div class=""><%=user_info.get("reason1")%></div>
						<div class=""><%=user_info.get("reason2")%></div>
						<div class=""><%=user_info.get("reasonText")%></div>
						<div class=""><%=user_info.get("wuser_agr")%></div>
						<div class=""><%=user_info.get("wcdate")%></div>	
					</td>
				</tr>
				
				<tr>
					<td class="tit">병원정보</td>
					<td class="cont">
						<%
							if( user_info.get("hname") != null ){
						%>
						<a href="${contextPath }/___/admin/hospital/mod/<%=user_info.get("hid")%>?pnum=1"><%=user_info.get("hname") %></a>
						<% }else{ %>
						병원정보가 없습니다.
						<% } %>	
					</td>		
					<td class="tit">병원승인정보</td>
					<td class="cont">
						<%
							if( user_info.get("hcstat") != null ){
						%>
						<select name="hcstat">
							<option value="A" <%if(user_info.get("hcstat").equals("A")) out.print("selected='selected'"); %>>승인</option>
							<option value="W" <%if(user_info.get("hcstat").equals("W")) out.print("selected='selected'"); %>>대기</option>
							<option value="C" <%if(user_info.get("hcstat").equals("C")) out.print("selected='selected'"); %>>승인거부</option>
						</select>	
						<% }else{ %>
						병원정보가 없습니다.
						<% } %>
					</td>					
				</tr>
				
              </tbody>
            </table>          
        </div>
         	
        <div class="admin_btns">
        	<button type="button" class="btn btn-default btn-lg" onclick="document.frm.submit();">수정</button>
        	<button type="button" class="btn btn-default btn-lg" onclick="document.frm.reset();">되돌리기</button>        	
        	<a href="${contextPath }/___/admin/user/list?PN=<%=pnum%>"><button type="button" class="btn btn-default btn-lg">사용자목록</button></a>
        </div>
   	</form>
        
        
        
   	</div>  
   	
   	
   </div>
 </div>
 
<%@include file="../inc/footer.jsp" %>
</body>
</html>