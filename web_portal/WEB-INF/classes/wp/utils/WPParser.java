package wp.utils;

public class WPParser {
	
	/**
	 * JSP 의 Servlet클래스 명으로 페이지 이름을 반환
	 * @param classname				Servlet 클래스명
	 * @return						JSP 페이지명
	 */
	public static String getJSPName(String classname)
	{
		String delimeter = "org.apache.jsp.";
		
		return classname.replaceAll(delimeter, "").replaceAll("_", ".");
	}
	
	/**
	 * 
	 * @param i
	 * @return
	 */
	public static String intToIp(int i) {
        return ((i >> 24 ) & 0xFF) + "." +
               ((i >> 16 ) & 0xFF) + "." +
               ((i >>  8 ) & 0xFF) + "." +
               ( i        & 0xFF);
    }
}
