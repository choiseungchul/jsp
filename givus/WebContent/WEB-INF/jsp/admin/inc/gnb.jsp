<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#"><strong>GIVUS</strong></a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav navbar-left">
      	<li class="<% if(sub.equals("dashboard")) out.print("active"); %>"><a href="#">대쉬보드</a></li>
        <li class="<% if(sub.equals("ranking")) out.print("active"); %>"><a href="${contextPath }/___/admin/ranking/list">랭킹</a></li>
        <li class="<% if(sub.equals("hospital")) out.print("active"); %>"><a href="${contextPath }/___/admin/hospital/list">병원목록</a></li>
        <li class="<% if(sub.equals("board")) out.print("active"); %>"><a href="${contextPath }/___/admin/board/30">게시판</a></li>
        <li class="<% if(sub.equals("user")) out.print("active"); %>"><a href="${contextPath }/___/admin/user/list">사용자</a></li>
        <li class="<% if(sub.equals("manager")) out.print("active"); %>"><a href="#">관리자</a></li>
      </ul>          
      <script type="text/javascript">
      
      </script>
    </div>
  </div>
</div>