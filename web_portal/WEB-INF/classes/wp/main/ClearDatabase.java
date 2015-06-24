package wp.main;

import java.util.HashMap;
import java.util.List;
import java.util.TimerTask;

import wp.db.proc.Executor;
import wp.manager.SessionStorage;

public class ClearDatabase extends TimerTask{

	@Override
	public void run() {
		
		// 남아있어야할 세션 정보를 조회한다.
		String selectQ = "select s_idx from sessioninfo group by s_sid order by s_cdate desc";
		
		List<HashMap<String, Object>> map = Executor.getInstance().select(selectQ);
		
		int[] elements = new int[map.size()];
		
		for ( int i = 0 ; i < elements.length ; i++)
		{
			elements[i] = (Integer) (map.get(i).get("s_idx"));
		}
		
		System.out.println(elements.length + "개의 세션으로 정리합니다.");
		
		// 쓰레기 세션 데이터를 정리한다.
		String sql = "delete from sessioninfo where s_idx NOT IN( select s_idx from sessioninfo group by s_sid order by s_cdate desc )";

		Executor.getInstance().proc(sql);
		
		System.out.println("DB 세션정보가 최적화되었습니다.");
		
		//메모리의 세션값도 정리한다.
		SessionStorage.clearElement(elements);
		System.out.println("메모리 세션정보가 최적화 되었습니다.");
	}

}
