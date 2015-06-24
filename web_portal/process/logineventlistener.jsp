<%@page import="wp.juds.ReqDeamon"%>
<%@page import="wp.databean.SessionDTO"%>
<%@page import="wp.manager.SessionDAO"%>
<%@page import="wp.manager.SessionStorage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String uid  = request.getParameter("uid");
	String sid  = request.getParameter("sid");
	String prp  = request.getParameter("prp");
	String sidx = request.getParameter("sidx");
	String cdate = request.getParameter("cdate");
	
	System.out.println("login request to : " + request.getServerPort());
	System.out.println("uid : " + uid);
	System.out.println("sid : " + sid);
	System.out.println("sidx : " + sidx);
	
	// 메모리할당
	SessionStorage.add(sid, uid, Integer.parseInt(sidx), prp);
	
	SessionDTO sdata = new SessionDTO();
	sdata.setSid(sid);
	sdata.setUid(uid);
	sdata.setPurl(prp);
	sdata.setIdx(Integer.parseInt(sidx));
	sdata.setCdate(Long.parseLong(cdate));
	
	// DB할당
	SessionDAO.getInstance().addSession(sdata);
	
%>