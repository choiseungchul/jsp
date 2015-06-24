
package wp.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import wp.utils.Property;
/**
 * Sqlite3 JDBC 유틸리티
 * @author akrey
 *
 */
public class SQLiteConnector {
	
	private static SQLiteConnector _instance = null;
	
	public static SQLiteConnector getInstance() {
		
		if ( _instance == null )
			return new SQLiteConnector();
		else return _instance;
	}
	
	/**
	 * common.properties 파일의 설정을 불러들여
	 * DB파일을 로드 하여 SQLite3 Connection 객체 리턴
	 * @return Connection
	 */
	public Connection getConnection(){
		
		Connection conn = null;
		
//		System.out.println("==== DB 파일 경로 ==== ");
//		System.out.println(Property.getProperty("sqlitedb"));
//		System.out.println("====================");
		
		try {
			Class.forName("org.sqlite.JDBC");
			conn = DriverManager.getConnection("jdbc:sqlite:/" + Property.getProperty("sqlitedb"));
			//conn = DriverManager.getConnection("jdbc:sqlite:/" + "E:/project/SSLVPN/trunk/ssl_vpn_v1.0/WebContent/dbfile/sslvpn_db.db");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return conn;
	}
	
//	public static void main(String args[])
//	{
//		Property.init("E:/project/SSLVPN/trunk/ssl_vpn_v1.0/WebContent/");
//		Connection con = SQLiteConnector.getInstance().getConnection();
//	
//		try {
//			Statement stmt = con.createStatement();
//			
//			ResultSet rs = null;
//			
//			rs = stmt.executeQuery("select * from sessioninfo");
//			
//			while (rs.next())
//			{
//				System.out.println(rs.getInt(1));
//			}
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			System.out.println( e.getMessage() ); 
//			
//			if (e.getMessage().equals("database disk image is malformed"))
//			{
//				//System.out.println("=== DB 파일이 깨짐 ===");
//				
//			}
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
// 		
//	}

}
