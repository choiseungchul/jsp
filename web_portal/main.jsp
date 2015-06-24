<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="wp.utils.WPParser"%>
<%@page import="java.util.List"%>
<%@page import="wp.utils.Property"%>
<%@page import="wp.main.WPMain"%>
<%@page import="wp.utils.LoginHTML"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="wp.cli.CmdString"%>
<%@page import="java.util.Map"%>
<%@page import="wp.cli.CLIParser"%>
<%@page import="wp.cli.Command"%>
<%@page import="wp.utils.ShowMsg"%>
<%@page import="wp.manager.BookMarkDAO"%>
<%@page import="wp.databean.BookMarkDTO"%>
<%@page import="wp.databean.ProfileDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="wp.manager.ProfileDAO"%>
<%@include file="include/loginchk.jsp" %> 
<% 


	String classname = this.getClass().getName();
	classname = WPParser.getJSPName(classname);
	System.out.println(classname + " page requested");
	
	String userid = null;
	String sessid = null;
	String propf = null;
	
	List<BookMarkDTO> sysbmklist = BookMarkDAO.getInstance().getSysBmk(s_user);
	
	List<BookMarkDTO> userbmklist = new ArrayList<BookMarkDTO>();
	
	String cmdstr = String.format(CmdString.s_user_bmk, s_user);
	 
	Command cmd = new Command();
	
	cmd.runCmd(cmdstr);
	
	String result = cmd.getExitValue();
	
	List<HashMap<String, String>> data = CLIParser.getInstance().parseAttr(result, 2);

	for (int i = 0 ; i < data.size() ; i++)
	{
		BookMarkDTO bmk = new BookMarkDTO();
		bmk.SetData(data.get(i));
		userbmklist.add(bmk);
	}
	
	List<ProfileDTO> list = ProfileDAO.getInstance().getProfileURL(s_prp);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="imagetoolbar" content="no">
<title>웹 포탈 메인</title>
<script type="text/javascript" src="script/jquery1.4.4.js"></script>
<script type="text/javascript" src="script/common.js"></script>
<script type="text/javascript">
var newwin;
/**
 * 
 */
$(document).ready(function(){
	$('#uid').bind('keydown', function(){
		var id = $('#uid').val();
		alert("아이디는 변경할수 없습니다.");
		$('#uid').val(id);
		$('#pwd_pre').focus();
	});
});

function userRename()
{
 	var uid =	$('#uid').val();
 	var pre_pwd = $('#pwd_pre').val();
 	var new_pwd = $('#pwd_new').val();
 	var new_pwd_a = $('#pwd_new_a').val();
 	
 	if (new_pwd == new_pwd_a && pre_pwd != "")
	{
		var ff = document.passform;
		
		formclear_pwd();
		
		ff.uid.value 	  = uid;
		ff.pwd_pre.value  = pre_pwd;
		ff.pwd_new.value  = new_pwd;
		
		ff.method = 'post';
		ff.target = 'ifrm';
		ff.onsubmit = function(){
			$('#ifrm').attr("src" , "process/userprc.jsp");
		};
		ff.action = 'process/userprc.jsp';
		
		ff.submit();
		
	}else{
		alert("비밀번호를 확인해주세요.");
	}
}

function addBmk()
{
	newwin = window.open("popup/addbmk.jsp", "addwin");
}

function formclear()
{
	var form = document.hiddenform;
	form.url.value  = '';
	form.name.value = '';
	form.desc.value = '';
	
	form.method = '';
	form.target = '';
	form.action = '';
}

function formclear_pwd()
{
	var form = document.passform;
	form.uid.value  = '';
	form.pwd_pre.value = '';
	form.pwd_new.value = '';

	form.method = '';
	form.target = '';
	form.action = '';
}


function modifyBtn(seq)
{
	var name = $('.bmk_row_' + seq + ' td:nth-child(1)' ).text();
	var url  = $('.bmk_row_' + seq + ' td:nth-child(2)' ).text();
	var desc = $('.bmk_row_' + seq + ' td:nth-child(3)' ).text();
	
	alert ( name + ":" + url + ":" + desc );
	
	newwin = window.open('', 'modiwin', '');
	
	formclear();
	
	var form = document.hiddenform;
	
	form.url.value = url;
	form.name.value = name;
	form.desc.value = desc;
	
	form.method = 'post';
	form.target = 'modiwin';
	form.action = 'popup/modbmk.jsp';
	
	if (newwin == null) alert ('차단된 팝업창을 허용해주세요.');
	
	form.submit();
	
	newwin.focus();
}
function deleteBtn(seq)
{
	var name = $('.bmk_row_' + seq + ' td:nth-child(1)' ).text();
	
	if ( confirm('해당 북마크를 삭제하시겠습니까?') )
	{
		var params = { mode : "remove" ,bookmark : name };
		var result = callCmd('process/bookmarkprc.jsp' ,params);
		window.location.reload();		
	}
}
function hrefprx()
{
	var select = document.getElementById("purl");
	for ( var i = 0 ; i < select.length ; i++ )
	{
	  if ( select.options[i].selected )
	  {
		 location.href = "https://<%=Property.getProperty("prxserver")%>/" + select.options[i].value;
	  }
	}	
}

