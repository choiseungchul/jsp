<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
<%
 	String sub = "board";
 %>
 <script type="text/javascript">
 $(function(){
	 $('#checkAll').click(function(){
		 if($(this).is(':checked')){
			 $('input[name=pid]').attr('checked', 'checked');
		 }else{
			 $('input[name=pid]').removeAttr('checked');
		 }
	 });
 });
 
function send_delete(){
	if(confirm("선택 내용을 삭제하시겠습니까?")){
		document.frm.submit();
	} 
}
 
 </script>
 <style>
 .deleted{
 	text-decoration: line-through;
 }
 </style>
</head>
<body>
<%@include file="../inc/gnb.jsp" %>
<div class="container-fluid">
 <div class="row">
	 <div class="col-sm-3 col-md-2 sidebar">
	 <%
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)request.getAttribute("list");    
			int total = (Integer)request.getAttribute("total");
			int listCount = 30;
			int pagePerCount = 10;
			int pnum = (Integer)request.getAttribute("pnum");
			int boardId = (Integer)request.getAttribute("bid");
          %>
	 
	 <script type="text/javascript">
	 function go_srch(){
		 var code = encodeURIComponent( $('#srch_code').val() );
		 var text = encodeURIComponent($('#srch_text').val());
		 
		 location.href = '${contextPath}/___/admin/hospital/list?PN=1&SC=' + code + '&ST='+ text;
	 }
	 </script>
	   <%@include file="../inc/left.jsp" %>
	 </div>
 	 <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">게시판검색</h1>
			
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
				  	<option value="name" selected="selected">제목</option>				  	
				  	<option value="address">내용</option>
				  	<option value="homepage">제목+내용</option>
				  	<option value="creator">작성자</option>
				  </select>
				</div>
          	</div>
            <div class="col-lg-3">
			    <div class="input-group">
			      <input type="text" class="form-control" name="srch_text" id="srch_text" value="${ST }">
			      <span class="input-group-btn">
			        <button class="btn btn-default"  type="button" onclick="go_srch()">검색</button>
			      </span>
			    </div><!-- /input-group -->
			  </div><!-- /.col-lg-6 -->
          </div>
          
          <!-- 게시판들 -->
          <div class="row placeholders">
          	<ul id="tabs" class="nav nav-tabs">
          		<li class="<% if(boardId == 15)  out.print("active");%>"><a href="${contextPath }/___/admin/board/15" >공지사항</a></li>
		        <li class="<% if(boardId == 30)  out.print("active");%>"><a href="${contextPath }/___/admin/board/30" >성형전게시판</a></li>
		        <li class="<% if(boardId == 31)  out.print("active");%>"><a href="${contextPath }/___/admin/board/31" >성형후게시판</a></li>
		        <li class="<% if(boardId == 32)  out.print("active");%>"><a href="${contextPath }/___/admin/board/32" >출석게시판</a></li>
		        <li class="<% if(boardId == 25)  out.print("active");%>"><a href="${contextPath }/___/admin/board/25" >수술후기 게시판</a></li>
		        <li class="<% if(boardId == 26)  out.print("active");%>"><a href="${contextPath }/___/admin/board/26" >병원리뷰 게시판</a></li>
		    </ul>
          </div>
          
          
          <h2 class="sub-header">병원목록</h2>
          
          <%
          	if(boardId != 32){
          %>
          <form id="frm"  name="frm" action="${contextPath }/___/admin/board/deleteproc" method="post">
          	<input  type="hidden"  name="type" value="<%=boardId%>">
          	<input  type="hidden"  name="pnum" value="<%=pnum%>">
          <div class="table-responsive">          
            <table class="table table-striped">            	
              <thead>
                <tr>
                  <th><input type="checkbox" id="checkAll"></th>
                  <th>번호</th>
                  <% if(boardId == 25 || boardId == 26){%>
                  <th>병원명</th>
                  <% } %>
                  <th>제목</th>
                  <th>작성자</th>                  
                  <th>조회수</th>
                  <th>등록일</th>
                  <th>상태</th>            
                </tr>
              </thead>
              <tbody>
              	<%
              		int stIdx = total - (pnum-1)*listCount;
              		
              		for(int i = 0 ; i < list.size(); i++){
              			HashMap<String, Object> data = list.get(i);
              			
              			String td_class = "";
              			
              			if(data.get("isDelete").equals("Y")){
              				td_class = "deleted";
              			}              			
              	%>
                <tr>
                  <td class="<%=td_class%>"><input type="checkbox" name="pid" value="<%=data.get("id")%>"></td>
                  <td class="<%=td_class%>"><%=stIdx-i%></td>
                  <% if(boardId == 25 || boardId == 26){%>
                  <td class="<%=td_class%>"><%=data.get("hname") %></td>
                  <% } %>
                  <td class="<%=td_class%>"><a href="${contextPath }/___/admin/board/view/<%=data.get("id")%>?pnum=<%=pnum%>&TP=<%=boardId%>&hid=<%=data.get("hid")%>"><%=data.get("subject") %></a></td>                  
                  <td class="<%=td_class%>"><%=data.get("creator") %></td>                  
                  <td class="<%=td_class%>"><%=data.get("viewCount") %></td>
                  <td class="<%=td_class%>"><%=data.get("createDate") %></td>
                  <td>
                  	<%if(data.get("isDelete").equals("Y")){%>
                  	<font color="red">삭제됨</font>
                  	<%}else{ %>
                  	게시중
                  	<%} %>
                  </td>                  
                </tr>                
                <% } %>
              </tbody>
            </table>          
        </div>
        </form>
        
        
        
        <% }else if(boardId == 32) { %>
        
        
        
        
        <form id="frm"  name="frm" action="${contextPath }/___/admin/board/deleteproc" method="post">
          	<input  type="hidden"  name="type" value="<%=boardId%>">
          	<input  type="hidden"  name="pnum" value="<%=pnum%>">
          <div class="table-responsive">          
            <table class="table table-striped">            	
              <thead>
                <tr>
                  <th><input type="checkbox" id="checkAll"></th>
                  <th>번호</th>                  
                  <th>작성자</th>                  
                  <th>내용</th>
                  <th>작성날짜</th>
                </tr>
              </thead>
              <tbody>
              	<%
              		int stIdx = total - (pnum-1)*listCount;
              		
              		for(int i = 0 ; i < list.size(); i++){
              			HashMap<String, Object> data = list.get(i);
              			
              			String td_class = "";
              			
              			if(data.get("isDelete").equals("Y")){
              				td_class = "deleted";
              			}              			
              	%>
                <tr>
                  <td class="<%=td_class%>"><input type="checkbox" name="pid" value="<%=data.get("id")%>"></td>
                  <td class="<%=td_class%>"><%=stIdx-i%></td>                  
                  <td class="<%=td_class%>"><%=data.get("creator") %></td>                  
                  <td class="<%=td_class%>"><%=data.get("contents") %></td>
                  <td class="<%=td_class%>"><%=data.get("createDate") %></td>
                  <td>
                  	<%if(data.get("isDelete").equals("Y")){%>
                  	<font color="red">삭제됨</font>
                  	<%}else{ %>
                  	게시중
                  	<%} %>
                  </td>                  
                </tr>                
                <% } %>
              </tbody>
            </table>          
        </div>
        </form>
        <% } %>
        <div class="">
        	<button type="button" class="btn btn-default btn-lg" onclick="send_delete()">선택 삭제</button>
        	<%
        		if(boardId != 32) {
        	%>
   			<a href="${contextPath }/___/admin/board/write/<%=boardId %>"><button type="button" class="btn btn-default btn-lg" >글쓰기</button></a>
   			<% }else { %>
   			<a href="${contextPath }/___/admin/board/view/-99999?pnum=1&TP=32"><button type="button" class="btn btn-default btn-lg" >출석체크쓰기</button></a>
   			<% } %>
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
				<li><a href="${contextPath }/___/admin/board/<%=boardId %>?PN=<%=ltPnum%>">&laquo;</a></li>
			<% }else{ %>
				<li class="disabled"><a href="#">&laquo;</a></li>
			<% }
				int loop = pcount;
				if(loop > pagePerCount) loop = pagePerCount;
				
				for( int a=startIdx ; a < startIdx + loop; a++){				
			%>	
					<%if(pnum == a){ %>	
					<li class="active"><a href="${contextPath }/___/admin/board/<%=boardId %>?PN=<%=a%>"><%=a %></a></li>
					<%}else{ %>
					<li><a href="${contextPath }/___/admin/board/<%=boardId %>?PN=<%=a%>"><%=a %></a></li>
					<%}//else %>
			<% } %>
			<% if( startIdx+pagePerCount < pcount ) {
				int gtPnum = startIdx + pagePerCount;
			%>
			<li><a href="${contextPath }/___/admin/board/<%=boardId %>?PN=<%=gtPnum%>">&raquo;</a></li>
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