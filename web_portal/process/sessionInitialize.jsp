<%@page language="java" contentType="text/xml; charset=UTF-8"%><%
	
//  이 페이지는 현재 웹포탈의 세션정보를 xml로 출력해준다.
//  다른장비에서 MF2Tomcat 서버가 올라갈때 현재 페이지가 요청된다. 

	response.setHeader("Pragma", "no-cache" );
	response.setHeader("cache-control", "no-store");
	response.setHeader("Content-type", "text/xml");
	 
	XMLManager xmlman = new XMLManager();
	Document doc = xmlman.getSessionDoc();
	
	XMLOutputter outp = new XMLOutputter();
	 	
	outp.output(doc, out);

%><%@page import="org.jdom.Document"%>
<%@page import="org.jdom.output.XMLOutputter"%>
<%@page import="wp.ha.XMLManager"%>