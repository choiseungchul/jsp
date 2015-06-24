<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
//	해당 세션의 업데이트 시간 조회 또는 업데이트 시간 요청 페이지
	String mode      = request.getParameter("mode");
	
	if (mode.equals("view"))
	{
		// 파일 조회하여 response
		//ShareDAO.getInstance().getPipeFile();
		
		out.println("updatetime:127383992230");
	
	}else if (mode.equals("req"))
	{
		// 다른 웹 포탈로 호출
		int otherWPcount = Integer.parseInt(Property.getProperty("wp.count"));
		
		if (otherWPcount == 0) {
			System.out.println("요청할 장비가 없습니다.");
			
		}else if (otherWPcount > 0){
		
			String availableHost = null;
			
			for (int i = 0 ; i < otherWPcount ; i++)
			{
				boolean richf = TestRichable.test(Property.getProperty("wp.portal") + (i + 1));
				if (richf) {
					availableHost = Property.getProperty("wp.portal") + (i + 1);
					break;
				}
			}

			if (availableHost != null )
			{
				String httpAddress = "http://" + availableHost + "/process/sessionview.jsp?mode=view";
				
				try {
					
					URL url = new URL(httpAddress);
					URLConnection con = url.openConnection();
					
					con.connect();
					
					InputStreamReader isr = new InputStreamReader( con.getInputStream() , "cp949" );
					
					int inch = 0;
					
					StringBuilder value = new StringBuilder();
					
					while (true)
					{
						if ( ( inch = isr.read() )  != -1 )
						{
							value.append((char)inch);
						}
						else break;
					}
					
					isr.close();
					// response
					out.print(value.toString());
						
				} catch (IOException e) {
					out.println(e.getMessage());
				}
			}
		}
	}
%>
<%@page import="wp.ha.TestRichable"%>
<%@page import="wp.manager.ShareDAO"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="wp.utils.Property"%>