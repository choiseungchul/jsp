<%@page import="wp.utils.DateUtil"%>
<%@page import="wp.utils.Property"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
function c_logout()
{
	window.top.location.href = "https://<%=Property.getProperty("prxserver")%>/" + 
	"<%=Property.getProperty("wp.domain")%>" + "/process/userprc.jsp?mode=logout";
}
function c_home()
{
	window.top.location.href = "https://<%=Property.getProperty("prxserver")%>/" + 
	"<%=Property.getProperty("wp.domain")%>" + "/main.jsp";
}
</script>
<style type="text/css">
a {
	text-decoration:none;
	cursor: pointer;
}
a:hover, a.selected {color:blue;}
#top_userinfo {
	width: 100%;
	height:25px;
	margin-left: 0px;
	margin-top: auto;
	vertical-align:middle;
	padding : 0px 0px 0px 0px; 
	background:url(images/sub_01.gif);
	text-align: center;
	font-family:Arial, Helvetica, sans-serif,"돋움", Dotum;
	font-size: 11px;
	font-weight: 800;
}
</style>
</head>
<body style="margin-top: 0px; width: 100% ;height: 25px; overflow : hidden;" >
<%
	Cookie[] coks = request.getCookies();

	String s_user = null;
	String cdate  = null;

	if ( coks != null )
	{
		for ( Cookie cok : coks )
		{
			if (cok.getName().equals("secui_user"))
			{
				s_user = cok.getValue();
			}
			if (cok.getName().equals("vpn_wp_cdate"))
			{
				cdate = cok.getValue();
			}
		}
	}
	
	String[] dayArr = new String[3];
	String[] timeArr = new String[3];
	
	if (cdate != null)
	{
		cdate = cdate.replaceAll(" ", "/");
		
		String[] date = cdate.split("/");
		
		String day = date[0];
		String time = date[1];
		
		dayArr = day.split("-"); 
		timeArr = time.split(":");
	}
	
%> 
<div id="top_userinfo">
	<span style="margin-right: 300px;"><%=s_user %> 님 환영합니다.</span>
	<span style="margin-right: 50px;">최초접속시간 : <%=dayArr[0]%>년&nbsp;<%=dayArr[1] %>월&nbsp;<%=dayArr[2] %>일&nbsp;&nbsp;&nbsp;<%=timeArr[0] %>시&nbsp;<%=timeArr[1] %>분&nbsp;<%=timeArr[2] %>초</span>
	<span><a onclick="c_home()">홈으로&nbsp;&nbsp;&nbsp;</a></span>
	<span><a onclick="c_logout()">로그아웃</a></span>
</div>
<script>

	if (top == parent)
	{
		//alert("최상위 userinfo.html ");
		
	}else{
		//alert("하위 userinfo.html ");
		//alert (parent.location);
		//alert (this.parent.document.getElementsByTagName("frameset").length);
		if ( parent.document.getElementsByTagName("frameset").length > 0 ) {
			parent.document.getElementsByTagName("frameset")[0].setAttribute("rows","0,*");
		}
		else if (parent.document.getElementsByTagName("iframe").length > 0) {
			var ifrm = parent.document.getElementsByTagName("iframe");
			for ( var i = 0 ; i < ifrm.length ; i++)
			 {
				if (ifrm[i].name == "sslvpn_bluefin")
				{
					ifrm[i].setAttribute("width","0");
					ifrm[i].setAttribute("height","0");
					ifrm[i].setAttribute("hspace","0");
					ifrm[i].setAttribute("vspace","0");
					break;
				}
			 }
		}
		location.href = "about:blank";
	}

</script>
</body>
</html>