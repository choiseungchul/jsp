package wp.ha;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

public class UpdateManager {
	
	private static UpdateManager _ins = null;
	
	public static UpdateManager getInstance()
	{
		if (_ins == null) return new UpdateManager();
		else return _ins;
	}
	
	public String getUpdateTime(String sid)
	{
		String req = "http://5555/req/" + sid;
		
		URL url = null;
		URLConnection con = null;
		
		StringBuilder value = new StringBuilder();
		
		try {
			url = new URL(req);
		
			if (url != null)
				
			con = url.openConnection();
			
			con.setReadTimeout(20000);
			
			con.connect();
			
			InputStream is = con.getInputStream();
			
			int inch = 0;
			
			while (true)
			{
				if ( ( inch = is.read() ) != -1 )
				{
					value.append((char)inch);
				}
				else break;
			}
			
			is.close();
			
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		
		return value.toString();
	}
	
	public void sendUpdateTime(int time)
	{
		String req = "http://5555/update/" + time;
		
		URL url = null;
		URLConnection con = null;
		
		try {
			url = new URL(req);
		
			if (url != null)
				
			con = url.openConnection();
			
			con.setReadTimeout(20000);
			
			con.connect();
			
			StringBuilder value = new StringBuilder();
			
			InputStream is = con.getInputStream();
			
			int inch = 0;
			
			while (true)
			{
				if ( ( inch = is.read() ) != -1 )
				{
					value.append((char)inch);
				}
				else break;
			}
			
			is.close();
			
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		
	}
}
