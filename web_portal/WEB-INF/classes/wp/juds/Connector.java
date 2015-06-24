package wp.juds;

import wp.utils.Property;


/**
 * Unix Domain Socket 과  Java 연동 클래스 
 * @author akrey
 *
 */
public class Connector {
	
	static {
		
		try {
			String property = Property.getProperty("udslibpath");
			
			Runtime.getRuntime().load(property);
			
		}catch (NullPointerException e) {
			
			Runtime.getRuntime().load("/secui/gui/MF2Tomcat/sslvpn/ROOT/WEB-INF/lib/libconnector.so");
			// TODO: handle exception
		}
		
	}
	// Native 함수 로드
	protected native static int createSocket(String scfile);
	protected native static int connectSocket(int sockfd , String scfile);
	protected native static int write(int sockfd, String buf ,int len);
	protected native static String readData(int sockfd, int len);
	protected native static int dclose(int sockfd);
	
	public static void main( String[] args )
	{
		int sockfd = createSocket("/tmp/sslvpn/comm_auth_sock");
		connectSocket(sockfd , "/tmp/sslvpn/comm_auth_sock" );
		 
		String sendstr = "";
		
		if (args[0].equals("2"))
			sendstr = "2::test01::idididiididididi::39213910321";
		else if (args[0].equals("1"))
			sendstr = "1::test01::test02::032930910319301::111.111.111.111";
		
		write(sockfd , sendstr , 1024);

		String data = readData(sockfd ,1024);
		
		System.out.println(data);

		//System.out.println(dclose(sockfd));

		//System.out.println(data);
	}
}
