package wp.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import wp.cli.CLIParser;
import wp.cli.CmdString;
import wp.cli.Command;
import wp.databean.ProfileDTO;
import wp.utils.Property;

public class ProfileDAO {
	
	private static ProfileDAO _ins = null;
	
	public static ProfileDAO getInstance()
	{
		if (_ins == null) return new ProfileDAO();
		else return _ins;
	}
	
	public List<ProfileDTO> getAllURL ()
	{
		List<ProfileDTO> list = new ArrayList<ProfileDTO>();
		
		String cmdstr = String.format(CmdString.s_domain);
		
		Command cmd = new Command();
		
		cmd.runCmd(cmdstr);
		
		String result = cmd.getExitValue();
		
		List<HashMap<String, String>> data = CLIParser.getInstance().parseAttr(result, 6);
		
		for (int i = 0 ; i < data.size() ; i++)
		{
			if (!data.get(i).get("domain").contains(Property.getProperty("wp.domain")))
			{
				ProfileDTO profile = new ProfileDTO();
				profile.SetData(data.get(i));
				list.add(profile);
			}
		}
		
		return list;
	}
	
	/**
	 * 프로파일명으로 등록된 프로파일목록을 불러온다.
	 * @param profilename			프로파일명
	 * @return						프로파일 URL 정보가 담겨있는 List<BookMarkDTO> 객체
	 */
	public List<ProfileDTO> getProfileURL (String profilename)
	{
		if (profilename == null) return null;
		
		List<ProfileDTO> list = new ArrayList<ProfileDTO>();
		
		String cmdstr = String.format(CmdString.user_profile, profilename);
		
		Command cmd = new Command();
		
		cmd.runCmd(cmdstr);
		
		String result = cmd.getExitValue();
		
		List<HashMap<String, String>> data = CLIParser.getInstance().parseAttr(result, 3);
		
		for (int i = 0 ; i < data.size() ; i++)
		{
			ProfileDTO profile = new ProfileDTO();
			profile.SetData(data.get(i));
			list.add(profile);
		}
		
		return list;
	}
	
}
