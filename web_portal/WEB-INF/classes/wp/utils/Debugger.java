package wp.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class Debugger {
	
	private long start = 0L;
	private long end = 0L;
	private String processName = null;
	
	public void setStartTime(String processName)
	{
		this.processName = processName;
		this.start = System.currentTimeMillis();
	}
	
	public void setEndTime()
	{
		this.end = System.currentTimeMillis();
	}
	
	public void traceTime()
	{
		System.out.println(this.processName + " 소요시간 : " + ( this.end - this.start ) + "milliseconds" );
	}
	
	/**
	 * 
	 * HashMap 객체 리스트가 들어있는 목록을 콘솔창에 조회한다
	 * @param list		List<HashMap> 객체
	 */
	public static void traceValue(List<HashMap<String, String>> list)
	{
		if (list == null) return;
		
		if ( list.size() > 0)
		{
			for (HashMap<String, String> map : list)
			{
				for (Map.Entry<String, String> data : map.entrySet())
				{
					System.out.print("key:" + data.getKey());
					System.out.println("");
					System.out.print("value:" + data.getValue());
					System.out.println("");
				}
			}
		}
	}
	
	public static void traceValue2(List<HashMap<String, Object>> list)
	{
		if (list == null) return;
		
		if ( list.size() > 0) 
		{
			for (HashMap<String, Object> map : list)
			{
				for (Map.Entry<String, Object> data : map.entrySet())
				{
					System.out.print("key:" + data.getKey());
					System.out.println("");
					System.out.print("value:" + data.getValue());
					System.out.println("");
				}
			}
		}
	}
}
