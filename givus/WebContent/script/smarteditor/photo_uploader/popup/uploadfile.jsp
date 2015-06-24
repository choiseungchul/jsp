<%@page import="java.util.Map"%>
<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String imgName = "";
DiskFileItemFactory factory = new DiskFileItemFactory();
factory.setSizeThreshold(1024*1024*10); 
//factory.setRepository(new File("c:/upload/"));
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setSizeMax(1024*1024*100);
upload.setHeaderEncoding("UTF-8");
System.out.println(upload.getHeaderEncoding());
List<FileItem> items = upload.parseRequest(request);
Iterator<FileItem> iter = items.iterator();
String callback_func = "";
String realname = "";
while(iter.hasNext()){
    FileItem item = (FileItem) iter.next();
    if(item.isFormField()){
    	if(item.getFieldName().equals("callback_func")){
    		callback_func = item.getString();
    	}
    	System.out.println(item.getFieldName());
    	System.out.println(item.getString());
    }else{
	if(item.getName()!=null && !item.getName().equals("")){
		String ranName = UUID.randomUUID().toString();
		realname = item.getName();
		System.out.println(item.getName());
		imgName = ranName+"."+item.getName().split("\\.")[1];
	    //File file = new File(CommonUtil.IMAGES_UPLOAD+imgName); 실제파일 올라갈 경로
	    //item.write(file); 실제파일 생성
	}
    }
}
realname="sample.png";
imgName="sample.png";
%>
<script>
document.location="callback.html?sFileName=<%=realname%>&callback_func=<%=callback_func%>&bNewLine=true&sFileURL=../img/<%=imgName%>";
</script>
</body>
</html>