package wp.db.proc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import wp.db.SQLiteConnector;

/**
 * 
 * @author akrey
 * 데이터베이스의 DML을 실행하는 클래스
 */
public class Executor {
	
	private static Executor _ins = null;
	private boolean traceOn = true;
	
	
	public static Executor getInstance()
	{
		if (_ins == null) return new Executor();
		else return _ins;
	}
	
	/**
	 * INSERT, UPDATE, DELETE 실행
	 * @param sql 		질의문
	 * @return 			성공/실패 여부 : 1 => 성공, 0 => 실패 , -1 => 오류
	 */
	public int proc(String sql)
	{
		Connection conn = null;
		Statement stmt = null;
		
		int flag = -1;
		
		String query = sqlinjection(sql);
		
		trace(query);
		
		try {
			conn = SQLiteConnector.getInstance().getConnection();
			
			stmt = conn.createStatement();
			
			flag = stmt.executeUpdate(query);
			
			conn.commit();
			
		}catch (SQLException e) {
			System.out.println( e.getMessage() ); 
			
//			if (e.getMessage().equals("database disk image is malformed"))
//			{
//				RecoverDatabase.getInstance().recover();
//				System.out.println("새로운 DB파일이 생성되었습니다");
//			}
			
		}finally{
			try {
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
//				if (e.getMessage().equals("database disk image is malformed"))
//				{
//					RecoverDatabase.getInstance().recover();
//					System.out.println("새로운 DB파일이 생성되었습니다");
//				}
				e.printStackTrace();
			}
		}
		
		return flag;
	}
	
	/**
	 * SELECT 실행
	 * @param sql		질의문
	 * @return			HashMap<칼럼명, 데이터값> 객체의 List를 리턴
	 */
	public List<HashMap<String, Object>> select(String sql)
	{
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		try {
			
			String query = sqlinjection(sql);
			
			trace(query);
			
			conn = SQLiteConnector.getInstance().getConnection();
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			
			ResultSetMetaData tableInfo = rs.getMetaData();
			
			while (rs.next())
			{
				HashMap<String, Object> map = new HashMap<String, Object>();
				
				for ( int i = 1 ; i <= tableInfo.getColumnCount() ; i++ )
				{
					map.put(tableInfo.getColumnName(i), rs.getObject(i));
				}
				result.add(map);
			}
			
		} catch (SQLException e) {
//			if (e.getMessage().equals("database disk image is malformed"))
//			{
//				RecoverDatabase.getInstance().recover();
//				System.out.println("새로운 DB파일이 생성되었습니다");
//			}
			e.printStackTrace();
		} finally {
			try {
				if ( rs != null)
					rs.close();
				if ( stmt != null)
					stmt.close();
				if ( conn != null)
					conn.close();
			} catch (SQLException e) {
//				if (e.getMessage().equals("database disk image is malformed"))
//				{
//					RecoverDatabase.getInstance().recover();
//					System.out.println("새로운 DB파일이 생성되었습니다");
//				}
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	/**
	 * SQL 공격 막는 코드
	 * @param input  		SQL문
	 * @return				SQL Injection 문자열이 제거된 String
	 */
	private String sqlinjection(String input)
	{
		if(input != null && input.length() > 0){
		     input = input.replaceAll("\r\n","")
			             .replaceAll("\n","\t")
			             .replaceAll("\r","\t")  	// 리턴키를 탭으로 바꾸기
			             .replaceAll("\t\t","\t") 	//이중탭은 하나로
			             .replaceAll("\t","") 		//탭없애기
			             .replaceAll("&nbsp","") 	//HTML조작
			             .replaceAll("&gt;","}")
			             .replaceAll("&lt;","{");
		 }
		 return input;
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
	
//	public static void main (String args[])
//	{
//		String sql = "select * from sessioninfo";
//		
//		List<HashMap<String, Object>> list = Executor.getInstance().select(sql);
//		
//		
//		Debugger.traceValue2(list);
//		
//		
//	}
}
