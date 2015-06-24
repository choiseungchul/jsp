package wp.ha;

import java.util.HashMap;
import java.util.List;
import java.util.Timer;

import wp.cli.CLIParser;
import wp.cli.CmdString;
import wp.cli.Command;
import wp.manager.SessionDAO;
import wp.utils.Property;
 
/**
 * 다른 웹 포탈 서버의 세션 정보를 요청하고 
 * xml을 불러와서 세션정보를 저장한다.
 * @author akrey
 *
 */
public class WPInitialize {
	
	/**
	 * 다른 웹 포털 에서 세션 정보를 xml 로 요청한다. <br>
	 * 웹포털
	 */
	public static void init()
	{ 
		// 세션청소 주기를 10분으로 한다.
		int clear_time = 10 * 60 * 1000;
		
		// db 의 세션 을 모두 지움  
		SessionDAO.getInstance().removeAll();
		
		String pre_domain = Property.getProperty("wp.domain");
		String pre_port	  = Property.getProperty("wp.port");
		
		// 예전의 웹포탈 서비스 도메인을 삭제한다.
		Command rm_service = new Command();
		rm_service.runCmd(String.format(CmdString.delete_srv_dm, pre_domain + ":" + pre_port));
		rm_service.runCmd(String.format(CmdString.apply_srv));
		
		// 현재 설정을 불러온다.
		Command cmd = new Command();
	   cmd.runCmd("show sslvpn option");
	   String exit = cmd.getExitValue();
	   List<HashMap<String, String>> map = CLIParser.getInstance().parseAttr(exit, 5);
	   String prxserver = map.get(0).get("prxserver");
	   String prxport   = map.get(0).get("prxport");
	   String wp_domain = map.get(0).get("wp.domain");
	   String wp_port	= map.get(0).get("wp.port");
	   
	   // CLI로 서비스 도메인 등록
	   Command service = new Command();
	   service.runCmd(String.format(CmdString.add_srv_domain , 
			   wp_domain + ":" + wp_port , "http" , wp_domain , "WEBPORTAL" , "WEBPORTAL") );
	   service.runCmd(CmdString.apply_srv);
	   
	   // 프로파일 목록을 불러온다.
	   Command prp_cmd = new Command();
	   prp_cmd.runCmd(CmdString.s_profile);
	   List<HashMap<String, String>> prplist = CLIParser.getInstance().parseAttr( prp_cmd.getExitValue(), 7 );
	   
	   String[] prp = new String[prplist.size()];
	   
	   for ( int i = 0 ; i < prplist.size(); i++ )
	   {
		   prp[i] = prplist.get(i).get("prpname");
	   }
	   // 프로파일에 허용 도메인 적용
	   Command add_acv = new Command();
	   for (String prpname : prp)
	   {
		   add_acv.runCmd(String.format(CmdString.add_acc_srv, prpname , wp_domain + ":" + wp_port));
	   }
	   
	   // 웹 포탈 common.properties 파일을 수정한다.
	   Property.setProperty("prxserver", prxserver + ":" + prxport);
	   Property.setProperty("wp.domain", wp_domain);
		
//		// 메모리에 할당된 세션정보는 재시작시 모두 삭제 됨
//		
//		// dbclear 라는 이름을가진 타이머스레드를 생성 / 데몬 형식으로 돌아가게 한다.
//		Timer dbclear = new Timer("dbclear" ,true);
//		
//		int qu = dbclear.purge(); // qu -> 이 타이머에 있는 태스크 큐를 삭제 한다. 삭제된 갯수 
//		
//		// 현재 시간부터 10분을 주기로 스케줄 실행
//		dbclear.schedule(new ClearDatabase(), 0 , clear_time);
//		
		int wpcount = Integer.parseInt( Property.getProperty("wp.count") );
		
		String availableHost = null;
		
		for (int i = 0 ; i < wpcount ; i++)
		{
			boolean richf = TestRichable.test(Property.getProperty("wp.portal" + (i + 1)));
			if (richf) {
				availableHost = Property.getProperty("wp.portal" + (i + 1));
				break;
			}
		}
		
		if ( availableHost == null ) return;
		
		String url = null;
		
		url = "http://" + availableHost + "/process/sessionInitialize.jsp";
//		
		XMLManager xmlman = new XMLManager();
		
		// xml 문서 다른 웹포탈에서 호출, 파싱하여 db저장 및 메모리에 저장
		xmlman.readAndWrite(url);
	}
}
