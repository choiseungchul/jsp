<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
<%
 	String sub = "hospital";
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
			String type = request.getAttribute("type").toString();
			
			String SC = request.getAttribute("SC") == null ? "" :  request.getAttribute("SC").toString();
			String ST = request.getAttribute("ST") == null ? "" :  request.getAttribute("ST").toString();
			
          %>
	 
	 <script type="text/javascript">
	 function go_srch( type ){
		 var code = encodeURIComponent( $('#srch_code').val() );
		 var text = encodeURIComponent($('#srch_text').val());
		 //var text = $('#srch_text').val();
		 
		 location.href = '${contextPath}/___/admin/hospital/list?PN=1&SC=' + code + '&ST='+ text + '&type=' + type;
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
				  	<option value="name" selected="selected">병원이름</option>				  	
				  	<option value="address">주소</option>
				  	<option value="homepage">홈페이지</option>
				  	<option value="creator">아이디</option>
				  </select>
				</div>
          	</div>
            <div class="col-lg-3">
			    <div class="input-group">
			      <input type="text" class="form-control" name="srch_text" id="srch_text" value="${ST }">
			      <span class="input-group-btn">
			        <button class="btn btn-default"  type="button" onclick="go_srch('A')">검색</button>
			      </span>
			    </div><!-- /input-group -->
			  </div><!-- /.col-lg-6 -->
			  <div class="col-lg-3"> 
			  	<button class="btn btn-primary" onclick="go_srch('D')">공개병원만</button>
				  <button class="btn btn-primary" onclick="go_srch('N')">비공개병원만</button>
				  <button class="btn btn-primary" onclick="go_srch('A')">모든병원</button>
			  </div>
          </div>
          
          <h2 class="sub-header">병원목록</h2>
          <div class="table-responsive">
          
          
          
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>아이디</th>
                  <th>병원이름</th>                  
                  <th>가격정보</th>
                  <th>홈페이지</th>
                  <th>주소</th>
                  <th>상태</th>                                    
                </tr>
              </thead>
              <tbody>
              	<%
              		int stIdx = total - (pnum-1)*listCount;
              		
              		for(int i = 0 ; i < list.size(); i++){
              			HashMap<String, Object> data = list.get(i);
              			
              			String stat = data.get("stat") == null ? "M" : data.get("stat").toString();
              			
              			if(stat.equals("A")){
              				stat = "승인";
              			}else if(stat.equals("C")){
              				stat = "승인취소";
              			}else if(stat.equals("W")){
              				stat = "대기";
              			}else if(stat.equals("M")){
              				stat = "관리자입력";
              			}
              	%>
                <tr>
                  <td><%=stIdx-i%></td>
                  <td><%=data.get("creator") %></td>
                  <td><a href="${contextPath }/___/admin/hospital/mod/<%=data.get("id")%>?pnum=<%=pnum%>"><%=data.get("name") %></a></td>
                  <td><a href="${contextPath }/___/admin/hospital/prices/<%=data.get("id")%>?pnum=<%=pnum%>">가격정보</a></td>
                  <td><a href="<%=data.get("homepage") %>" target="_blank"><%=data.get("homepage") %></a></td>
                  <td><a href="${contextPath }/___/admin/hospital/mod/<%=data.get("id")%>?pnum=<%=pnum%>"><%=data.get("address") %></a></td>                  
                  <td><%=stat %></td>
                  
                </tr>                
                <% } %>
              </tbody>
            </table>          
        </div>
        
        <div class="">
   			<a href="${contextPath }/___/admin/hospital/addnew?pnum=<%=pnum%>"><button type="button" class="btn btn-default btn-lg" >병원 추가</button></a>
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
				<li><a href="${contextPath }/___/admin/hospital/list?PN=<%=ltPnum%>&SC=<%=SC%>&ST=<%=ST%>&type=<%=type%>">&laquo;</a></li>
			<% }else{ %>
				<li class="disabled"><a href="#">&laquo;</a></li>
			<% }
				int loop = pcount;
				if(loop > pagePerCount) loop = pagePerCount;
				
				for( int a=startIdx ; a < startIdx + loop; a++){				
			%>	
					<%if(pnum == a){ %>	
					<li class="active"><a href="${contextPath }/___/admin/hospital/list?PN=<%=a%>&SC=<%=SC%>&ST=<%=ST%>&type=<%=type%>"><%=a %></a></li>
					<%}else{ %>
					<li><a href="${contextPath }/___/admin/hospital/list?PN=<%=a%>&SC=<%=SC%>&ST=<%=ST%>&type=<%=type%>"><%=a %></a></li>
					<%}//else %>
			<% } %>
			<% if( startIdx+pagePerCount < pcount ) {
				int gtPnum = startIdx + pagePerCount;
			%>
			<li><a href="${contextPath }/___/admin/hospital/list?PN=<%=gtPnum%>&SC=<%=SC%>&ST=<%=ST%>&type=<%=type%>">&raquo;</a></li>
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