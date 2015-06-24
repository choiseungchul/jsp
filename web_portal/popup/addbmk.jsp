<%@page import="wp.manager.ProfileDAO"%>
<%@page import="java.util.List"%>
<%@page import="wp.databean.ProfileDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/loginchk.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="../script/jquery1.4.4.js"></script>
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
<title>북마크 추가</title>
<script type="text/javascript">
function addurl() {
	var purl = $('select[name=purl] option:selected').val();
	//alert(purl);
	$('input[name=url]:text').val(purl);
}
function chkvalue()
{
	var obj = document.addbmkform;
	
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
<!-- design -->
<form action="../process/bookmarkprc.jsp" method="post" name="addbmkform">
<input type="hidden" name="mode" value="add">
<div id="popup">
  <table width="90%" height="157" border="0" align="center" cellpadding="0" cellspacing="0" class="BigTableBg02">
    <tr>
      <td height="24" align="left" valign="top"><table width="100%" border="0" cellspacing="7" cellpadding="0">
          <tr>
            <td colspan="2">
              <label>
              <select name="purl" id="purl" onchange="addurl()">
			<% 
				List<ProfileDTO> prplist = ProfileDAO.getInstance().getProfileURL(s_prp);
				
				for ( ProfileDTO prp : prplist)
				{
			%>
				<option value="<%=prp.getAlias() %>"><%=prp.getAlias() %></option>
			<%  } %>
			</select> 
              </label>              
            </td>
          </tr>
          <tr>
            <td width="23%">북마크 URL</td>
            <td width="77%">
              <label>
                <input type="text" name="url" id="url" />
                </label>
            </td>
          </tr>
          <tr>
            <td width="23%">북마크 이름</td>
            <td width="77%">
              <label>
                <input type="text" name="name" id="name" />
                </label>
            </td>
          </tr>
          <tr>
            <td>북마크 설명</td>
            <td>
              <label>
                <input type="text" name="desc" id="desc" />
                </label>
            </td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td align="left" valign="middle"><table width="136" border="0" align="center" cellpadding="0" cellspacing="0" class="clear">
        <tr> 
          <td align="left"><a onclick="chkvalue()"><img src="../images/sub_41.gif" width="56" height="22" /></a></td>
          <td align="right"><a onclick="window.close()"><img src="../images/cancel_46.gif" width="56" height="22" /></a></td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>
</form>
</body>
</html>