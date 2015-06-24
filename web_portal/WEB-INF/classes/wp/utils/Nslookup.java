package wp.utils;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 
 * @author akrey
 * 도메인의 아이피 주소를 확인하기 위한 클래스
 */
public class Nslookup {
	
	/**
	 * 해당 도메인의 아이피 주소를 확인한다
	 * @param domain		도메인명
	 * @return	아이피 주소 배열을 리턴
	 */
	public static String[] getIpaddress(String domain)
	{ 
		InetAddress[] addr = null;
		
		try {
			addr = InetAddress.getAllByName(domain);
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		
		if (addr != null) {
			
			String[] ipaddress = new String[addr.length];
			for (int i = 0 ; i < addr.length ; i++) {
				ipaddress[i] = addr[i].getHostAddress();
			}
			
			return ipaddress;
		}
		
		return null;
	}
}
