package wp.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import wp.db.proc.Executor;

public class SessionStorage {
	
	// 세션정보를 담을 객체
	public static List<HashMap<String, Object>> map = new ArrayList<HashMap<String, Object>>();
	
	public static void removeAll()
	{
		map = new ArrayList<HashMap<String,Object>>();
	}
	
	/**
	 * 메모리에 해당 세션 정보가 있는지 없는지 판단후 로그인 여부를 알아낸다
	 * @param sessionid					세션 아이디
	 * @return							로그인 여부
	 */
	public static boolean loginCheck(String sessionid)
	{
		if (sessionid == null) return false;
		
		boolean flag = false;
		
		if ( map.size() > 0 )
		{
			for (HashMap<String, Object> data : map)
			{
				for (Map.Entry<String, Object> entryset : data.entrySet())
				{
					if ( entryset.getKey().equals("secui_session") )
					{
						if ( entryset.getValue().equals((String)sessionid) )
						{
							flag = true;
							break;
						}
					}
				}
			}
		}
		
		return flag;
	}
	
	/**
	 * 해당 세션아이디를 메모리에서 삭제한다.
	 * @param sessionid				세션 인덱스번호
	 */
	public static String removeByIndex(int sidx)
	{
		if (sidx == 0) return "";

		String sessionid = null;
		
		String sql = "SELECT s_sid FROM sessioninfo WHERE s_idx = " + sidx;
		List<HashMap<String, Object>> list = Executor.getInstance().select(sql);
		
		if ( list.size() > 0 )
		{
			sessionid = (String)list.get(0).get("s_sid");
			String removesql = "DELETE FROM sessioninfo WHERE s_idx = " + sidx;
			Executor.getInstance().proc(removesql);
		}
		
		if ( map.size() > 0 )
		{
			for ( int index = 0 ; index < map.size() ; index++ )
			{
				for (Map.Entry<String, Object> entryset : map.get(index).entrySet())
				{
					if ( entryset.getKey().equals("secui_session") )
					{
						if ( entryset.getValue().equals((String)sessionid) )
						{
							map.remove(index);
						}
					}
				}
			}
		}
		return sessionid;
	}
	
	/**
	 * 해당 세션아이디를 메모리에서 삭제한다.
	 * @param user 					사용자 아이디
	 */
	public static void removeByUser(String user)
	{
		if (user == null) return;

		if ( map.size() > 0 )
		{
			for ( int index = 0 ; index < map.size() ; index++ )
			{
				for (Map.Entry<String, Object> entryset : map.get(index).entrySet())
				{
					if ( entryset.getKey().equals("secui_user") )
					{
						if ( entryset.getValue().equals((String)user) )
						{
							map.remove(index);
							break;
						}
					}
				}
			}
		}
	}
	
	public static String removeBySessionId(String sessionid)
	{
		if (sessionid == null) return null;
		
		String rminfo = null;
		
		if ( map.size() > 0 )
		{
			for ( int index = 0 ; index < map.size() ; index++ )
			{
				for (Map.Entry<String, Object> entryset : map.get(index).entrySet())
				{
					if ( entryset.getKey().equals("secui_session") )
					{
						if ( entryset.getValue().equals((String)sessionid) )
						{
							String uid = (String)map.get(index).get("secui_user");
							int sidx = (Integer)map.get(index).get("sidx");
							rminfo = uid + ":" + sidx;
							map.remove(index);
						}
					}
				}
			}
		}
		
		return rminfo;
	}
	
	/**
	 * 생성 된 세션 아이디를 메모리에 할당
	 * @param sessionid					세션아이디
	 * @param userid					사용자아이디
	 * @param sidx						세션DB의 인덱스번호
	 * @param profilename				사용자 프로파일명
	 */
	public static void add(String sessionid ,String userid ,int sidx , String profilename)
	{
		if (sessionid == null || userid == null || sidx == 0 ) return;
		
		HashMap<String , Object> newsession = new HashMap<String, Object>();
		
		newsession.put("secui_session",  sessionid);
		newsession.put("secui_user", 	 userid);
		newsession.put("secui_profile",  profilename );
		newsession.put("sidx"     ,      sidx);
		
		map.add(newsession);
	}
	
	public static HashMap<String, Object> get(int sidx) 
	{
		if ( sidx == -1 ) return null;
		
		HashMap<String, Object> session = new HashMap<String, Object>();
		 
		if ( map.size() > 0 )
		{
			for ( int index = 0 ; index < map.size() ; index++ )
			{
				for (Map.Entry<String, Object> entryset : map.get(index).entrySet())
				{
					if ( entryset.getKey().equals("sidx") )
					{
						if ( (Integer)entryset.getValue() ==  sidx )
						{
							session = map.get(index);
							break;
						}
					}
				}
			}
		}
		
		return session;
	}
	
	public static HashMap<String, Object> get(String sid) 
	{
		if ( sid == null ) return null;
		
		HashMap<String, Object> session = new HashMap<String, Object>();
		
		if ( map.size() > 0 )
		{
			for ( int index = 0 ; index < map.size() ; index++ )
			{
				for (Map.Entry<String, Object> entryset : map.get(index).entrySet())
				{
					if ( entryset.getKey().equals("secui_session") )
					{
						if ( entryset.getValue().equals(sid) )
						{
							session = map.get(index);
							break;
						}
					}
				}
			}
		}
		
		return session;
	}
	
	public static void clearElement(int[] sidx)
	{
		if (sidx.length == 0) return;
		
		if ( map.size() > 0 )
		{
			for ( int index = 0 ; index < map.size() ; index++ )
			{
				for (Map.Entry<String, Object> entryset : map.get(index).entrySet())
				{
					if ( entryset.getKey().equals("sidx") )
					{
						boolean flag = true;
						
						for ( int i : sidx )
						{
							if ( i == (Integer)entryset.getValue())
							{
								flag = false;
								break;
							}
						}
						if (flag) map.remove(index);
					}
				}
			}
			
		}
	}
}
