package kr.co.zadusoft.contents.util;

public class StringUtil {

	// 해당 문자의 갯수를 구한다.
	public static int countOccurrences(String haystack, char needle)
	{
	    int count = 0;
	    for (int i=0; i < haystack.length(); i++)
	    {
	        if (haystack.charAt(i) == needle)
	        {
	             count++;
	        }
	    }
	    return count;
	}
	
}
