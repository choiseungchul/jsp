package wp.ha;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.LinkedList;

import wp.utils.Property;


public class MemberSynchronization {
	
	private static MemberSynchronization _ins = null;
	
	public static MemberSynchronization getInstance()
	{
		if ( _ins == null ) return new MemberSynchronization();
		else return _ins;
	}
	
	public void sendLoginInfo(String params)
	{
		int otherWPcount = Integer.parseInt(Property.getProperty("wp.count"));
		
		LinkedList<String> availableHost = new LinkedList<String>();
		
		for (int i = 0 ; i < otherWPcount ; i++)
		{
			boolean richf = TestRichable.test(Property.getProperty("wp.portal" + (i + 1)));
			if (richf) {
				availableHost.add(Property.getProperty("wp.portal" + (i + 1)));
			}
		}
		
		if ( availableHost.size() == 0 ) {
			System.out.println("cannot find available host");
			return;
		}
		
		System.out.println( "wpcount=" + availableHost.size() );
		
		for ( String host : availableHost) {
			
			String	httpAddress = "http://" + host + "/process/logineventlistener.jsp";
			
			System.out.println(httpAddress);
			
			URL url = null;
			URLConnection con = null;
			
			try {
				url = new URL(httpAddress + "?" + params);
					
				con = url.openConnection();
				
				con.setReadTimeout(20000);
				
				con.connect();
				
				InputStream is = con.getInputStream();
				
				StringBuilder value = new StringBuilder();
				
				while (true)
				{
					int ch;
					if ( (ch = is.read()) != -1)
					{ 
						value.append(ch);
					}else break;
				}
				
				is.close();
				
				System.out.println(value.toString());
				
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} 
		}
	}
	
	public void sendLogoutInfo(String params)
	{
		int otherWPcount = Integer.parseInt(Property.getProperty("wp.count"));
		
		LinkedList<String> availableHost = new LinkedList<String>();
		
		for (int i = 0 ; i < otherWPcount ; i++)
		{
			boolean richf = TestRichable.test(Property.getProperty("wp.portal" + (i + 1)));
			if (richf) {
				availableHost.add(Property.getProperty("wp.portal" + (i + 1)));
			}
		}
		
		if ( availableHost.size() == 0 ) {
			System.out.println("cannot find available host");
			return;
		}
		
		for (String host : availableHost ){
			
			String	httpAddress = "http://" + host + "/process/logineventlistener.jsp";
				
			URL url = null;
			URLConnection con = null;
			
			try {
				url = new URL(httpAddress + "?" + params);
				
				con = url.openConnection();
				
				con.setReadTimeout(20000);
				
				con.connect();
				
				InputStream is = con.getInputStream();
				
				StringBuilder value = new StringBuilder();
				
				while (true)
				{
					int ch;
					if ( (ch = is.read()) != -1)
					{ 
						value.append(ch);
					}else break;
				}
				
				is.close();
				
				System.out.println(value.toString());
				
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} 
		}
	}
}