function hrefprx_bmk(str)
{
	location.href = "https://<%=Property.getProperty("prxserver")%>/" + str;
}
</script>
<style type="text/css">
<!--
@import url(css/common.css);
@import url(css/style.css); -->

 /* 익스플로러 6.0 png*/	
.png24 { tmp:expression(setPng24(this));}

body,td,th {
	font-family: Arial, Helvetica, sans-serif,"돋움", Dotum;
}

a{
	cursor: pointer;
}

#pagebox {
	position:absolute;
	left:290px;
	top:232px;
	width:723px;
	height:122px;
	z-index:1;
}
#apDiv1 {
	position:absolute;
	left:1100px;
	top:232px;
	width:185px;
	height:120px;
	z-index:2;
}
</style>
</head>
<body>
<!-- 디자인 -->

<div id="pagebox">
  <table border="0" cellspacing="7" cellpadding="0" style="width:780px; margin: 0 auto; margin-left: -136px;">
    <tr>
      <td width="22%" height="51"><table width="150" border="0" cellpadding="0" cellspacing="0" class="btn">
        <tr>
          <td style="PADDING-LEFT: 65px"><img src="images/sub_27.gif"/></td>
        </tr>
      </table></td>
      <td width="67%" align="center" valign="middle">
      <table width="472" height="100" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td>
            <label>
              <select name="purl" id="purl">
              	<%
				for ( ProfileDTO prof : list) {
				%>
					<option value="<%=prof.getAlias() %>"><%=prof.getAlias() %></option>
				<%  } %>
              </select>
              </label>
          </td>
        </tr>
      </table></td>
      <td width="11%" align="center" valign="middle"><a onclick="hrefprx()"><img src="images/sub_24.gif" width="56" height="22" alt="연결"/></a></td>
    </tr>
    <tr>
      <td height="51"><table width="150" border="0" cellpadding="0" cellspacing="0" class="btn">
        <tr>
          <td style="PADDING-LEFT: 65px"><img src="images/sub_36.gif" /></td>
        </tr>
      </table></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td style="PADDING-LEFT: 53px" colspan="2">
      <DIV style="width: 626px; height: 100px; overflow-y: auto; overflow-x : hidden; padding: 15px;">
      <table width="626" height="60" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr style="padding: 12px;">
          <td>
             <table>
             	<%
				for ( BookMarkDTO sysbmk : sysbmklist)
				{
					%>
					<tr>
						<td width="126"><%=sysbmk.getName()%></td>
						<td width="190"><%=sysbmk.getAlias() %></td>
						<td width="190"><%=sysbmk.getDesc()%></td>
						<td width="120"><a onclick="hrefprx_bmk('<%=sysbmk.getAlias()%>')">
						<img src="images/sub_24.gif" width="56" height="22" alt="연결" style="cursor:pointer;"/></a></td>
					</tr>
					<%
				}
				%>
             </table>
          </td>
        </tr>
      </table>
      </DIV>
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><table width="150" border="0" cellpadding="0" cellspacing="0" class="btn">
        <tr>
          <td style="PADDING-LEFT: 65px"><img src="images/sub_42.gif" /></td>
        </tr>
      </table></td>
      <td>&nbsp;</td>
      <td align="center" valign="middle"><a onclick="addBmk()"><img src="images/sub_41.gif" width="56" height="22" alt="추가"/></a></td>
    </tr>
    <tr>
      <td style="PADDING-LEFT: 53px" colspan="2">
      <table width="626" height="60" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td>
          <DIV style="width: 626px; height: 100px; overflow-y: auto; overflow-x : hidden; padding: 15px;">
          <table class="bmkTable">
          	<tbody>
            <%
			for (int k = 0 ; k < userbmklist.size() ; k++)
			{
				BookMarkDTO userbmk = userbmklist.get(k); 
			%>
				<tr class="bmk_row_<%=k+1 %>">
					<td width="86"><%=URLDecoder.decode(userbmk.getName() , "utf8") %></td>
					<td width="180"><%=userbmk.getUrl() %></td> 
					<td width="180"><%=URLDecoder.decode(userbmk.getDesc() , "utf8") %></td>
					<td width="60"><a onclick="modifyBtn(<%=k+1%>)"><img src="images/change.gif"></a></td>
					<td width="60"><a onclick="deleteBtn(<%=k+1%>)"><img src="images/s_delete.gif" width="56" height="22"></a></td>
					<td width="60">
						<a onclick="hrefprx_bmk('<%=userbmk.getUrl()%>')"><img src="images/sub_24.gif" width="56" height="22" alt="연결" style="cursor:pointer;"/></a>
					</td>
				</tr>
				<%  
				}
			%> 
			</tbody>
				</table>
		      </DIV>
			</td>
        </tr>
      </table></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><table width="150" border="0" cellpadding="0" cellspacing="0" class="btn">
        <tr>
          <td style="PADDING-LEFT: 65px"><img src="images/sub_45.gif" /></td>
        </tr>
      </table></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td style="PADDING-LEFT: 55px" colspan="2"><table width="91%" border="0" cellpadding="0" cellspacing="4" class="lockinput">
        <tr>
          <td width="97">사용자아이디</td>
          <td width="208">
            <label>
              <input type="text" name="uid" id="uid" value="<%=s_user %>"/>
              </label>
          </td>
          <td width="113">새비밀번호</td>
          <td width="208">
            <label>
              <input type="password" name="pwd_pre" id="pwd_pre" />
              </label>
          </td>
        </tr>
        <tr>
          <td>현재비밀번호</td>
          <td>
            <label>
              <input type="password" name="pwd_new" id="pwd_new" />
              </label>
          </td>
          <td>새비밀번호확인</td>
          <td>
            <label>
              <input type="password" name="pwd_new_a" id="pwd_new_a" />
              </label>
          </td>
        </tr>
      </table></td>
      <td><a onclick="userRename()"><img src="images/change.gif" /></a></td>
    </tr>
  </table>
