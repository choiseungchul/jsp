package wp.main;

import wp.cli.CmdString;
import wp.cli.Command;


/**
 * 
 * @author akrey
 * 메인화면 관련 클래스
 */
public class WPMain {
	
	public static boolean isUseCustomLoginPage()
	{
		boolean flag = false;
		
		Command cmd = new Command();

		cmd.runCmd(CmdString.login_page);
		
		String result = cmd.getExitValue();
		
		result = result.split("\n")[1];
		
		result = result.split("\\^")[0];
		
		if ( result.equals("Y")) flag = true;
		else if ( result.equals("N")) flag = false;
		
		return flag;
	}
	
}
