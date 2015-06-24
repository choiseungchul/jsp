package wp.main;

import java.util.HashMap;
import java.util.List;

import wp.cli.CLIParser;
import wp.cli.CmdString;
import wp.cli.Command;
import wp.utils.Property;

public class PortalApply {
	
	/**
	 * GUI 에서 웹포탈 설정을 바꿨을시에 호출되는 클래스
	 * @param args
	 */
	public static void main(String args[])
	{
		Property.init("/secui/gui/MF2Tomcat/sslvpn/ROOT/");
		String pre_domain = Property.getProperty("wp.domain");
		String pre_port	  = Property.getProperty("wp.port");
		
		// 예전의 웹포탈 서비스 도메인을 삭제한다.
		Command rm_service = new Command();
		rm_service.runCmd(String.format(CmdString.delete_srv_dm, pre_domain + ":" + pre_port));
		rm_service.runCmd(String.format(CmdString.apply_srv));
		
		// 현재 설정을 불러온다.
		Command cmd1 = new Command();
	    cmd1.runCmd("show sslvpn option");
	    String exit1 = cmd1.getExitValue();
	    List<HashMap<String, String>> map1 = CLIParser.getInstance().parseAttr(exit1, 5);
	    String prxserver = map1.get(0).get("prxserver");
	    String prxport   = map1.get(0).get("prxport");
	    String wp_domain = map1.get(0).get("wp.domain");
	    String wp_port	= map1.get(0).get("wp.port");
	   
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
	    add_acv.runCmd(CmdString.apply_profile);
	    
	    // 웹 포탈 common.properties 파일을 수정한다.
	    Property.setProperty("prxserver", prxserver + ":" + prxport);
	    Property.setProperty("wp.domain", wp_domain);
		
	    // server.xml 파일을수정한다.
		XMLConfig.getInstance().setWPTomcat(wp_port, wp_domain);
		
	}
}
