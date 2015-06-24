package wp.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

/**
 * 관리자 정의 로그인페이지 로드 
 * @author akrey
 *
 */
public class LoginHTML {

	private String htmlpath = null;
	private String htmlformat = null;
	private String htmlEncoding = "UTF-8";
	private File f = null;
	
	private boolean traceOn = true;		

	public LoginHTML(String htmlpath) {
		
		this.htmlpath = htmlpath;
		this.f = new File(this.htmlpath);
	}

	/**
	 * 설정값을 읽어와서 HTML 파일을 로드
	 */
	public String outHTML() {
		
		StringBuilder html = new StringBuilder();

		if (!f.exists()) {
			trace(this.htmlpath + " 파일을 찾을수 없습니다.");
			return "";
		}
		else {
			try {
				InputStreamReader isr = new InputStreamReader(new FileInputStream(this.htmlpath), this.htmlEncoding);
				
				int inch = 0;
				
				while (true)
				{
					if ( ( inch = isr.read() )  != -1 )
					{
						html.append((char)inch);
					}
					else break;
				}
				isr.close();
				
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		this.htmlformat = html.toString();

		return this.htmlformat;
	}
	
	// HTML 디자인 파싱 -- 작성보류
	public String designParser(String html)
	{
		String completeHTML = null;
		
		String unparsedHTML = html.toString();
		
		int start = unparsedHTML.lastIndexOf("<form");
		int end   = unparsedHTML.indexOf("</form>");
		
		String top = unparsedHTML.substring(0 ,start);
		String bottom = unparsedHTML.substring(end , unparsedHTML.length());
		
		String ori = unparsedHTML.substring(start, end);
		
		// 대소문자가리지 않기 위해
		ori.toLowerCase();
	
		String exchanged = "";
		String[] htmlTag = ori.replaceAll("\r\n", "").replaceAll("\t", "").trim().split("><");
		
		//trace(ori.replaceAll("\r\n", "").replaceAll("\t", "").trim());
		
		trace("----------------------------------------------------------------------");
		
		for (int i = 0 ; i < htmlTag.length ; i++ )
		{
			if (htmlTag[i].startsWith("<form "))
			{
				htmlTag[i] = "<form action=\"process/userprc.jsp\" name=\"loginform\" id=\"loginform\" "+
						"\"method=\"post\" target=\"ifrm\">";
				// 히든값 
				htmlTag[i] += "<input type=\"hidden\" name=\"mode\" value=\"login\"";

			}else if (htmlTag[i].startsWith("input "))
			{
				if (htmlTag[i].contains("type=\"text\""))
				{
					trace(htmlTag[i]);
					
					String[] attr = htmlTag[i].split("\"");
					
					for ( int t = 1 ; t <= attr.length-1 ; t+=2)
					{
						if (attr[t].equals("name"))
						{
							attr[t+1] = "uid";
						}
					}
					
					String tmp = null;
					
					for ( String tt : attr)
					{
						tmp += tt + "\"";
					}
					
					trace(tmp);
					
					htmlTag[i] = tmp;
					
				}else if ( htmlTag[i].contains("type=\"password\""))
				{
					trace(htmlTag[i]);
					
					String[] attr = htmlTag[i].split("\"");
					
					for ( int t = 1 ; t <= attr.length-1 ; t+=2)
					{
						if (attr[t].equals("name"))
						{
							attr[t+1] = "pwd";
						}
					}
					
					String tmp = null;
					
					for ( String tt : attr)
					{
						tmp += tt + "\"";
					}
					
					trace(tmp);
					
					htmlTag[i] = tmp;
				}
			}
			
			if (i != htmlTag.length - 1 )
			{
				exchanged += htmlTag[i]+ "><";				
			}else{
			    exchanged = exchanged.substring(0, exchanged.length()-1);
			}
		}
		//trace(exchanged);
		
		completeHTML = top + exchanged + bottom;
	
		//trace (completeHTML);
		
		return completeHTML;
	}
	
	
	public String getHtmlEncoding() {
		return htmlEncoding;
	}

	public void setHtmlEncoding(String htmlEncoding) {
		this.htmlEncoding = htmlEncoding;
	}

	public String getHtmlpath() {
		return htmlpath;
	}

	public void setHtmlpath(String htmlpath) {
		this.htmlpath = htmlpath;
	}

	public String getHtmlformat() {
		return htmlformat;
	}

	public void setHtmlformat(String htmlformat) {
		this.htmlformat = htmlformat;
	}

	public void clear()
	{
		this.htmlformat = null;
	}
	
	private void trace(String str)
	{
		if (this.traceOn) System.out.println(str);
	}
}
