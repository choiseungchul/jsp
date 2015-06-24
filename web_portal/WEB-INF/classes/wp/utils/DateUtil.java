package wp.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	
	/**
	 * 현재 날짜를 yyyy-MM-dd HH:mm:ss 포맷 String으로 반환한다.
	 * @return
	 */
	public static String getToday()
	{
		Date today = new Date(System.currentTimeMillis());
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String date = sdf.format(today);
		
		return date;
	}
}
