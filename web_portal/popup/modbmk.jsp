<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	request.setCharacterEncoding("UTF-8");
	
	String url  = request.getParameter("url");
	String name = request.getParameter("name");
	String desc = request.getParameter("desc");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="imagetoolbar" content="no">
<style type="text/css">
<!--
@import url(../css/common.css);
@import url(../css/style.css); -->

 /* 익스플로러 6.0 png*/	
.png24 { tmp:expression(setPng24(this));}


body,td,th {
	font-family: Arial, Helvetica, sans-serif,"돋움", Dotum;
}
#apDiv1 {
	position:absolute;
	left:680px;
	top:411px;
	width:276px;
	height:122px;
	z-index:1;
}
</style>
<title>북마크 수정</title>
<script type="text/javascript">
function chkvalue()
{
	var obj = document.modbmkform;
	
	var flag = true;
	
	if ( obj.url.value == "")
	{
		alert ("URL을 입력해주세요");
		flag = false;
		return;
	}
	if (obj.name.value == "")
	{
		alert ("북마크 이름을 넣어주세요.");
		flag = false;
		return;
	}
	if (obj.desc.value == "")
	{
		alert ("북마크에 대한 설명을 넣어주세요");
		flag = false;
		return;
	}
	if (flag) obj.submit();
}
</script>
</head>
<body>
<form action="../process/bookmarkprc.jsp" method="post" name="modbmkform">
<input type="hidden" name="mode" value="modify">
<input type="hidden" name="prename" value="<%=name %>">
<div id="popup">
  <table width="90%" height="157" border="0" align="center" cellpadding="0" cellspacing="0" class="BigTableBg02">
    <tr>
      <td height="24" align="left" valign="top"><table width="100%" border="0" cellspacing="7" cellpadding="0">
          <tr>
            <td width="23%">북마크 URL</td>
            <td width="77%">
              <label>
                <input type="text" name="url" id="url" value="<%=url %>"/>
                </label>
                     
            </td>
          </tr>
          <tr>
            <td width="23%">북마크 이름</td>
            <td width="77%">
              <label>
                <input type="text" name="name" id="name" value="<%=name %>"/>
                </label>
                     
            </td>
          </tr>
          <tr>
            <td>북마크 설명</td>
            <td>
              <label>
                <input type="text" name="desc" id="desc" value="<%=desc %>" />
                </label>
            </td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td align="left" valign="middle"><table width="136" border="0" align="center" cellpadding="0" cellspacing="0" class="clear">
        <tr> 
          <td align="left"><a onclick="chkvalue()"><img src="../images/change.gif" width="56" height="22" /></a></td>
          <td align="right"><a onclick="window.close()"><img src="../images/cancel_46.gif" width="56" height="22" /></a></td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>
</form>
</body>
</html>