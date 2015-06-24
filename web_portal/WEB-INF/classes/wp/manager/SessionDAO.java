package wp.manager;

import java.util.HashMap;
import java.util.List;

import wp.databean.SessionDTO;
import wp.db.proc.Executor;

public class SessionDAO {
	
	private static SessionDAO _ins = null;
	
	public static SessionDAO getInstance()
	{
		if (_ins == null) return new SessionDAO();
		else return _ins;
	}
	
	/**
	 *  웹 포탈이 서로 DB 세션을 공유하기위한 조회
	 * @return				
	 */
	public List<HashMap<String, Object>> getAll()
	{
		String sql = "SELECT * FROM sessioninfo";
		List<HashMap<String, Object>> sesslist = Executor.getInstance().select(sql);
		
		return sesslist;
	}
	
	public void removeAll()
	{
		String sql = "DELETE FROM sessioninfo";
		Executor.getInstance().proc(sql);
	}
	
	/**
	 * 세션 테이블에 세션 저장
	 * @param sessinfo 		세션 데이터 객체
	 * @return				성공 유무 1 => 성공 : 0 => 실패
	 */
	public int addSession (SessionDTO sessinfo)
	{
		int idx = -1;
		
		StringBuilder insertQ = new StringBuilder();
		
		insertQ.append("INSERT INTO sessioninfo (");
		insertQ.append("s_sid, s_uid , s_profile,  s_cdate");
		insertQ.append(") values (");
		
		insertQ.append("'" + sessinfo.getSid() + "',");
		insertQ.append("'" + sessinfo.getUid() + "',");
		insertQ.append("'" + sessinfo.getPurl() + "',");
		insertQ.append(sessinfo.getCdate());
		
		insertQ.append(")");
		
		idx = Executor.getInstance().proc(insertQ.toString());
		
		if ( idx == 1 )
		{
			List<HashMap<String,Object>> list = Executor.getInstance().
			select("SELECT s_idx FROM sessioninfo WHERE s_sid = '" + sessinfo.getSid() + 
					"' order by s_idx desc limit 0,1");
			if (list.size() > 0 )
			{
				idx = (Integer)list.get(0).get("s_idx");
			}
		}
		
		return idx;
	}
	
	/**
	 * 세션 아이디 값으로 DB의 세션정보를 불러온다
	 * @param sessionid		세션아이디
	 * @return				세션정보가 담긴 SessionDTO 객체
	 */
	public SessionDTO get(String sessionid)
	{
		if ( sessionid == null ) return null;
		
		String sql = "SELECT * FROM sessioninfo WHERE s_sid = '" + sessionid + "'";
		List<HashMap<String, Object>> list = Executor.getInstance().select(sql);
		
		SessionDTO sess = null;
		
		if ( list.size() > 0 )
		{
			sess = new SessionDTO();		
			
			sess.setSid( (list.get(0).get("s_sid")).toString() );
			sess.setUid( (list.get(0).get("s_uid")).toString() );
			sess.setPurl( (list.get(0).get("s_profile")).toString() );
			sess.setCdate( (Integer)(list.get(0).get("s_cdate")) );
			sess.setIdx( (Integer)(list.get(0).get("s_idx")) );
		}
		
		return sess;
	}
	
	/**
	 * DB의 해당 세션 정보를 지움
	 * @param sessionid 		세션 아이디
	 * @return 					성공 유무 1 => 성공 : 0 => 실패
	 */
	public int deleteSession (String sessionid)
	{
		int flag = -1;
		
		String deleteQ = "delete from sessioninfo where s_sid = '" + sessionid + "'";
		
		flag = Executor.getInstance().proc(deleteQ);
		
		return flag;
	}
}
