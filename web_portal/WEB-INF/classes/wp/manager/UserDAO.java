package wp.manager;

import wp.cli.CmdString;
import wp.cli.Command;

public class UserDAO {
	
	private static UserDAO _ins = null;
	
	public static UserDAO getInstance()
	{
		if (_ins == null) return new UserDAO();
		else return _ins;
	}
	
	/**
	 * 사용자 비밀번호 변경
	 * @param id				사용자아이디
	 * @param prepass			예전 비밀번호
	 * @param newpass			변경할 비밀번호
	 * @return					성공여부  0 => 실패 , 1 => 성공
	 */
	public int changePass(String id ,String prepass, String newpass)
	{
		int flag = -1;
		
		String chkstr = String.format(CmdString.checkpass, id ,prepass);
		
		Command chcmd = new Command();
		
		chcmd.runCmd(chkstr);
		
		String exitcode = chcmd.getExitValue();
		
		if ( exitcode.contains("OK"))
		{
			String expwd = String.format(CmdString.user, id, newpass);
			Command expwdcmd = new Command();
			expwdcmd.runCmd(expwd);
			
			if (expwdcmd.getExitValue().contains("OK")) {
				flag = 1;
				
				String apply = CmdString.apply_user;
				
				Command apl = new Command();
				apl.runCmd(apply);
			}
	
		}else if (exitcode.contains("ERROR"))
		{
			flag = 0;
		}
	
		return flag;
	}
	
}
