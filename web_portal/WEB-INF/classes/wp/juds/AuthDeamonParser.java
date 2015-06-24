package wp.juds;

import java.util.HashMap;

public class AuthDeamonParser {
	
	private static AuthDeamonParser _ins = null;
	private boolean traceOn = true;
	private String delimeter = "::";
	
	public static AuthDeamonParser getInstance()
	{
		if (_ins == null) return new AuthDeamonParser();
		else return _ins;
	}
	
	/**
	 * 인증데몬 출력 결과물 파싱
	 * @param result			인증데몬에서 받아온 결과 String 값
	 * 							
	 * @return					인증결과값이 들어있는 HashMap 객체 <br>
	 * 							* 로그인 인증시 데이터의 키값 <br>
	 * 							인증결과    : authcode <br>
	 * 							프로파일명 : secui_profile <br>
	 * 							메세지       : msg <br>
	 * 							* 로그아웃시 데이터의 키값 <br>
	 * 							결과 		 : result <br>
	 * 							메세지 	 : msg <br>
	 */
	public HashMap<String, String> getLoginAuth(String result ,int flag)
	{
		HashMap<String, String> data = new HashMap<String, String>();
		
		String[] rs = result.split(delimeter);
		
		if (flag == 1)
		{
			if (rs.length == 3)
			{
				data.put("authcode", rs[0] );
				data.put("secui_profile", rs[1]);
				data.put("msg" , rs[2]);
			}else{
				System.out.println("로그인인증 데이터가 모두 넘어오지 않음" + rs.length + "개 넘어옴");
			}
		}else if (flag == 0)
		{
			if (rs.length == 2)
			{
				data.put("result", rs[0] );
				data.put("msg", rs[1]);
			}else{
				System.out.println("로그아웃 결과 데이터가 모두 넘어오지 않음" + rs.length + "개 넘어옴");
			}
		}
		
		return data;
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
