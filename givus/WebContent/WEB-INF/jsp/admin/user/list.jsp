<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
<%
 	String sub = "user";
 %>
</head>
<body>
<%@include file="../inc/gnb.jsp" %>
<div class="container-fluid">
 <div class="row">
	 <div class="col-sm-3 col-md-2 sidebar">
	 <%
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)request.getAttribute("list");    
			int total = (Integer)request.getAttribute("total");
			int listCount = (Integer)request.getAttribute("listCount");
			int pagePerCount = 10;
			int pnum = (Integer)request.getAttribute("p");
          %>
	 
	 <script type="text/javascript">
	 $(function(){
		 $('#srch_text').keyup(function(e){
			 if(e.which === 13){
				 go_srch(); 
			 }
		 })
	 });
	 function go_srch(){
		 var code = encodeURIComponent( $('#srch_code').val() );
		 var text = encodeURIComponent($('#srch_text').val());
		 
		 location.href = '${contextPath}/___/admin/user/list?PN=1&SC=' + code + '&ST='+ text;
	 }
	 </script>
	   <%@include file="../inc/left.jsp" %>
	 </div>
 	 <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">병원검색</h1>
			
          <div class="row placeholders">
          	<div class="col-lg-1">
          		<div class="btn-group">
				  <select id="srch_code">
				  <%
				  	String ST = "";
				  	if(request.getAttribute("ST") != null){
				  		ST = request.getAttribute("ST").toString();
				  	}
				  %>				  
				  	<option value="u.name" selected="selected">닉네임</option>				  	
				  	<option value="u.email">이메일</option>		  	
				  </select>
				</div>
          	</div>
            <div class="col-lg-3">
			    <div class="input-group">
			      <input type="text" class="form-control" name="srch_text" id="srch_text" value="${ST }">
			      <span class="input-group-btn">
			        <button class="btn btn-default"   type="button" onclick="go_srch()">검색</button>
			      </span>
			    </div><!-- /input-group -->
			  </div><!-- /.col-lg-6 -->
          </div>
          
          <h2 class="sub-header">병원목록</h2>
          <div class="table-responsive">
          
          
          
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>닉네임</th>
                  <th>이메일</th>                                    
                  <th>상태</th>
                  <th>병원이름</th>
                  <th>병원상태</th>
                </tr>
              </thead>
              <tbody>
              	<%
              		int stIdx = total - (pnum-1)*listCount;
              		
              		for(int i = 0 ; i < list.size(); i++){
              			HashMap<String, Object> data = list.get(i);
              			
              			String user_stat = data.get("userStatus") == null ? "" : data.get("userStatus").toString();
              			String hcstat = data.get("hcstat") == null ? "" : data.get("hcstat").toString();
              			
              			if(!user_stat.equals("")){              				
              				user_stat = MessageHandler.getMessage("admin.user_stat." + user_stat);              				
              			}
              			
              			if(!hcstat.equals("")){
              				hcstat = MessageHandler.getMessage("admin.user_hcstat." + hcstat);
              			}
              			
              	%>
                <tr>
                  <td><%=stIdx-i%></td>
                  <td><a href="${contextPath }/___/admin/user/mod/<%=data.get("id")%>?pnum=<%=pnum%>"><%=data.get("name") %></a></td>
                  <td><a href="${contextPath }/___/admin/user/mod/<%=data.get("id")%>?pnum=<%=pnum%>"><%=data.get("email") %></a></td>                  
                  <td><%=user_stat %></td>
                  <td><a href="${contextPath }/___/admin/hospital/mod/<%=data.get("hid")%>?pnum=1"><%=data.get("hname") %></a></td>                  
                  <td><%=hcstat%></td>
                  
                </tr>                
                <% } %>
              </tbody>
            </table>          
        </div>
        
        <%
		if(total > listCount){
			int pcount = (int)(total / listCount) + 1;
			if(total %listCount == 0) pcount--;
			
			int startIdx = (((pnum-1)/pagePerCount)*pagePerCount) + 1;
			
			int ppcount = (int)(total / listCount) / pagePerCount;			
		%>	
		<div class="paging">
			<ul class="pagination ">
			<% if(startIdx > pagePerCount) {
				int ltPnum = startIdx - pagePerCount;
				%>
				<li><a href="${contextPath }/___/admin/user/list?PN=<%=ltPnum%>">&laquo;</a></li>
			<% }else{ %>
				<li class="disabled"><a href="#">&laquo;</a></li>
			<% }
				int loop = pcount;
				if(loop > pagePerCount) loop = pagePerCount;
				
				for( int a=startIdx ; a < startIdx + loop; a++){				
			%>	
					<%if(pnum == a){ %>	
					<li class="active"><a href="${contextPath }/___/admin/user/list?PN=<%=a%>"><%=a %></a></li>
					<%}else{ %>
					<li><a href="${contextPath }/___/admin/user/list?PN=<%=a%>"><%=a %></a></li>
					<%}//else %>
			<% } %>
			<% if( startIdx+pagePerCount < pcount ) {
				int gtPnum = startIdx + pagePerCount;
			%>
			<li><a href="${contextPath }/___/admin/user/list?PN=<%=gtPnum%>">&raquo;</a></li>
			<%}else{ %>
			<li class="disabled"><a href="#">&raquo;</a></li>
			<% } %>
			</ul>
		</div>
		<%} else { %>
		<div class="paging">
			<ul class="pagination">
				<li class="disabled"><a href="#">1</a></li>
			</ul>
		</div>
		<%} %>
        
        
   	</div>
   	
   </div>
 </div>
   	
<%@include file="../inc/footer.jsp" %>
</body>
</html>