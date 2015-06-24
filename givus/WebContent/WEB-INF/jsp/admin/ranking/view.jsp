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
          %>
	 
	 <script type="text/javascript">
	 
	 </script>
	   <%@include file="../inc/left.jsp" %>
	 </div>
 	 <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">병원검색</h1>
			
          <div class="row placeholders">
          </div>	
          
          <h2 class="sub-header">병원목록</h2>
          <div class="table-responsive">
          
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>랭킹</th>
                  <th>병원이름</th>                  
                  <th>병원등급</th>                  
                  <th>평균</th>
                  <th>전문성</th>
                  <th>안전성</th>
                  <th>만족성</th>
                  <th>규모성</th>
                  <th>편의성</th>
                </tr>
              </thead>
              <tbody>
              	<%              		
              		for(int i = 0 ; i < list.size(); i++){
              			HashMap<String, Object> data = list.get(i);
              		
              			String startDate = DateUtil.formatDate((Date)data.get("startDate"), DateUtil.YYYYMMDD);
              			String endDate = DateUtil.formatDate((Date)data.get("endDate"), DateUtil.YYYYMMDD);
              	%>
                <tr>
                  <td><%=i+1%></td>
                  <td><%=data.get("name") %></td>
                  <td><%=data.get("grade") %></td>
                  <td><%=data.get("totalPoint") %></td>
                  <td><%=data.get("expertPoint") %></td>
                  <td><%=data.get("safePoint") %></td>
                  <td><%=data.get("satisfyPoint") %></td>
                  <td><%=data.get("sizePoint") %></td>
                  <td><%=data.get("convinientPoint") %></td>
                </tr>                
                <% } %>
              </tbody>
            </table>          
        </div>
        
   	</div>
   	
   </div>
 </div>
   	
<%@include file="../inc/footer.jsp" %>
</body>
</html>