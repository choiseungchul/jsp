<%@page import="wp.cli.CmdString"%>
<%@page import="wp.utils.ShowMsg"%>
<%@page import="wp.manager.BookMarkDAO"%>
<%@page import="wp.utils.WPParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/loginchk.jsp"%>
 
<% 


	request.setCharacterEncoding("UTF-8");
	
	String classname = this.getClass().getName();
	classname = WPParser.getJSPName(classname);
	System.out.println(classname + " page requested");
	
	String mode = request.getParameter("mode");
	
	if ( mode.equals("add") ) 	
	{
		String url  = request.getParameter("url");
		String name = request.getParameter("name"); 
		String desc = request.getParameter("desc");
		
		out.println(url + ":" + name + ":" + desc);
		
		int code = BookMarkDAO.getInstance().add(s_user, name, url, desc);
		
		out.println(ShowMsg.showAlert(name + "/" + desc + ":" + code ));
		out.println("<script>opener.location.reload();window.close();</script>");
		
	
	}else if ( mode.equals("remove") )
	{
		String name = request.getParameter("bookmark");
		
		int code = BookMarkDAO.getInstance().delete(s_user, name);
		
		//out.println(mode + "/" + name);
		
		//out.println(code);

	}else if ( mode.equals("modify") )
	{
		String url = request.getParameter("url");
		String prename = request.getParameter("prename");
		String name = request.getParameter("name");
		String desc = request.getParameter("desc");
		
		int code = BookMarkDAO.getInstance().modify(s_user, prename, name, url, desc);
		
		out.println("<script>opener.location.reload();window.close();</script>");
		
		//out.println(mode + "/" + prename + ":" + name + ":" + desc);
		
		//out.println(code); s
	}
%>