</div>
<div id="apDiv1">
 <!-- 클라이언트 다운로드 부분 -->
  <table width="185" border="0" cellspacing="3" cellpadding="0">
    <tr>
      <td><a href="#none"><img src="images/sub_21.gif" /></a></td>
    </tr>
    <tr>
      <td><a href="#none"><img src="images/sub_33.gif"  /></a></td>
    </tr>
    <tr>
      <td><a href="#none"><img src="images/sub_38.gif"  /></a></td>
    </tr>
  </table>
  <!--  -->
</div>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" 
style="position: absolute; z-index: 0;">
  <tr>
    <td valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/sub_04.gif">
        <tr>
          <td align="center"><table width="1024" height="56" border="0" align="center" cellpadding="0" cellspacing="0" >
            <tr>
              <td width="299" align="left"><table width="86" border="0" cellpadding="0" cellspacing="0" id="subLogo">
                <tr>
                  <td><a href="#none"><img src="images/sub_06.gif" width="86" height="35" /></a></td>
                </tr>
              </table></td>
              <td width="725" align="right"><table width="79" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td></td>
                </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
  	<!-- top 부분 -->
    <td valign="top" align="center">
    <table width="1024" border="0" align="center" cellpadding="0" cellspacing="0" >
      <tr>
        <td valign="top" ><img src="images/sub_13.gif" width="1024" height="129"/></td>
      </tr>
    </table>
    </td>
    <!--  -->
  </tr>
  <tr>
    <td height="119"></td>
  </tr>
  <tr>
    <td height="600">&nbsp;</td>
  </tr>
  <tr>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="aBtn" style="">
    <tr>
      <td><table width="1024" border="0" align="center" cellpadding="0" cellspacing="0" class="okBtn">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
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
    </td>
  </tr>
</table>

<!-- 디자인 끝 -->
<div id="ifrmArea" >
	<iframe id="ifrm" src="" frameborder="0" style="z-index:99 ;width: 0px; height: 0px; position: absolute;"></iframe>
</div>
<form name="hiddenform">
	<input type="hidden" name="url">
	<input type="hidden" name="name">
	<input type="hidden" name="desc">
</form>
<form name="passform">
	<input type="hidden" name="mode" value="modify">
	<input type="hidden" name="uid">
	<input type="hidden" name="pwd_pre">
	<input type="hidden" name="pwd_new">
</form>
</body>
</html>