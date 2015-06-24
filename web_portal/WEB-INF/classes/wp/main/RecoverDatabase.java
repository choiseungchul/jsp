package wp.main;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import wp.ha.WPInitialize;
import wp.utils.Property;

public class RecoverDatabase {
	
	private static RecoverDatabase _ins = null;
	
	public static RecoverDatabase getInstance()
	{
		if (_ins == null) return new RecoverDatabase();
		else return _ins;
	}
	
	public void recover()
	{
		String backupdb = Property.getProperty("dbback");
		String breakdb  = Property.getProperty("sqlitedb");
		
		File db = new File(breakdb);
		
		if (db.exists())
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			boolean deflag = db.renameTo(new File(breakdb + "_" + sdf.format(new Date(System.currentTimeMillis()))));
						
			if (deflag)
			{
				System.out.println("db file rename");
				File bkdb = new File(backupdb);
				File newdb = new File(breakdb);
				
				try {
					int read = 0;
					
					FileInputStream fi  = new FileInputStream(bkdb);
					FileOutputStream fo = new FileOutputStream(newdb);
					
					while ((read = fi.read()) != -1 )
					{
						fo.write(read);
					}
					
					fi.close();
					
					fo.close();
					
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					
				}
				
			}else{
				System.out.println("파일이 삭제되지 않음");
			}
			// 웹포탈 초기화작업 다시시작
			WPInitialize.init();
	
		}else{
			
			// 파일이 없는 상태이므로 바로 복사
			System.out.println("db file rename");
			File bkdb = new File(backupdb);
			File newdb = new File(breakdb);
			
			try {
				int read = 0;
				
				FileInputStream fi  = new FileInputStream(bkdb);
				FileOutputStream fo = new FileOutputStream(newdb);
				
				while ((read = fi.read()) != -1 )
				{
					fo.write(read);
				}
				
				fi.close();
				
				fo.close();
				
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				
			}
		}
	}
	
}
