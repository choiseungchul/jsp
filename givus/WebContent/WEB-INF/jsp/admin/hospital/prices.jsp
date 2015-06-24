<%@page import="kr.co.zadusoft.givus.util.GivusUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String sub = "hospital";
%>
<%@include file="../inc/top.jsp" %>
<%
	int hid = (Integer)request.getAttribute("hid");
%>
<script type="text/javascript">

</script>
</head>
<body>
<%@include file="../inc/gnb.jsp" %>
<div class="container-fluid">
 <div class="row">
	 <div class="col-sm-3 col-md-2 sidebar">
	 <%	 
	 	List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)request.getAttribute("list");
	 	String pnum = request.getAttribute("pnum").toString();
	 	
	 %>
	   <%@include file="../inc/left.jsp" %>
	 </div>
	 <form name="frm" id="frm" action="${contextPath }/___/admin/hospital/mod_price" method="post">
	 	<input type="hidden" name="hid" value="<%=hid%>">
 	 <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">병원검색</h1>
			
          <div class="row placeholders">
          	
          </div>
          
          <h2 class="sub-header">병원목록</h2>
          <div class="table-responsive">
          
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>카테고리</th>
                  <th>수술명</th>
                  <th>가격</th>      
                  <th>등록날짜</th>
                  <th>수정날짜</th>                              
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
                  <td><%=data.get("createDate") %></td>
                  <td><%=data.get("updateDate") %></td>            
                </tr>       
                <% }//for %>         
              </tbody>
            </table>          
        </div>
        <div class="">
        	<button type="button" class="btn btn-default btn-lg" onclick="document.frm.submit();">수정</button>
        	<button type="button" class="btn btn-default btn-lg" onclick="document.frm.reset();">되돌리기</button>        	
        	<a href="${contextPath }/___/admin/hospital/list?PN=<%=pnum%>"><button type="button" class="btn btn-default btn-lg">병원목록</button></a>
        </div>
   	</div>
   	</form>
   </div>
 </div>
   	
<%@include file="../inc/footer.jsp" %>
</body>
</html>