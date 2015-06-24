<%@page import="java.util.Date"%>
<%@page import="dynamic.util.DateUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sub = "ranking";
%>
<%@include file="../inc/top.jsp" %>
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
	 function go_srch(){
		 var code = $('#srch_code').val();
		 var text = $('#srch_text').val();
		 
		 location.href = '${contextPath}/___/admin/hospital/list?PN=<%=pnum%>&SC=' + code + '&ST='+ text;
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
				  	String SD = "";
				  	if(request.getAttribute("SD") != null){
				  		SD = request.getAttribute("SD").toString();
				  	}
				  %>				  
				  	<option value="name" selected="selected">병원이름</option>
				  	<option value="address">주소</option>
				  	<option value="homepage">홈페이지</option>
				  	<option value="creator">아이디</option>
				  </select>
				</div>
          	</div>
            <div class="col-lg-3">
			    <div class="input-group">
			     	<select>
			     	
			     	</select>			     
			    </div><!-- /input-group -->
			  </div><!-- /.col-lg-6 -->
          </div>
          
          <h2 class="sub-header">병원목록</h2>
          <div class="table-responsive">
          
          
          
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>랭킹이름</th>                  
                  <th>랭킹기간</th>                  
                  <th>생성날짜</th>
                </tr>
              </thead>
              <tbody>
              	<%
              		int stIdx = total - (pnum-1)*listCount;
              		
              		for(int i = 0 ; i < list.size(); i++){
              			HashMap<String, Object> data = list.get(i);
              		
              			String startDate = DateUtil.formatDate((Date)data.get("startDate"), DateUtil.YYYYMMDD);
              			String endDate = DateUtil.formatDate((Date)data.get("endDate"), DateUtil.YYYYMMDD);
              			
              	%>
              	
                <tr>
                  <td><%=stIdx-i%></td>
                  <td><a href="${contextPath }/___/admin/ranking/view/<%=data.get("id")%>?PN=<%=pnum%>"><%=data.get("name") %></a></td>
                  <td><%=startDate%> ~ <%=endDate %></td>
                  <td><%=data.get("createDate") %></td>
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
				<li><a href="${contextPath }/___/admin/ranking/list?PN=<%=ltPnum%>">&laquo;</a></li>
			<% }else{ %>
				<li class="disabled"><a href="#">&laquo;</a></li>
			<% }
				int loop = pcount;
				if(loop > pagePerCount) loop = pagePerCount;
				
				for( int a=startIdx ; a < startIdx + loop; a++){				
			%>	
					<%if(pnum == a){ %>	
					<li class="active"><a href="${contextPath }/___/admin/ranking/list?PN=<%=a%>"><%=a %></a></li>
					<%}else{ %>
					<li><a href="${contextPath }/___/admin/ranking/list?PN=<%=a%>"><%=a %></a></li>
					<%}//else %>
			<% } %>
			<% if( startIdx+pagePerCount < pcount ) {
				int gtPnum = startIdx + pagePerCount;
			%>
			<li><a href="${contextPath }/___/admin/ranking/list?PN=<%=gtPnum%>">&raquo;</a></li>
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