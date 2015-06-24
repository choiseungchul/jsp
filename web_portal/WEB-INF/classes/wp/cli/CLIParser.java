package wp.cli;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * CLI 인터페이스 호출시 결과물 파싱 클래스
 * 인증데몬과 연동시 결과물 파싱 클래스
 * @author akrey
 * 
 */ 
public class CLIParser {
	
	private boolean traceOn = true;
	private String delimeter = "\\^";		// ^ 로 파싱
	private static CLIParser _ins = null;
	
	public static CLIParser getInstance()	
	{
		if (_ins == null) return new CLIParser();
		else return _ins;
	}
	
	/**
	 * CLI 결과값을 파싱후 HashMap객체로 데이터를 추출하여 List객체에 담는다
	 * @param text					CLI 출력 결과물
	 * @param type					1 => 시스템 북마크 조회
	 * 								2 => 사용자 북마크 조회
	 * 								3 => 프로파일 URL 조회
	 *  							4 => 사용자 조회
	 *  	
	 * @return						해당정보가 있는 List<HashMap> 객체
	 */
	public List<HashMap<String, String>> parseAttr(String text, int type)
	{
		trace( "attr : " + text);
		
		if ( text == null ) System.out.println("result is null");
		
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		
		if ( text.contains("ERROR"))
		{
			String[] error = text.replaceAll("ERROR\n", "").split("\\^");
			trace("error:" + error[0]);
			trace("msg:" + error[1]);
			
			return list;
		}
		
		// 임의로 \n 으로 파싱
		String[] liststring = text.split("\n");
		
		// 1. 시스템 북마크 조회
		if (type == 1)
		{
			for ( int i = 1 ; i < liststring.length ; i++){
				HashMap<String, String> data = new HashMap<String, String>();
				String[] parse = liststring[i].split(delimeter);
				
				if ( parse[0].equals("Y"))
				{
					data.put("domain",   parse[1]);
					data.put("protocol" ,parse[2]);
					data.put("alias", 	 parse[3]);
					data.put("name", 	 parse[4]);
					data.put("desc", 	 parse[5]);
					list.add(data);
				}
			}
		}
		
		// 2. 사용자 북마크 조회 
		if (type == 2)
		{
			for ( int i = 1 ; i < liststring.length ; i++){
				HashMap<String, String> data = new HashMap<String, String>();
				String[] parse = liststring[i].split(delimeter);
				
				data.put("name", parse[0]);
				data.put("domain",  parse[1]);
				data.put("desc", parse[2]);
				
				list.add(data);
			}
		}
		
		// 3. 프로파일 URL 조회
		if (type == 3)
		{
			for ( int i = 1 ; i < liststring.length ; i++){
				HashMap<String, String> data = new HashMap<String, String>();
				String[] parse = liststring[i].split(delimeter);
				
				if (parse[0].equals("Y"))
				{
					data.put("domain",   parse[1]);
					data.put("protocol" ,parse[2]);
					data.put("alias", 	 parse[3]);
					data.put("bookmark", parse[4]);
					data.put("desc", 	 parse[5]);
					
					list.add(data);
				}
			}
		}
		
		// 4. 사용자 정보 조회
		if (type == 4)
		{
			for ( int i = 1 ; i < liststring.length; i++ )
			{
				HashMap<String, String> data = new HashMap<String, String>();
				String[] parse = liststring[i].split(delimeter);
				
				data.put("userid", parse[0]);
				data.put("profile",parse[1]);
				data.put("desc"   ,parse[2]);
				
				list.add(data);
			}
		}
		
		// 5. 기본옵션 조회
		if (type == 5)
		{
			HashMap<String, String> data = new HashMap<String, String>();
			String[] parse = liststring[1].split(delimeter);
			
			data.put("prxserver", parse[1]);
			data.put("wp.domain", parse[2]);
			data.put("prxport" ,  parse[3]);
			data.put("wp.port" ,  parse[4]);
			
			list.add(data);
		}
		
		// 테스트용 
		if (type == 6)
		{
			for ( int i = 1 ; i < liststring.length ; i++){
				HashMap<String, String> data = new HashMap<String, String>();
				String[] parse = liststring[i].split(delimeter);
				
				data.put("domain",   parse[0]);
				data.put("protocol" ,parse[1]);
				data.put("alias", 	 parse[2]);
				data.put("bookmark", parse[3]);
				data.put("desc", 	 parse[4]);
				
				list.add(data);
			}
		}
		
		// 프로파일 리스트
		if (type == 7)
		{
			for ( int i = 1 ; i < liststring.length ; i++){
				HashMap<String, String> data = new HashMap<String, String>();
				String[] parse = liststring[i].split(delimeter);
				
				data.put("prpname",   parse[0]);
				data.put("desc" ,parse[1]);
				
				list.add(data);
			}
		}
		
		// *. 성공유무 조회
		if (type == 0)
		{
			HashMap<String , String> rs = new HashMap<String, String>();
			rs.put("result", liststring[0]);
			list.add(rs);
		}
		
		return list;
	}

	/**
	 * 콘솔창에 디버그 출력
	 * @param obj		디버그 내용
	 */
	private void trace(Object obj)
	{
		if ( this.traceOn )
			System.out.println(obj.toString());
	}
}
