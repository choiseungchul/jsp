package wp.ha;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import wp.utils.Property;

public class TestRichable {
	
	public static boolean test(String host)
	{
		boolean flag = false;
		
		if (host == null) return false;
		
		String url = host.split(":")[0];
		
		InetAddress address = null;
		try {
			address = InetAddress.getByName(url);
		} catch (UnknownHostException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			if (address != null && address.isReachable(5000))
			{
				flag = true;
				System.out.println(host + " is riched");
			}else{
				System.out.println(host + " is not riched");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return flag;
	}
	
}
