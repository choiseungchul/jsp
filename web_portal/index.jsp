<%@page import="java.util.logging.Logger"%>
<%@page import="wp.manager.SessionStorage"%>
<%@page import="wp.manager.SessionDAO"%>
<%@page import="wp.databean.SessionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="wp.utils.Property"%>
<%@page import="wp.utils.LoginHTML"%>
<%@page import="wp.main.WPMain"%>
<%@page import="wp.utils.WPParser"%>
<%
	String classname = this.getClass().getName();
	classname = WPParser.getJSPName(classname);
	System.out.println(classname + " page requested");
	
	Logger log = Logger.getLogger(this.getClass().getName());
	
	log.fine(classname + " is request");
	
	Cookie[] cookies = request.getCookies();
	
	String seid = null;
	
	if (cookies != null )
	{
		for ( Cookie cok : cookies )
		{
			if (cok.getName().equals("secui_session"))
			{
				seid = cok.getValue();
				break;
			}
		}
	}
	 
	if ( SessionStorage.loginCheck(seid) && SessionDAO.getInstance().get(seid) != null ) {
		
		response.sendRedirect( "https://" + Property.getProperty("prxserver") + "/" + 
				Property.getProperty("wp.domain") + "/main.jsp");
	}

%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="imagetoolbar" content="no">
<style type="text/css">
<!--
@import url(css/common.css);
@import url(css/style.css); -->

 /* 익스플로러 6.0 png*/	
.png24 { tmp:expression(setPng24(this));}


.png { 
background-image /**/: url("image/bg.gif"); 
background-attachment /**/: fixed; 
background-repeat /**/: no-repeat; 

  _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="image/main_page_bg.png",sizingMethod='crop')} //if IE6 

body {
	background-image: url(images/bg.gif);
}
body {
	background-image: url(images/bg.gif);
}
body,td,th {
	font-family: Arial, Helvetica, sans-serif,"돋움", Dotum;
}
.png1 {background-image /**/: url("img/bg.gif"); 
background-attachment /**/: fixed; 
background-repeat /**/: no-repeat; 

  _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="img/main_page_bg.png",sizingMethod='crop')}
#apDiv1 {
	position:absolute;
	left:680px;
	top:411px;
	width:276px;
	height:122px;
	z-index:1;
}
</style>
<script type="text/javascript" src="script/common.js"></script>
<script type="text/javascript">
function loadproc()
{
	if (!checklogin()) {
		return false;
	}else{
		if ( document.loginform.force.checked == true )
		{
			document.loginform.login_force.value = "true";
		}
		document.loginform.submit();
	}
}

function checklogin()
{
	if(document.loginform.uid.value == "")
	{
		alert("아이디를 입력해주세요 ");
		return false;
	}
	if(document.loginform.pwd.value == "")
	{
		alert("비밀번호를 입력해주세요");
		return false;
	}
	return true;
}

</script>
<title>SSL_VPN</title>
</head>
<body>

<%
/*
	if ( WPMain.isUseCustomLoginPage() )
	{
		LoginHTML custom = new LoginHTML(Property.getProperty("wp.design"));
	    String htmlLayout =	custom.outHTML();
	    out.print(htmlLayout);
	}else{ 
		*/	
		// 기본 디자인 호출
	//} 
%>

<div id="apDiv1">
<form action="process/userprc.jsp" name="loginform" id="loginform" method="post">
		<input type="hidden" name="mode" value="login">
		<input type="hidden" name="login_force" value=""/>
  <table width="276" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="24" align="left" valign="top"><img src="images/img_08.gif" width="40" height="11" />
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="69%">
              <label>
                <input type="text" name="uid" id="uid" />
                </label>
            </td>
            <td width="31%" rowspan="2" align="right"><a onclick="loadproc()" >
            <img src="images/img_12.gif" width="85" height="48" alt="로그인"/></a></td>
          </tr>
          <tr>
            <td>
              <label>
                <input type="password" name="pwd" id="pwd" 
                onkeydown="if(event.keyCode == 13 ) loadproc();"/>
                </label>
            </td>
          </tr>
          <tr>
          	<td>강제 로그인 (prp1) :<input type="checkbox" id="force" name="force" checked="checked"/></td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
  </form>
</div>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="65" valign="top">
    <table width="1024" border="0" align="center" cellpadding="0" cellspacing="0"  style="width :1024px; margin:0 auto;">
      <tr>
        <td width="299" align="left"><a href="#none"><img src="images/img_01.gif" width="299" height="65" /></a></td>
        <td width="725" align="left">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td valign="top" align="center" style="background-color: #F6F6F6">
      <table width="1024" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top"><img src="images/img_04.gif" width="1024" height="307" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="39"></td>
  </tr>
  <tr>
    <td height="140">&nbsp;</td>
  </tr>
  <tr>
    <td valign="bottom">
    <table width="1024" border="0" align="center" cellpadding="0" cellspacing="0" class="bBtn">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="okBtn">
          <tr>
            <td width="2%" valign="top">&nbsp;</td>
            <td width="15%" valign="top"><img src="images/footer_logo.gif" width="150" height="31" /></td>
            <td width="25%" valign="top"><img src="images/footer_address.gif" width="261" height="30" /></td>
            <td width="58%" valign="top"><img src="images/footer_repre_phone.gif" width="126" height="16" /></td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
</table>
</body>
</html>