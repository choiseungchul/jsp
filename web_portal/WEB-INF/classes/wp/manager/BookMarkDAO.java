package wp.manager;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import wp.cli.CmdString;
import wp.cli.Command;
import wp.cli.CLIParser;
import wp.databean.BookMarkDTO;

/**
 * 북마크 관련 클래스
 * @author akrey
 *
 */
public class BookMarkDAO {
	
	// Sington pattern
	private static BookMarkDAO _ins = null;
	
	/**
	 * SingleTon 패턴
	 * @return			BookMarkDAO 객체
	 */
	public static BookMarkDAO getInstance()
	{
		if (_ins == null) return new BookMarkDAO();
		else return _ins;
	}
	
	/**
	 * 사용자 북마크 목록을 조회한다.
	 * @param userid				사용자 아이디	
	 * @return						사용자 북마크 목록 List<BookMarkDTO> 객체
	 */
	public List<BookMarkDTO> getUserBmk (String userid)
	{
		List<BookMarkDTO> list = new ArrayList<BookMarkDTO>();
		
		String cmdstr = String.format(CmdString.s_user_bmk, userid);
		
		Command cmd = new Command();
		
		cmd.runCmd(cmdstr);
		
		String result = cmd.getExitValue();
		
		List<HashMap<String, String>> data = CLIParser.getInstance().parseAttr(result, 2);
		
		for (int i = 0 ; i < data.size() ; i++)
		{
			BookMarkDTO bmk = new BookMarkDTO();
			bmk.SetData(data.get(i)); 
			list.add(bmk);
		}
		
		return list;
	}
	
	/**
	 * 시스템 북마크 목록을 조회한다.
	 * @param userid				사용자아이디
	 * @return						시스템 북마크 목록 List<BookMarkDTO> 객체
	 */
	public List<BookMarkDTO> getSysBmk(String userid)
	{
		List<BookMarkDTO> list = new ArrayList<BookMarkDTO>();
		
		String cmdstr = String.format(CmdString.s_default_bmk, userid);
		
		Command cmd = new Command();
		
		cmd.runCmd(cmdstr);
		
		String result = cmd.getExitValue();
		
		List<HashMap<String, String>> data = CLIParser.getInstance().parseAttr(result, 1);
		
		for (int i = 0 ; i < data.size() ; i++)
		{
			BookMarkDTO bmk = new BookMarkDTO();
			bmk.SetData(data.get(i));
			list.add(bmk);
		}
		
		return list;
	}
	
	/**
	 * 사용자 북마크 추가 
	 * @param userid				사용자 아이디
	 * @param name					북마크 이름
	 * @param url					북마크 URL
	 * @param desc					북마크 설명
	 * @return						0 리턴시 성공
	 */
	public int add(String userid ,String name, String url , String desc)
	{
		String u_name = null;
		String u_desc = null;
		
		try {
			u_name = URLEncoder.encode(name , "utf8");
			u_desc = URLEncoder.encode(desc , "utf8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String cmdstr = String.format(CmdString.add_bmk, userid, u_name ,url ,u_desc );
		
		Command cmd = new Command();
		
		cmd.runCmd( cmdstr );
		
		cmd.runCmd( String.format(CmdString.apply_user));
		
		return cmd.getExitcode();
	}
	
	/**
	 * 사용자 북마크 수정
	 * @param userid				사용자 아이디
	 * @param name					사용자 이름
	 * @param url					사용자 URL	
	 * @param desc					사용자 설명
	 * @return						0 리턴시 성공
	 */
	public int modify(String userid , String prename , String name , String url , String desc)
	{
		String u_name = null;
		String u_desc = null;
		String u_prename = null;
		
		try {
			u_name = URLEncoder.encode(name , "utf8");
			u_desc = URLEncoder.encode(desc , "utf8");
			u_prename = URLEncoder.encode(prename , "utf8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String cmdstr = String.format(CmdString.modify_bmk, userid , u_prename , u_name , url , u_desc);
		
		Command cmd = new Command();
		
		cmd.runCmd(cmdstr );
		
		cmd.runCmd( String.format(CmdString.apply_user));
		
		return cmd.getExitcode();
	}
	
	/**
	 * 사용자 북마크 삭제
	 * @param userid				사용자 아이디
	 * @param name					북마크 이름
	 * @return						성공 유무
	 */
	public int delete(String userid , String name)
	{
		String u_name = null;
		
		try {
			u_name = URLEncoder.encode(name , "utf8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String cmdstr = String.format(CmdString.delete_bmk, userid, u_name);
		
		Command cmd = new Command();
		
		cmd.runCmd( cmdstr );
		
		cmd.runCmd( String.format(CmdString.apply_user));
		
		return cmd.getExitcode();
	}
	
}
